import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../login_page/login_page_widget.dart';

class UniversityPageWidgetModel extends ChangeNotifier {
  void logOut(BuildContext context) async {
    final box = await Hive.openBox('personal_information');

    box.delete('email');
    box.delete('password');
    box.delete('name');
    box.delete('university_group');

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const LoginPageWidget()));
  }
}

class UniversityPageWidgetModelProvider extends InheritedNotifier {
  final UniversityPageWidgetModel model;
  final Widget child;

  const UniversityPageWidgetModelProvider(
      {Key? key, required this.model, required this.child})
      : super(key: key, notifier: model, child: child);

  static UniversityPageWidgetModelProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<
        UniversityPageWidgetModelProvider>();
  }

  static UniversityPageWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<
            UniversityPageWidgetModelProvider>()
        ?.widget;
    return widget is UniversityPageWidgetModelProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(UniversityPageWidgetModelProvider oldWidget) {
    return true;
  }
}
