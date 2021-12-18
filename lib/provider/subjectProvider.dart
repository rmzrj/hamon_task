import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hamon_task/constants/app_constants.dart';
import 'package:hamon_task/models/subjects.dart';
import 'package:http/http.dart' as http;

class SubjectProvider extends ChangeNotifier {
  List<Subjects> subjectlist = [];
//* Fetch Subjects
  Future<List<Subjects>> fetchSubjects() async {
    String url = baseUrl + "/subjects/?api_key=" + apikey;
    http.Response response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    Map<String, dynamic> data = jsonDecode(response.body);
    List<Subjects> _fetcheddata = [];
    for (int i = 0; i < data["subjects"].length; i++) {
      _fetcheddata.add(Subjects.fromJson(data["subjects"][i]));
    }
    return _fetcheddata;
  }
}
