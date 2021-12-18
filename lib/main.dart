import 'package:flutter/material.dart';
import 'package:hamon_task/provider/classroomprovider.dart';
import 'package:hamon_task/provider/registerProvider.dart';
import 'package:hamon_task/provider/studentsProvider.dart';
import 'package:hamon_task/provider/subjectProvider.dart';
import 'package:hamon_task/screens/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<StudentsProvider>(
            create: (context) => StudentsProvider()),
        ChangeNotifierProvider<SubjectProvider>(
            create: (context) => SubjectProvider()),
        ChangeNotifierProvider<ClassRoomProvider>(
            create: (context) => ClassRoomProvider()),
        ChangeNotifierProvider<RegisteredProvider>(
            create: (context) => RegisteredProvider()),
       ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            fontFamily: "Gilroy",
            canvasColor: Colors.transparent,
            appBarTheme: const AppBarTheme(
              color: Color(0xFFEEEEEE),
            ),
        ),
        home: HomePage(),
      ),
    );
  }
}

