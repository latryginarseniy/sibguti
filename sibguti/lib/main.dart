import 'package:flutter/material.dart';
import 'package:sibguti/preloader_page/preloader.dart';
import 'registration_page/registration_page_widget.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  runApp(const MyApp());
}
