
import 'package:flutter/material.dart';
import 'package:hamon_task/constants/app_constants.dart';
import 'package:hamon_task/constants/color_constants.dart';
import 'package:hamon_task/constants/styleconstants.dart';
import 'package:hamon_task/models/registermodel.dart';
import 'package:hamon_task/models/students.dart';
import 'package:hamon_task/provider/registerProvider.dart';
import 'package:hamon_task/provider/studentsProvider.dart';
import 'package:hamon_task/screens/registerstudents/addstudent.dart';
import 'package:hamon_task/screens/registerstudents/regdetails.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisteredProvider registeredProvider;
  Future<Registermodel> registermodel;
  StudentsProvider _studentsProvider;
  Future<List<Students>> studnts;



 @override
 void didChangeDependencies() {
   super.didChangeDependencies();
   registeredProvider = Provider.of<RegisteredProvider>(context, listen: false);
   registermodel = registeredProvider.registerDetails();
   _studentsProvider = Provider.of<StudentsProvider>(context, listen: false);
   studnts = _studentsProvider.fetchStudents();
 }
   Future deleteRegstrtion(id) async {
     String url = baseUrl +
         "/registration/"+id+
         "?api_key=" +
         apikey;
     final response = await http.delete(Uri.parse(url),
         );
     if(response.statusCode == 200){
       print("success");
     }else{
       print(response.body.toString());
     }
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
        title: Text("REGISTER"),
      ),
      backgroundColor: Colors.white,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: kSecondryColor,
          onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> AddStudents()));
          },
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: registermodel,
          builder: (BuildContext context,AsyncSnapshot<Registermodel> regmodel){
            if(!regmodel.hasData){
              return Center(
                child: CircularProgressIndicator(),
              );
            }else {
              return ListView.builder(
                  itemCount: regmodel.data.registrations.length,
                  itemBuilder: (context,index){
                    return GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> RegDetails(id:regmodel.data.registrations[index],deleteId:regmodel.data.registrations[index].id.toString())));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Reg Id : "+regmodel.data.registrations[index].id.toString(),style: kName,),
                                  IconButton(onPressed: (){
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> RegDetails(id:regmodel.data.registrations[index],deleteId:regmodel.data.registrations[index].id.toString())));

                                  }, icon: Icon(Icons.arrow_forward_ios,color: kSecondryColor,) )
                                ],
                              ),
                            )),
                      ),
                    );
                  }

              );
            }

          },
        ),
      ),
    );
  }
}
