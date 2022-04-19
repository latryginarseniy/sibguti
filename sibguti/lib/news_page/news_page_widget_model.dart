import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sibguti/data/news.dart';

class NewsPageWidgetModel extends ChangeNotifier {
  Future<List<News>> get newsItems => getStudentList();

  NewsPageWidgetModel() {
    getStudentList();
  }

  Future<List<News>> getStudentList() async {
    var url = Uri.parse("http://alatryfd.beget.tech/news.php");
    final response = await http.get(url);
    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<News> newsItems = items.map<News>((json) {
      return News.fromJson(json);
    }).toList();

    return newsItems;
  }
}

class NewsPageWidgetModelProvider extends InheritedNotifier {
  final NewsPageWidgetModel model;
  final Widget child;

  const NewsPageWidgetModelProvider(
      {Key? key, required this.model, required this.child})
      : super(key: key, notifier: model, child: child);

  static NewsPageWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<NewsPageWidgetModelProvider>();
  }

  static NewsPageWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<NewsPageWidgetModelProvider>()
        ?.widget;
    return widget is NewsPageWidgetModelProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(NewsPageWidgetModelProvider oldWidget) {
    return true;
  }
}
