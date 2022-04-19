import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import '../data/ads_course.dart';
import '../data/lecture.dart';

class ShowCoursePageWidgetModel extends ChangeNotifier {
  String id = 'Error';
  String name_course = 'Error';
  String description_course = 'Error';
  String teacher_course = 'Error';
  String number_course = 'Error';

  Future<List<AdsCourse>> get adsCourseItems => getAdsList();

  Future<List<Lecture>> get lectureItems => getLectureList();

  ShowCoursePageWidgetModel(
      {required this.id,
      required this.name_course,
      required this.description_course,
      required this.teacher_course,
      required this.number_course}) {
    getAdsList();
    getLectureList();
  }

  Future<List<AdsCourse>> getAdsList() async {
    var url = Uri.parse("http://alatryfd.beget.tech/showAdsCourse.php");

    var response = await http.post(url, body: {
      "course_id": id,
    });
    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<AdsCourse> adsCourseItems = items.map<AdsCourse>((json) {
      return AdsCourse.fromJson(json);
    }).toList();

    return adsCourseItems;
  }

  Future<List<Lecture>> getLectureList() async {
    var url = Uri.parse("http://alatryfd.beget.tech/showLectureCourse.php");
    var response = await http.post(url, body: {
      "course_id": id,
    });

    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Lecture> lectureItems = items.map<Lecture>((json) {
      return Lecture.fromJson(json);
    }).toList();

    return lectureItems;
  }

  void launchURL(String link_lecture) async {
    var link = link_lecture;
    var url = "http://alatryfd.beget.tech/uploads/$link";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class ShowCoursePageWidgetModelProvider extends InheritedNotifier {
  final ShowCoursePageWidgetModel model;
  final Widget child;

  const ShowCoursePageWidgetModelProvider(
      {Key? key, required this.model, required this.child})
      : super(key: key, notifier: model, child: child);

  static ShowCoursePageWidgetModelProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<
        ShowCoursePageWidgetModelProvider>();
  }

  static ShowCoursePageWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<
            ShowCoursePageWidgetModelProvider>()
        ?.widget;
    return widget is ShowCoursePageWidgetModelProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(ShowCoursePageWidgetModelProvider oldWidget) {
    return true;
  }
}
