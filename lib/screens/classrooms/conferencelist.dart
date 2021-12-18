import 'package:flutter/material.dart';
import 'package:hamon_task/constants/color_constants.dart';
import 'package:hamon_task/constants/styleconstants.dart';
import 'package:hamon_task/models/classrooms.dart';
import 'package:hamon_task/provider/classroomprovider.dart';
import 'package:hamon_task/screens/classrooms/updateclass.dart';
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
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        leading: BackButton(
          color: kSecondryColor,
        ),
        centerTitle: true,
        title: Text("CONFERENCE"),
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
                  return (snapshot.data[index].layout == "conference")
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
