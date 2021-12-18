import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hamon_task/constants/color_constants.dart';
import 'package:hamon_task/constants/styleconstants.dart';
import 'package:hamon_task/screens/classrooms/classroom_select.dart';
import 'package:hamon_task/screens/registerstudents/registerpage.dart';
import 'package:hamon_task/screens/studentslist.dart';
import 'package:hamon_task/screens/subjectslist.dart';
class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Text("E Learning"),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: GridView.count(
            shrinkWrap: true,
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: [
              GestureDetector(
                onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentsList())),
                child: Card(
                  color: Color(0xff71cac6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(30.0),bottomLeft: Radius.circular(30.0)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                          backgroundColor: kWhiteColor,
                          child: Icon(Icons.person,color: Color(0xff71cac6),)),
                      SizedBox(height: 15,),

                      Text("Students",style: kHomeTitles),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>SubjectList())),
                child: Card(
                  color: kSecondryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0),bottomRight: Radius.circular(30.0)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                          backgroundColor: kWhiteColor,
                          child: Icon(Icons.book,color: kSecondryColor,)),
                      SizedBox(height: 15,),

                      Text("Subjects",style: kHomeTitles),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>ClassSelect())),
                child: Card(
                  color: Color(0xfff8af60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0),bottomRight: Radius.circular(30.0)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                          backgroundColor: kWhiteColor,
                          child: Icon(Icons.school,color: Color(0xfff8af60),)),
                      SizedBox(height: 15,),

                      Text("Classrooms",style: kHomeTitles),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterPage())),
                child: Card(
                  color: Color(0xff7471ca),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(30.0),bottomLeft: Radius.circular(30.0)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                          backgroundColor: kWhiteColor,
                          child: Icon(Icons.add,color: Color(0xff7471ca),)),
                      SizedBox(height: 15,),
                      Text("Register",style: kHomeTitles,),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
