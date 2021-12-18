import 'package:flutter/material.dart';
import 'package:hamon_task/constants/app_constants.dart';
import 'package:hamon_task/constants/color_constants.dart';
import 'package:hamon_task/constants/styleconstants.dart';
import 'dart:convert';

import 'package:hamon_task/models/classrooms.dart';
import 'package:hamon_task/models/subjects.dart';
import 'package:hamon_task/provider/subjectProvider.dart';
import 'package:hamon_task/screens/classrooms/selectsubject.dart';
import 'package:hamon_task/screens/registerstudents/studentsInClass.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class UpdateClass extends StatefulWidget {
  var subid;
  Classrooms classroom;
  UpdateClass({Key key, this.classroom, this.subid}) : super(key: key);

  @override
  _UpdateClassState createState() => _UpdateClassState();
}

class _UpdateClassState extends State<UpdateClass> {
  SubjectProvider _subjectProvider;
  Future<List<Subjects>> subjts;

  Future updateCurrentSubject(val) async {
    String url = baseUrl +
        "/classrooms/" +
        "${widget.classroom.id}" +
        "?api_key=" +
        apikey;
    await http.patch(Uri.parse(url), body: {
      "subject": val,
    }, headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    }).then((value) {
      print(value.body);
      Navigator.of(context);
    });
  }

  Future fetchSubject() async {
    var subjectid;
    var subdetails;
    String url = baseUrl +
        "/classrooms/" +
        "${widget.classroom.id}" +
        "?api_key=" +
        apikey;
    http.Response response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      subjectid = data["subject"];
      String url =
          baseUrl + "/subjects/" + "${subjectid}" + "?api_key=" + apikey;
      http.Response response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });
      Map<String, dynamic> subject = jsonDecode(response.body);
      print(data.toString());
      subdetails = subject;
    }

    return subdetails;
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _subjectProvider = Provider.of<SubjectProvider>(context, listen: false);
    subjts = _subjectProvider.fetchSubjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        leading: BackButton(
          color: kSecondryColor,
        ),
        centerTitle: true,
        title: Text(widget.classroom.name),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                color: kSecondryColor,
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FutureBuilder(
                          future: fetchSubject(),
                          builder: (context, snap) {
                            if (!snap.hasData) {
                              return Column(
                                children: [
                                  Text("Please assign a subject",style: kNameInner,),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => SelectSub(
                                                classroom: widget.classroom,
                                              )));
                                    },
                                    child: Text('ADD SUBJECT',style: kNameInnerButtons,),
                                    style: ElevatedButton.styleFrom(
                                      shape: StadiumBorder(),
                                      primary: kPrimaryColor,

                                    ),
                                  ),
                                  Center(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(),
                                  ),),
                                ],
                              );
                            } else {
                              return Column(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text("Subject  : ",style: kNameInner,),
                                          SizedBox(width: 16,),
                                          Text(snap.data["name"],style: kNameInner,),

                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Teacher  : ",style: kNameInner,),
                                          SizedBox(width: 16,),
                                          Text(snap.data["teacher"],style: kNameInner,),

                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 22,),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => StudentsinClass(
                                                  subject: snap.data,classroom: widget.classroom,)));
                                    },
                                    child: Text('View Students',style: kNameInnerButtons,),
                                    style: ElevatedButton.styleFrom(
                                        shape: StadiumBorder(),
                                      primary: kPrimaryColor,

                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => SelectSub(
                                                classroom: widget.classroom,
                                              )));
                                    },
                                    child: Text('CHANGE SUBJECT',style: kNameInnerButtons,),
                                    style: ElevatedButton.styleFrom(
                                      shape: StadiumBorder(),
                                      primary: kPrimaryColor,

                                    ),
                                  ),
                                  // RaisedButton(
                                  //   onPressed: () {
                                  //
                                  //   },
                                  //   child: Text("View Students",),
                                  //   color: kPrimaryColor,
                                  //   shape: ,
                                  // ),
                                  // RaisedButton(
                                  //   onPressed: () {
                                  //     Navigator.push(
                                  //         context,
                                  //         MaterialPageRoute(
                                  //             builder: (context) => SelectSub(
                                  //                   classroom: widget.classroom,
                                  //                 )));
                                  //   },
                                  //   child: Text("CHANGE SUBJECT"),
                                  // ),
                                ],
                              );
                            }
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// Text(widget.classroom.name),
