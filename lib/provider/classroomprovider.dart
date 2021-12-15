import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hamon_task/constants/app_constants.dart';
import 'package:hamon_task/models/classrooms.dart';
import 'package:http/http.dart' as http;

class ClassRoomProvider extends ChangeNotifier {
  List<Classrooms> classroomlist = [];

//* Fetch Classrooms
  Future<List<Classrooms>> fetchClassrooms() async {
    String url = baseUrl + "/classrooms/?api_key=" + apikey;
    http.Response response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    Map<String, dynamic> data = jsonDecode(response.body);
    print(data.toString());
    List<Classrooms> _fetcheddata = [];
    for (int i = 0; i < data["classrooms"].length; i++) {
      _fetcheddata.add(Classrooms.fromJson(data["classrooms"][i]));
    }
    return _fetcheddata;
  }
}
