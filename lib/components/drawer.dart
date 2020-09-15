
import 'package:flutter/material.dart';
import 'package:maherteacher/subjects/listOfSubjectjs.dart';
import '../questionnaire/listOfQuestionnaire.dart';
import '../competitions/listOfCompetitions.dart';
import '../users/listOfUser.dart';

class DrawerContent extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {
    return Drawer(child: 
    Directionality(
      textDirection: TextDirection.rtl,
          child: Column(children: <Widget>[
          SizedBox(height: 20,),

              InkWell(
                child: ListTile(title: Text("المستخدمين")),

                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context) => ListOfUser()),);

                },
              ),

            InkWell(
              child: ListTile(title: Text("الدروس")),

              onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListOfSubjects(typeOfSubjects: "regular",)),
                  );
              },
              ),

            InkWell(
              child: ListTile(title: Text("القدرات")),

              onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListOfSubjects(typeOfSubjects: "qudrat",)),
                  );
              },
              ),


            InkWell(
              child: ListTile(title: Text("التحصيلي")),

              onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListOfSubjects(typeOfSubjects: "tahsili",)),
                  );
              },
              ),

              

            InkWell(
              child: ListTile(title: Text("الاستبيانات")),

                onTap: (){
                 Navigator.push(context,MaterialPageRoute(builder: (context) => ListOfQuestionnaire()),);

                },
              ),

              InkWell(
                child: ListTile(title: Text("المسابقات")),

                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context) => ListOfCompetition()),);

                },
              ),

            // InkWell(
            //   child: ListTile(title: Text("تسجيل الخروج")),

            //   onTap: () async{
            //     return await FirebaseAuth.instance.signOut();
            //   },

            // ),
            Divider(),


            // InkWell(
            //   child: ListTile(title: Text("إضافة نشاط تجاري")),
              
            //   onTap: (){
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (context) => AddShop()),
            //       );
            //   },


            // ),
            // Divider(),

            // InkWell(
            //   child: ListTile(title: Text("إتصل بالدعم"))
            // ),
            // Divider(),

            // InkWell(
            //   child: ListTile(title: Text("تواصل مع الدعم من خلال الواتساب"))
            // ),
            // Divider(),
          
      ],),
    ),
    );
  }
}