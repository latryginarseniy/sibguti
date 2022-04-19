import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sibguti/data/schedule.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SchedulePageWidgetModel extends ChangeNotifier {
  Future<List<Schedule>> get newsItems => getStudentList();
  int daySelected = DateTime.now().weekday;
  SchedulePageWidgetModel() {
    getStudentList();
  }

  Future<List<Schedule>> getStudentList() async {
    final box = await Hive.openBox('personal_information');
    final university_group = box.get('university_group');

    var url = Uri.parse("http://alatryfd.beget.tech/schedule.php");

    final response = await http.post(url, body: {
      "number_group": university_group,
    });
    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Schedule> newsItems = items.map<Schedule>((json) {
      return Schedule.fromJson(json);
    }).toList();

    return newsItems;
  }
}

class SchedulePageWidgetModelProvider extends InheritedNotifier {
  final SchedulePageWidgetModel model;
  final Widget child;

  const SchedulePageWidgetModelProvider(
      {Key? key, required this.model, required this.child})
      : super(key: key, notifier: model, child: child);

  static SchedulePageWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SchedulePageWidgetModelProvider>();
  }

  static SchedulePageWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<
            SchedulePageWidgetModelProvider>()
        ?.widget;
    return widget is SchedulePageWidgetModelProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(SchedulePageWidgetModelProvider oldWidget) {
    return true;
  }
}
