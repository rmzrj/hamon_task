import 'package:flutter/material.dart';
import 'package:hamon_task/constants/color_constants.dart';
import 'package:hamon_task/constants/styleconstants.dart';
import 'package:hamon_task/models/registermodel.dart';
import 'package:hamon_task/provider/registerProvider.dart';
import 'package:hamon_task/screens/classrooms/addStudentClass.dart';
import 'package:hamon_task/screens/classrooms/stdntdetails.dart';
import 'package:hamon_task/screens/registerstudents/regdetails.dart';
import 'package:provider/provider.dart';
class StudentsinClass extends StatefulWidget {
  var subject;
  var classroom;
  StudentsinClass({Key key,this.subject,this.classroom}) : super(key: key);

  @override
  _StudentsinClassState createState() => _StudentsinClassState();
}

class _StudentsinClassState extends State<StudentsinClass> {
  RegisteredProvider registeredProvider;
  Future<Registermodel> registermodel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    registeredProvider = Provider.of<RegisteredProvider>(context, listen: false);
    registermodel = registeredProvider.registerDetails();

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
        title: Text(widget.classroom.name),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: kSecondryColor,
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> AddStudentsClass(subject:widget.subject,classroom:widget.classroom)));
        },
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FutureBuilder(
          future: registermodel,
          builder: (BuildContext context,AsyncSnapshot<Registermodel> regmodel){
            if(!regmodel.hasData){
              return Center(
                child: CircularProgressIndicator(),
              );
            }else{
              return ListView.builder(
                  itemCount: regmodel.data.registrations.length,
                  itemBuilder: (context,index){
                    return regmodel.data.registrations[index].subject == widget.subject["id"] ?
                    GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>StdDetails(id:regmodel.data.registrations[index],)));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.person,color: kSecondryColor,),
                                  SizedBox(width: 15,),
                                  Text("Reg Id : "+regmodel.data.registrations[index].id.toString(),style: kName,),
                                ],
                              ),

                              Icon(Icons.arrow_forward_ios,color: kSecondryColor,)
                            ],
                          ),
                        )),
                      ),
                    ):Visibility(visible:false,child: Text("data"));
                  });
            }

          },
        ),
      ),
    );
  }
}
