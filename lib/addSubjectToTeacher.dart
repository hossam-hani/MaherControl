import 'package:flutter/material.dart';
import 'components/const.dart';

class AddSubjectsToTeacher extends StatefulWidget {
  @override
  _AddSubjectsToTeacherState createState() => _AddSubjectsToTeacherState();
}

class _AddSubjectsToTeacherState extends State<AddSubjectsToTeacher> {
  String dropdownValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:     Directionality(textDirection: TextDirection.rtl, child : 
    SafeArea(child: 
      Container(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
        child: Column(children: <Widget>[
        Center(child: Text("تعديل المعلم", style: TextStyle(fontWeight: FontWeight.bold, fontSize:25),),),
        SizedBox(height: 20,),
        Expanded(child: ListView(children: <Widget>[





            SizedBox(height: 15,),
            
            Text("المادة", style: TextStyle(fontWeight: FontWeight.bold, fontSize:15)),         

            TextField(
            decoration: InputDecoration(
              hintText: "اسم المعلم",
              disabledBorder: UnderlineInputBorder( borderSide: BorderSide(color: grayWhite),),
              focusedBorder: UnderlineInputBorder( borderSide: BorderSide(color: primaryColor),)
              ),
            ),

            TextField(
            decoration: InputDecoration(
              hintText: "البريد الالكتروني",
              disabledBorder: UnderlineInputBorder( borderSide: BorderSide(color: grayWhite),),
              focusedBorder: UnderlineInputBorder( borderSide: BorderSide(color: primaryColor),)
              ),
            ),

            SizedBox(height: 20,),

              Text("المواد السابقة", style: TextStyle(fontWeight: FontWeight.bold, fontSize:15)),         
            SizedBox(height: 20,),

            Row(children: [
              
              Text("علوم - المرحلة المتوسطة", style: TextStyle(fontWeight: FontWeight.bold, fontSize:15)),
              SizedBox(width: 10,),
              FlatButton(onPressed: (){}, child: Text("حذف المادة")),

            ],),

            
            Row(children: [
              

            DropdownButton<String>(
                  value: 'رياضيات',
                  onChanged: (String newValue) {
                    // setState(() {
                    //   // dropdownValue = newValue;
                    // });
                  },
                  items: <String>[  'قدرات','فيزياء','رياضيات']
                    .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    })
                    .toList(),
            ),
                          SizedBox(width: 10,),
              FlatButton(onPressed: (){}, child: Text("إضافة")),

            ],),



          SizedBox(width:500,
          child : RaisedButton(
            elevation: 0,
            color: primaryColor,
            onPressed: (){},
            child: Text("حفظ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),)
          ),

        ],))
      ],),)
    ),
    ),
    );
  }
}


