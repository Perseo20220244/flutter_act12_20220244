import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:act12_20220244/screens/home.dart';

Future<void> main() async {
  await Hive.initFlutter();

  await Hive.openBox('favoritos');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
