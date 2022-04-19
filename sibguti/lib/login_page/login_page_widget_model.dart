import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sibguti/data/user.dart';
import '../bottom_navigation_bar/bottom_navigation_bar_widget.dart';

class LoginPageWidgetModel extends ChangeNotifier {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future login(BuildContext context) async {
    if (email.text.length < 8) {
      return;
      // const SnackBar(
      //   content: Text(
      //     'Длинна почты не может быть меньше 8',
      //     style: TextStyle(
      //         fontFamily: 'MontserratMedium',
      //         color: Colors.white,
      //         fontSize: 12,
      //         fontWeight: FontWeight.bold),
      //   ),
      // );
    }
    if (password.text.length < 8) {
      return;
      // const SnackBar(
      //   content: Text(
      //     'Длинна паролья не может быть меньше 8',
      //     style: TextStyle(
      //         fontFamily: 'MontserratMedium',
      //         color: Colors.white,
      //         fontSize: 12,
      //         fontWeight: FontWeight.bold),
      //   ),
      // );
    }
    var url = "http://alatryfd.beget.tech/login.php";
    var response = await http.post(Uri.parse(url), body: {
      "email": email.text,
      "password": password.text,
    });

    final box = await Hive.openBox('personal_information');

    var data = await json.decode(json.encode(response.body));

    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<User> getItems = items.map<User>((json) {
      return User.fromJson(json);
    }).toList();

    if (data == "\"Error\"") {
      return const SnackBar(
        content: Text(
          'Неправильный логин или пароль',
          style: TextStyle(
              fontFamily: 'MontserratMedium',
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold),
        ),
      );
    } else {
      box.put('id', getItems[0].id);
      box.put('name', getItems[0].name);
      box.put('email', getItems[0].email);
      box.put('password', getItems[0].password);
      box.put('university_group', getItems[0].university_group);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const BottomNavigationBarWidget()),
      );
    }
  }
}

class LoginPageWidgetModelProvider extends InheritedNotifier {
  final LoginPageWidgetModel model;
  final Widget child;

  const LoginPageWidgetModelProvider(
      {Key? key, required this.model, required this.child})
      : super(key: key, notifier: model, child: child);

  static LoginPageWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<LoginPageWidgetModelProvider>();
  }

  static LoginPageWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<LoginPageWidgetModelProvider>()
        ?.widget;
    return widget is LoginPageWidgetModelProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(LoginPageWidgetModelProvider oldWidget) {
    return true;
  }
}
