import 'package:flutter/material.dart';
import 'package:hamon_task/models/classrooms.dart';
import 'package:hamon_task/provider/classroomprovider.dart';
import 'package:provider/provider.dart';

class ConferenceList extends StatefulWidget {
  const ConferenceList({Key key}) : super(key: key);

  @override
  State<ConferenceList> createState() => _ConferenceListState();
}

class _ConferenceListState extends State<ConferenceList> {
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
                  return (snapshot.data[index].layout == "conference")
                      ? Card(
                          child: Text(snapshot.data[index].name.toString()),
                        )
                      : Visibility(visible: false, child: Text(""));
                });
          }
        },
      )),
    );
  }
}
