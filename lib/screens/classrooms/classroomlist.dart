import 'package:flutter/material.dart';
import 'package:hamon_task/constants/color_constants.dart';
import 'package:hamon_task/constants/styleconstants.dart';
import 'package:hamon_task/models/classrooms.dart';
import 'package:hamon_task/models/subjects.dart';
import 'package:hamon_task/provider/classroomprovider.dart';
import 'package:hamon_task/provider/subjectProvider.dart';
import 'package:hamon_task/screens/classrooms/updateclass.dart';
import 'package:provider/provider.dart';

class ClassRoomlist extends StatefulWidget {
  const ClassRoomlist({Key key}) : super(key: key);

  @override
  State<ClassRoomlist> createState() => _ClassRoomlistState();
}

class _ClassRoomlistState extends State<ClassRoomlist> {
  bool loading = false;
  ClassRoomProvider _classRoomProvider;
  Future<List<Classrooms>> clssrms;
  SubjectProvider _subjectProvider;
  Future<List<Subjects>> subjts;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _classRoomProvider = Provider.of<ClassRoomProvider>(context, listen: false);
    clssrms = _classRoomProvider.fetchClassrooms();
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
        title: Text("CLASSROOM"),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: FutureBuilder(
        future: clssrms,
        builder:
            (BuildContext context, AsyncSnapshot<List<Classrooms>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return (snapshot.data[index].layout == "classroom")
                      ? Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UpdateClass(
                                          classroom: snapshot.data[index])));
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(30.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(Icons.school,color: kSecondryColor,),
                                    Text(snapshot.data[index].name.toString(),style: kName,),
                                    Icon(Icons.arrow_forward_ios,color: kSecondryColor,),

                                  ],
                                ),
                              ),
                            ),
                          ),
                      )
                      : Visibility(visible: false, child: Text(""));
                });
          }
        },
      )),
    );
  }
}
