import 'package:flutter/material.dart';
import 'components/const.dart';

class AddCompetition extends StatefulWidget {
  @override
  _AddCompetitionState createState() => _AddCompetitionState();
}

class _AddCompetitionState extends State<AddCompetition> {
  String dropdownValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:     Directionality(textDirection: TextDirection.rtl, child : 
    SafeArea(child: 
      Container(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
        child: Column(children: <Widget>[
        Center(child: Text("إضافة مسابقة جديدة", style: TextStyle(fontWeight: FontWeight.bold, fontSize:25),),),
        SizedBox(height: 20,),
        Expanded(child: ListView(children: <Widget>[

            TextField(
            decoration: InputDecoration(
              hintText: "العنوان",
              disabledBorder: UnderlineInputBorder( borderSide: BorderSide(color: grayWhite),),
              focusedBorder: UnderlineInputBorder( borderSide: BorderSide(color: primaryColor),)
              ),
              obscureText: true,
            ),

            TextField(
            decoration: InputDecoration(
              hintText: "رابط المسابقة",
              disabledBorder: UnderlineInputBorder( borderSide: BorderSide(color: grayWhite),),
              focusedBorder: UnderlineInputBorder( borderSide: BorderSide(color: primaryColor),)
              ),
            ),

            SizedBox(height: 20,),
            TextField(
            decoration: InputDecoration(
              hintText: "رابط النتيجة",
              disabledBorder: UnderlineInputBorder( borderSide: BorderSide(color: grayWhite),),
              focusedBorder: UnderlineInputBorder( borderSide: BorderSide(color: primaryColor),)
              ),
            ),


            SizedBox(height: 15,),
            
            Text("حالة المسابقة", style: TextStyle(fontWeight: FontWeight.bold, fontSize:15)),         



            DropdownButton<String>(
                  value: 'مستمرة',
                  onChanged: (String newValue) {
                    // setState(() {
                    //   // dropdownValue = newValue;
                    // });
                  },
                  items: <String>[ 'بانتظار النتيجة', 'مستمرة','منتهية','ملغية']
                    .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    })
                    .toList(),
            ),

          SizedBox(width:500,
          child : RaisedButton(
            elevation: 0,
            color: primaryColor,
            onPressed: (){},
            child: Text("حفظ المسابقة", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),)
          ),

        ],))
      ],),)
    ),
    ),
    );
  }
}


