import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart' as intl;
import 'package:maherteacher/services/firestore_service.dart';
import '../components/const.dart';
import '../components/drawer.dart';
import 'dart:math';


class UserEditor extends StatefulWidget {
  final String itemId,statusOfEditor;
  final subjects;

  UserEditor({this.itemId,this.statusOfEditor,this.subjects});

  @override
  _UserEditorState createState() => _UserEditorState();
}

class _UserEditorState extends State<UserEditor> {
  String dropdownValue;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // fields
  final fullName = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final introDescription = TextEditingController();
  String sex;
  String type;
  String nationality;
  Random random = new Random();


  final format = intl.DateFormat("yyyy-MM-dd HH:mm");
  bool isLoading = false;
  DateTime currentTime;
  var oldTime;
  
  doAction(){

    setState(() {
      isLoading = true;
    });


    if(widget.itemId == null){
      // FirestoreService().createQuestionnaire(title.text, linkOfQuestioner.text, linkOfResults.text, status, currentTime);
    }else{
      //  FirestoreService().updateQuestionnaire(widget.itemId,title.text, linkOfQuestioner.text, linkOfResults.text, status, currentTime);
    }

   setState(() {
      isLoading = false;
    });
  }

  getInitData() async{
    // get Data from Firesotre
    if(true){
      var tempQuestionar = await FirestoreService().getQuestionnaire(widget.itemId);

      setState(() {
        // title.text = tempQuestionar.data["title"];
        // linkOfQuestioner.text = tempQuestionar.data["link"];
        // linkOfResults.text = tempQuestionar.data["linkOfResults"];
        // status = tempQuestionar.data["status"] == "active" ? "مستمر" : "منتهي";
        // oldTime = tempQuestionar.data["date"];
      });

    }
    
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInitData();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: DrawerContent(),
      key: _scaffoldKey,
      body: Directionality(textDirection: TextDirection.rtl, child : 
      SafeArea(child: 
      Container(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
        child: Column(children: <Widget>[
          
        Row(children: [
          InkWell(
            onTap: (){
                _scaffoldKey.currentState.openEndDrawer();
            },
            child: FaIcon(FontAwesomeIcons.bars, color: primaryColor,),
            ),
            SizedBox(width: 10,),
          Text("لوحة التحكم") 
        ],),

        Center(child: Text(widget.statusOfEditor == "edit" ? "تعديل المستخدم" : "إضافة مستخدم جديد", style: TextStyle(fontWeight: FontWeight.bold, fontSize:25),),),
        SizedBox(height: 20,),
        Expanded(child: ListView(children: <Widget>[


            TextField(
            controller: fullName,
            decoration: InputDecoration(
              hintText: "الاسم كامل",
              disabledBorder: UnderlineInputBorder( borderSide: BorderSide(color: grayWhite),),
              focusedBorder: UnderlineInputBorder( borderSide: BorderSide(color: primaryColor),)
              ),
            ),

            TextField(
            controller: phone,
            decoration: InputDecoration(
              hintText: "رقم الجوال",
              disabledBorder: UnderlineInputBorder( borderSide: BorderSide(color: grayWhite),),
              focusedBorder: UnderlineInputBorder( borderSide: BorderSide(color: primaryColor),)
              ),
            ),


           TextField(
            controller: email,
            decoration: InputDecoration(
              hintText: "البريد الالكتروني",
              disabledBorder: UnderlineInputBorder( borderSide: BorderSide(color: grayWhite),),
              focusedBorder: UnderlineInputBorder( borderSide: BorderSide(color: primaryColor),)
              ),
            ),

            TextField(
            controller: introDescription,
            decoration: InputDecoration(
              hintText: "الوصف الترحيبي",
              disabledBorder: UnderlineInputBorder( borderSide: BorderSide(color: grayWhite),),
              focusedBorder: UnderlineInputBorder( borderSide: BorderSide(color: primaryColor),)
              ),
            ),

            SizedBox(height: 15,),
            
            Text("الجنس", style: TextStyle(fontWeight: FontWeight.bold, fontSize:15)),         

            DropdownButton<String>(
                  value: sex,
                  onChanged: (String newValue) {
                    setState(() {
                      sex = newValue;
                    });
                  },
                  items: <String>[ 'انثي', 'ذكر']
                    .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    })
                    .toList(),
            ),

            SizedBox(height: 10,),

            
            Text("الجنسية", style: TextStyle(fontWeight: FontWeight.bold, fontSize:15)),         

            DropdownButton<String>(
                  value: nationality,
                  onChanged: (String newValue) {
                    setState(() {
                      nationality = newValue;
                    });
                  },
                  items: <String>[ 'سعودي', 'مصري','سوداني']
                    .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    })
                    .toList(),
            ),


            Text("نوع الحساب", style: TextStyle(fontWeight: FontWeight.bold, fontSize:15)),         

            DropdownButton<String>(
                  value: type,
                  onChanged: (String newValue) {
                    setState(() {
                      type = newValue;
                    });
                  },
                  items: <String>['طالب','معلم']
                    .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    })
                    .toList(),
            ),

            Text("المواد", style: TextStyle(fontWeight: FontWeight.bold, fontSize:25)),         

            Divider(),

            Column(children: [
                  ... widget.subjects.map<Widget>((e) => ListTile(
                    leading: Checkbox(value: false,),
                    title:Text( e.data["subjectName"]),
           ))]),
           
            SizedBox(height: 10,),

          SizedBox(height: 25,),

          isLoading ? SpinKitSquareCircle(
            color: primaryColor,
            size: 50.0,
          ) :  SizedBox(width:500,
          child : RaisedButton(
            elevation: 0,
            color: primaryColor,
            onPressed: doAction,
            child: Text(widget.statusOfEditor == "edit" ? "تعديل المستخدم" : "إضافة المستخدم" , style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),)
          ),

        ],))
      ],),)
    ),
    ),
    );
  }
}


