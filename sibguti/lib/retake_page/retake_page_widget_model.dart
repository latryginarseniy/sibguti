import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../data/retake.dart';

class RetakePageWidgetModel extends ChangeNotifier {
  Future<List<Retake>> get newsItems => getRetakeList();

  RetakePageWidgetModel() {
    getRetakeList();
  }

  Future<List<Retake>> getRetakeList() async {
    var url = Uri.parse("http://alatryfd.beget.tech/showRetake.php");

    final box = await Hive.openBox('personal_information');
    final university_group = box.get('university_group');
    final response = await http.post(url, body: {
      "number_group": university_group,
    });

    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Retake> newsItems = items.map<Retake>((json) {
      return Retake.fromJson(json);
    }).toList();

    return newsItems;
  }
}

class RetakePageWidgetModelProvider extends InheritedNotifier {
  final RetakePageWidgetModel model;
  final Widget child;

  const RetakePageWidgetModelProvider(
      {Key? key, required this.model, required this.child})
      : super(key: key, notifier: model, child: child);

  static RetakePageWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<RetakePageWidgetModelProvider>();
  }

  static RetakePageWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<
            RetakePageWidgetModelProvider>()
        ?.widget;
    return widget is RetakePageWidgetModelProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(RetakePageWidgetModelProvider oldWidget) {
    return true;
  }
}
