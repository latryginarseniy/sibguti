import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import '../bottom_navigation_bar/bottom_navigation_bar_widget.dart';

class RegistrationPageWidgetModel extends ChangeNotifier {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController university_group = TextEditingController();

  RegistrationPageWidgetModel(BuildContext context) {
    openWithSaveData(context);
  }

  Future openWithSaveData(BuildContext context) async {
    final box = await Hive.openBox('personal_information');

    var email_save = box.get('email');
    var password_save = box.get('password');

    if (email_save != null && password_save != null) {
      var url = "http://alatryfd.beget.tech/autoLogin.php";
      var response = await http.post(Uri.parse(url), body: {
        "email": email_save,
        "password": password_save,
      });

      var data = await json.decode(json.encode(response.body));
      if (data == "\"Success\"") {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const BottomNavigationBarWidget()));
      }
    }
  }

  Future register(BuildContext context) async {
    var url = "http://alatryfd.beget.tech/registration.php";
    var response = await http.post(Uri.parse(url), body: {
      "name": name.text,
      "email": email.text,
      "password": password.text,
      "university_group": university_group.text,
    });

    final box = await Hive.openBox('personal_information');
    var data = await json.decode(json.encode(response.body));

    if (data == "\"Success\"") {
      box.put('name', name.text);
      box.put('email', email.text);
      box.put('password', password.text);
      box.put('university_group', university_group.text);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const BottomNavigationBarWidget()),
      );
    } else if (data == "\"Error\"") {
      return const SnackBar(
        content: Text(
          'Такой пользователь уже существует',
          style: TextStyle(
              fontFamily: 'MontserratMedium',
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold),
        ),
      );
    } else {
      return const SnackBar(
        content: Text(
          'Неизвестная ошибка',
          style: TextStyle(
              fontFamily: 'MontserratMedium',
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold),
        ),
      );
    }
  }
}

class RegistrationPageWidgetModelProvider extends InheritedNotifier {
  final RegistrationPageWidgetModel model;
  final Widget child;

  const RegistrationPageWidgetModelProvider(
      {Key? key, required this.model, required this.child})
      : super(key: key, notifier: model, child: child);

  static RegistrationPageWidgetModelProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<
        RegistrationPageWidgetModelProvider>();
  }

  static RegistrationPageWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<
            RegistrationPageWidgetModelProvider>()
        ?.widget;
    return widget is RegistrationPageWidgetModelProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(RegistrationPageWidgetModelProvider oldWidget) {
    return true;
  }
}
