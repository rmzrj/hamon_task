import 'package:flutter/material.dart';
import 'package:hamon_task/models/classrooms.dart';
import 'package:hamon_task/models/subjects.dart';
import 'package:hamon_task/provider/classroomprovider.dart';
import 'package:hamon_task/provider/studentsProvider.dart';
import 'package:hamon_task/provider/subjectProvider.dart';
import 'package:hamon_task/screens/studentslist.dart';
import 'package:provider/provider.dart';

class ClassRoomlist extends StatefulWidget {
  const ClassRoomlist({Key key}) : super(key: key);

  @override
  State<ClassRoomlist> createState() => _ClassRoomlistState();
}

class _ClassRoomlistState extends State<ClassRoomlist> {
   ClassRoomProvider _classRoomProvider;
   Future<List<Classrooms>> clssrms;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _classRoomProvider = Provider.of<ClassRoomProvider>(context, listen: false);
    clssrms = _classRoomProvider.fetchClassrooms();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FutureBuilder(
          future: clssrms,
          builder: (BuildContext context,AsyncSnapshot<List<Classrooms>> snapshot){
            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(),
              );
            }else{
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context,index){
                    return Card(child: Text(snapshot.data[index].name.toString()),);
                  });
            }

          },)


      ),
    );
  }
}
