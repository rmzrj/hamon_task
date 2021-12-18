import 'package:flutter/material.dart';
import 'package:hamon_task/constants/color_constants.dart';
import 'package:hamon_task/constants/styleconstants.dart';
import 'package:hamon_task/models/students.dart';
import 'package:hamon_task/provider/studentsProvider.dart';
import 'package:provider/provider.dart';

import 'assignSubtoStudent.dart';

class AddStudents extends StatefulWidget {
  const AddStudents({Key key}) : super(key: key);

  @override
  _AddStudentsState createState() => _AddStudentsState();
}

class _AddStudentsState extends State<AddStudents> {
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
        title: Text("Select Student"),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FutureBuilder(
          future: studnts,
          builder:
              (BuildContext context, AsyncSnapshot<List<Students>> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                          child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                CircleAvatar(
                                    backgroundColor: kSecondryColor,
                                    child: Icon(
                                      Icons.person,
                                      color: kWhiteColor,
                                    )),
                              ],
                            ),
                            SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data[index].name.toString(),
                                  style: kName,
                                ),
                                Text(
                                  "Age : " +
                                      snapshot.data[index].age.toString(),
                                  style: kSub,
                                ),
                                Text(
                                  snapshot.data[index].email.toString(),
                                  style: kSub,
                                ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.end,
                                //   children: [
                                //
                                //   ],
                                // ),
                              ],
                            ),
                            Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AssignSubtoStdnt(
                                                  stdId: snapshot.data[index],
                                                )));                                  },
                                  child: Text('SELECT',style: kNameInnerButtons,),
                                  style: ElevatedButton.styleFrom(
                                    shape: StadiumBorder(),
                                    primary: kPrimaryColor,

                                  ),
                                ),



                              ],
                            )
                          ],
                        ),
                      )),
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}
