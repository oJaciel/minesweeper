import 'package:flutter/material.dart';
import 'package:minesweeper/screens/minesweeper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Minesweeper', home: Minesweeper());
  }
}
