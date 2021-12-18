import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hamon_task/constants/app_constants.dart';
import 'package:hamon_task/models/registermodel.dart';
import 'package:http/http.dart' as http;

class RegisteredProvider extends ChangeNotifier {
  Registermodel registermodels = Registermodel();

  Future<Registermodel> registerDetails() async {
    Registermodel registermodel = Registermodel();
    String url = baseUrl + "/registration/?api_key=" + apikey;
    http.Response response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      registermodel = Registermodel.fromJson(data);
    }
    print(registermodel.registrations[0].student);
    return registermodel;
  }
}
