import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import '../bottom_navigation_bar/bottom_navigation_bar_widget.dart';
import '../registration_page/registration_page_widget.dart';

class PreloaderPageWidgetModel extends ChangeNotifier {
  PreloaderPageWidgetModel(BuildContext context) {
    openWithSaveData(context);
  }

  Future openWithSaveData(BuildContext context) async {
    final box = await Hive.openBox('personal_information');

    var email_save = box.get('email');
    var password_save = box.get('password');

    if (email_save != null && password_save != null) {
      var url = "http://alatryfd.beget.tech/login.php";
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
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const RegistrationPageWidget()));
      }
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const RegistrationPageWidget()));
    }
  }
}

class PreloaderPageWidgetModelProvider extends InheritedNotifier {
  final PreloaderPageWidgetModel model;
  final Widget child;

  const PreloaderPageWidgetModelProvider(
      {Key? key, required this.model, required this.child})
      : super(key: key, notifier: model, child: child);

  static PreloaderPageWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<PreloaderPageWidgetModelProvider>();
  }

  static PreloaderPageWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<
            PreloaderPageWidgetModelProvider>()
        ?.widget;
    return widget is PreloaderPageWidgetModelProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(PreloaderPageWidgetModelProvider oldWidget) {
    return true;
  }
}
