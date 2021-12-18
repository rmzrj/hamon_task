import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hamon_task/constants/app_constants.dart';
import 'package:hamon_task/constants/color_constants.dart';
import 'package:hamon_task/constants/styleconstants.dart';
import 'package:hamon_task/screens/classrooms/classroom_select.dart';
import 'package:hamon_task/screens/classrooms/classroomlist.dart';
import 'package:hamon_task/screens/classrooms/updateclass.dart';
import 'package:hamon_task/screens/home_page.dart';
import 'package:hamon_task/screens/registerstudents/registerpage.dart';
import 'package:hamon_task/screens/registerstudents/studentsInClass.dart';
import 'package:hamon_task/snackBar.dart';
import 'package:http/http.dart' as http;

class StdDetails extends StatefulWidget {
  var id;
  var deleteId;
  StdDetails({Key key,this.id,this.deleteId}) : super(key: key);

  @override
  _StdDetailsState createState() => _StdDetailsState();
}

class _StdDetailsState extends State<StdDetails> {
  Future fetchSinglestdnt() async {
    var student;
    String url = baseUrl+"/students/"+"${widget.id.student}"+"?api_key="+apikey;
    http.Response response = await http.get(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    print(data.toString());
    student =data;
    return student;
  }
  Future fetchSingleSub() async {
    var student;
    String url = baseUrl+"/subjects/"+"${widget.id.subject}"+"?api_key="+apikey;
    http.Response response = await http.get(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    print(data.toString());
    student =data;
    return student;
  }
  Future deleteRegstrtion(id) async {
    String url = baseUrl +
        "/registration/"+id+
        "?api_key=" +
        apikey;
    final response = await http.delete(Uri.parse(url),
    );
    if(response.statusCode == 200){
      showSnackBar(message: "Student Removed", context: context);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ClassSelect()));
      print("success");
    }else{
      print(response.body.toString());
    }
  }




  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    fetchSinglestdnt();
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
        title: Text("STUDENT"),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Card(
                color: kSecondryColor,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FutureBuilder(
                            future: fetchSinglestdnt(),
                            builder: (context,snap){
                              if(!snap.hasData){
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }else{
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Reg Id : ",style: kNameInner1,),
                                            Text("Name : ",style: kNameInner1,),
                                            Text("Age : ",style: kNameInner1),
                                            Text("Email : ",style: kNameInner1)
                                          ],
                                        ),
                                        SizedBox(width: 8,),

                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(widget.id.id.toString(),style: kNameInner1,),
                                            Text(snap.data["name"],style: kNameInner1),
                                            Text(snap.data["age"].toString(),style: kNameInner1),
                                            Text(snap.data["email"],style: kNameInner1),
                                          ],
                                        )
                                      ],
                                    ),

                                  ],
                                );
                              }
                            },
                          ),
                          FutureBuilder(
                            future: fetchSingleSub(),
                            builder: (context,snap){
                              if(!snap.hasData){
                                return Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }else{
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Subject : ",style: kNameInner1),
                                            Text("Teacher : ",style: kNameInner1),
                                          ],
                                        ),
                                        SizedBox(width: 8,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(snap.data["name"],style: kNameInner1),
                                            Text(snap.data["teacher"],style: kNameInner1),
                                          ],
                                        )
                                      ],
                                    ),

                                  ],
                                );
                              }
                            },
                          ),
                          SizedBox(height: 20,),
                          ElevatedButton(
                            onPressed: () {
                              deleteRegstrtion(widget.id.id.toString());
                            },
                            child: Text('REMOVE STUDENT',style: kNameInnerButtons,),
                            style: ElevatedButton.styleFrom(
                              shape: StadiumBorder(),
                              primary: kPrimaryColor,

                            ),
                          ),

                        ],
                      ),
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
