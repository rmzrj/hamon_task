import 'package:flutter/material.dart';
import 'package:hamon_task/screens/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          fontFamily: "Gilroy",
          canvasColor: Colors.transparent,
          appBarTheme: const AppBarTheme(
            color: Color(0xFFEEEEEE),
          ),
      ),
      home: HomePage(),
    );
  }
}

