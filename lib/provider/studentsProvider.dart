import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hamon_task/constants/app_constants.dart';
import 'package:hamon_task/models/students.dart';
import 'package:http/http.dart' as http;

class StudentsProvider extends ChangeNotifier {
  List<Students> studentslist = [];

//* Fetch Students
  Future<List<Students>> fetchStudents() async {
    String url = baseUrl + "/students/?api_key=" + apikey;
    http.Response response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    Map<String, dynamic> data = jsonDecode(response.body);
    print(data.toString());
    List<Students> _fetcheddata = [];
    for (int i = 0; i < data["students"].length; i++) {
      _fetcheddata.add(Students.fromJson(data["students"][i]));
    }
    return _fetcheddata;
  }
}
