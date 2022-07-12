import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/view/movies/movies.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        scaffoldBackgroundColor: const Color(0xfff6f6f6),
        primaryColor: const Color(0xFF4e54c8),
        brightness: Brightness.light,
        hintColor: Colors.white70,
      ),
      home: const Movies(),
    );
  }
}
