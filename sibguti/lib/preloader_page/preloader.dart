import 'package:flutter/material.dart';
import 'package:sibguti/preloader_page/preloader_model.dart';
import '../registration_page/registration_page_widget.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'СибГУТИ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Palette.kToDark),
      home: const PreloaderPageWidget(),
    );
  }
}

class PreloaderPageWidget extends StatefulWidget {
  const PreloaderPageWidget({Key? key}) : super(key: key);

  @override
  State<PreloaderPageWidget> createState() => _PreloaderPageWidgetState();
}

class _PreloaderPageWidgetState extends State<PreloaderPageWidget> {
  @override
  Widget build(BuildContext context) {
    final _model = PreloaderPageWidgetModel(context);
    return PreloaderPageWidgetModelProvider(
        model: _model, child: const _PreloaderPageWidgetBody());
  }
}

class _PreloaderPageWidgetBody extends StatelessWidget {
  const _PreloaderPageWidgetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
    );
  }
}

class Palette {
  static const MaterialColor kToDark = MaterialColor(
    0xff0d47a1,
    <int, Color>{
      50: Color(0xff0d47a1),
      100: Color(0xff0d47a1),
      200: Color(0xff0d47a1),
      300: Color(0xff0d47a1),
      400: Color(0xff0d47a1),
      500: Color(0xff0d47a1),
      600: Color(0xff0d47a1),
      700: Color(0xff0d47a1),
      800: Color(0xff0d47a1),
      900: Color(0xff0d47a1),
    },
  );
}
