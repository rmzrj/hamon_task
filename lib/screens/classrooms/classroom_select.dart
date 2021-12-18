import 'package:flutter/material.dart';
import 'package:hamon_task/constants/color_constants.dart';
import 'package:hamon_task/constants/styleconstants.dart';
import 'package:hamon_task/screens/classrooms/classroomlist.dart';
import 'package:hamon_task/screens/classrooms/conferencelist.dart';
class ClassSelect extends StatelessWidget {
  const ClassSelect({Key key}) : super(key: key);

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
        child: Center(
          child: GridView.count(
            shrinkWrap: true,
            primary: false,
            padding: const EdgeInsets.all(80),
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            crossAxisCount: 1,
          children: [
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ClassRoomlist()));
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                color: kSecondryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Classroom",style: kHomeTitles,),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ConferenceList()));

              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                color: Color(0xff7471ca),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Conference",style: kHomeTitles,),
                  ],
                ),
              ),
            ),
          ],
          )
        ),
      ),
    );
  }
}
