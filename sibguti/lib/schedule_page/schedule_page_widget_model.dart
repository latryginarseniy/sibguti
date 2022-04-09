import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SchedulePageWidgetModel extends ChangeNotifier {}

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
