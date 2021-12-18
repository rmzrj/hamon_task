import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hamon_task/constants/color_constants.dart';
import 'package:hamon_task/constants/styleconstants.dart';
import 'package:hamon_task/models/students.dart';
import 'package:hamon_task/provider/studentsProvider.dart';
import 'package:provider/provider.dart';

class StudentsList extends StatefulWidget {
  const StudentsList({Key key}) : super(key: key);

  @override
  State<StudentsList> createState() => _StudentsListState();
}

class _StudentsListState extends State<StudentsList> {
   StudentsProvider _studentsProvider;
   Future<List<Students>> studnts;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _studentsProvider = Provider.of<StudentsProvider>(context, listen: false);
    studnts = _studentsProvider.fetchStudents();
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
        title: Text("STUDENTS"),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: FutureBuilder(
          future: studnts,
          builder: (BuildContext context,AsyncSnapshot<List<Students>> snapshot){
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator());
            } else{
              return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(child:  Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                CircleAvatar(
                                    backgroundColor: kSecondryColor,
                                    child: Icon(Icons.person,color: kWhiteColor,)),
                              ],
                            ),
                            SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(snapshot.data[index].name.toString(),style: kName,),
                                Text("Age : "+snapshot.data[index].age.toString(),style: kSub,),
                                Text(snapshot.data[index].email.toString(),style: kSub,),
                              ],
                            ),

                          ],
                        ),
                      )),
                    );
                  });
            }

          },)
      ),
    );
  }
}
