import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hamon_task/constants/color_constants.dart';
import 'package:hamon_task/constants/styleconstants.dart';
import 'package:hamon_task/models/subjects.dart';
import 'package:hamon_task/provider/subjectProvider.dart';
import 'package:provider/provider.dart';

class SubjectList extends StatefulWidget {
  const SubjectList({Key key}) : super(key: key);

  @override
  State<SubjectList> createState() => _SubjectListState();
}

class _SubjectListState extends State<SubjectList> {
   SubjectProvider _subjectProvider;
   Future<List<Subjects>> subjts;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
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
        title: Text("SUBJECTS"),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
         child: FutureBuilder(
          future: subjts,
          builder: (BuildContext context,AsyncSnapshot<List<Subjects>> snapshot){
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator());
            }else{
              return ListView.builder(
                 physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Icon(Icons.book,size: 32,color: kSecondryColor,),
                              ],
                            ),
                            SizedBox(width: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(snapshot.data[index].name.toString(),style: kName,),
                                SizedBox(height: 5,),
                                Text("Teacher : "+snapshot.data[index].teacher.toString(),style: kSub,),

                              ],
                            ),

                          ],
                        ),
                      ),),
                    );
                  });
            }

          },)
      
      ),
    );
  }
}
