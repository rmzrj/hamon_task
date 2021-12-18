import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hamon_task/constants/app_constants.dart';
import 'package:hamon_task/constants/color_constants.dart';
import 'package:hamon_task/constants/styleconstants.dart';
import 'package:hamon_task/models/subjects.dart';
import 'package:hamon_task/provider/subjectProvider.dart';
import 'package:hamon_task/screens/classrooms/updatedclassroom.dart';
import 'package:hamon_task/snackBar.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class SelectSub extends StatefulWidget {
  var classroom;
  SelectSub({Key key, this.classroom}) : super(key: key);

  @override
  State<SelectSub> createState() => _SelectSubState();
}

class _SelectSubState extends State<SelectSub> {
  bool loading = false;
  SubjectProvider _subjectProvider;
  Future<List<Subjects>> subjts;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _subjectProvider = Provider.of<SubjectProvider>(context, listen: false);
    subjts = _subjectProvider.fetchSubjects();
  }

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
    });
  }

  var subjectid;
  Future fetchSubId() async {
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
    print(data["subject"].toString());
    subjectid = data["subject"];

    return subjectid;
  }

  var subdetails;
  Future fetchSingleSub(val) async {
    String url = baseUrl + "/subjects/" + "${val}" + "?api_key=" + apikey;
    http.Response response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    Map<String, dynamic> data = jsonDecode(response.body);
    print(data.toString());
    if(response.statusCode == 200){
      showSnackBar(message: "Subject Updated", context: context);
      subdetails = data;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  UpdatedClassroom(
                    val: data,
                    classroom: widget.classroom,
                  )));
    }
    return data;
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
        child: FutureBuilder(
          future: subjts,
          builder:
              (BuildContext context, AsyncSnapshot<List<Subjects>> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              return loading ? Center(child: CircularProgressIndicator()) : ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Icon(Icons.book,size: 32,color: kSecondryColor,),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(snapshot.data[index].name.toString(),style: kName,),
                                  SizedBox(height: 5,),
                                  Text("Teacher : "+snapshot.data[index].teacher.toString(),style: kSub,),

                                ],
                              ),
                              Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        loading = true;
                                      });
                                      updateCurrentSubject(
                                          snapshot.data[index].id.toString())
                                          .then((value) => fetchSubId())
                                          .then((value) => fetchSingleSub(value));
                                    },
                                    child: Text('Select',style: kNameInnerButtons,),
                                    style: ElevatedButton.styleFrom(
                                      shape: StadiumBorder(),
                                      primary: kPrimaryColor,

                                    ),
                                  ),

                                ],
                              )

                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
          },
        ),
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    loading = false;
  }
}
