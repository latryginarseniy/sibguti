import 'package:flutter/material.dart';

class OpenNewsPageWidgetModel extends ChangeNotifier {}

class OpenNewsPageWidgetModelProvider extends InheritedNotifier {
  final OpenNewsPageWidgetModel model;
  final Widget child;

  const OpenNewsPageWidgetModelProvider(
      {Key? key, required this.model, required this.child})
      : super(key: key, notifier: model, child: child);

  static OpenNewsPageWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<OpenNewsPageWidgetModelProvider>();
  }

  static OpenNewsPageWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<
            OpenNewsPageWidgetModelProvider>()
        ?.widget;
    return widget is OpenNewsPageWidgetModelProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(OpenNewsPageWidgetModelProvider oldWidget) {
    return true;
  }
}
