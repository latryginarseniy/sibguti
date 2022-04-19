import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../data/course.dart';

class CoursePageWidgetModel extends ChangeNotifier {
  Future<List<Course>> get newsItems => getStudentList();

  CoursePageWidgetModel() {
    getStudentList();
  }

  Future<List<Course>> getStudentList() async {
    var url = Uri.parse("http://alatryfd.beget.tech/showCourse.php");
    final response = await http.get(url);
    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Course> newsItems = items.map<Course>((json) {
      return Course.fromJson(json);
    }).toList();

    return newsItems;
  }
}

class CoursePageWidgetModelProvider extends InheritedNotifier {
  final CoursePageWidgetModel model;
  final Widget child;

  const CoursePageWidgetModelProvider(
      {Key? key, required this.model, required this.child})
      : super(key: key, notifier: model, child: child);

  static CoursePageWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<CoursePageWidgetModelProvider>();
  }

  static CoursePageWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<
            CoursePageWidgetModelProvider>()
        ?.widget;
    return widget is CoursePageWidgetModelProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(CoursePageWidgetModelProvider oldWidget) {
    return true;
  }
}
