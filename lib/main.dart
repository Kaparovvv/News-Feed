import 'package:flutter/material.dart';
import 'package:news_feed/internal/appliacation.dart';
import 'package:news_feed/utils/dependencies_injection.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}
