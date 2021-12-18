import 'package:flutter/material.dart';
import 'package:hamon_task/constants/app_constants.dart';
import 'package:hamon_task/constants/color_constants.dart';
import 'package:hamon_task/constants/styleconstants.dart';
import 'package:hamon_task/models/subjects.dart';
import 'package:hamon_task/provider/subjectProvider.dart';
import 'package:hamon_task/screens/registerstudents/registerpage.dart';
import 'package:hamon_task/snackBar.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AssignSubtoStdnt extends StatefulWidget {
  var stdId;
  AssignSubtoStdnt({Key key, this.stdId}) : super(key: key);

  @override
  _AssignSubtoStdntState createState() => _AssignSubtoStdntState();
}

class _AssignSubtoStdntState extends State<AssignSubtoStdnt> {
  bool loading = false;

  SubjectProvider _subjectProvider;
  Future<List<Subjects>> subjts;

  Future registerStudents(subid) async {
    String url = baseUrl + "/registration/" + "?api_key=" + apikey;
    final response = await http.post(Uri.parse(url),
        body: {"student": widget.stdId.id.toString(), "subject": subid},
        headers: {"Content-Type": "application/x-www-form-urlencoded"});
    if (response.statusCode == 200) {
      print("success");
      showSnackBar(message: "Registration Success ", context: context);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RegisterPage()));
    } else {
      setState(() {
        loading = false;
      });
      showSnackBar(message: response.body.toString(), context: context);
      print(response.body.toString());
    }
  }

  @override
  void didChangeDependencies() {
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
        title: Text("Assign a Subject"),
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
                                      registerStudents(
                                        snapshot.data[index].id.toString(),
                                      );

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


        // child: Column(
        //   children: [
        //     Text(widget.stdId.name),
        //     RaisedButton(onPressed: () {
        //       // showModalBottomSheet(
        //       //     backgroundColor: Colors.white,
        //       //     context: context,
        //       //     builder: (builder) {
        //       //       return FutureBuilder(
        //       //         future: subjts,
        //       //         builder: (BuildContext context,
        //       //             AsyncSnapshot<List<Subjects>> snapshots) {
        //       //           if (!snapshots.hasData) {
        //       //             return Center(child: CircularProgressIndicator());
        //       //           } else {
        //       //             return ListView.builder(
        //       //                 physics: BouncingScrollPhysics(),
        //       //                 itemCount: snapshots.data.length,
        //       //                 itemBuilder: (context, index) {
        //       //                   return Padding(
        //       //                     padding: const EdgeInsets.all(8.0),
        //       //                     child: Card(
        //       //                       child: Padding(
        //       //                         padding: const EdgeInsets.all(18.0),
        //       //                         child: Row(
        //       //                           mainAxisAlignment:
        //       //                               MainAxisAlignment.spaceBetween,
        //       //                           children: [
        //       //                             Text(
        //       //                               snapshots.data[index].name
        //       //                                   .toString(),
        //       //                             ),
        //       //                             RaisedButton(
        //       //                               onPressed: () {
        //       //                                 registerStudents(
        //       //                                   snapshots.data[index].id
        //       //                                       .toString(),
        //       //                                 );
        //       //                               },
        //       //                               child: Text("Add"),
        //       //                             )
        //       //                           ],
        //       //                         ),
        //       //                       ),
        //       //                     ),
        //       //                   );
        //       //                 });
        //       //           }
        //       //         },
        //       //       );
        //       //     });
        //     })
        //   ],
        // ),
      ),
    );
  }
}
