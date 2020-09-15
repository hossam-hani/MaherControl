import 'dart:io';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart' as intl;
import 'package:maherteacher/questionnaire/QuestionnaireEditor.dart';
import 'package:maherteacher/services/firestore_service.dart';
import '../components/const.dart';
import '../components/drawer.dart';
import 'listOFLessons.dart';

import 'package:image_picker_web/image_picker_web.dart';



class ListOfSubjects extends StatefulWidget {

  final String typeOfSubjects;

  ListOfSubjects({this.typeOfSubjects});

  @override
  _QuestionnaireEditorState createState() => _QuestionnaireEditorState();
}

class _QuestionnaireEditorState extends State<ListOfSubjects> {
  String dropdownValue;
  var questioneares;
  bool isLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  getInitData() async{
    // get Data from Firesotre
    var tempQuestions = await FirestoreService().getSubjects(widget.typeOfSubjects);
    setState(() {
      questioneares = tempQuestions.documents;
    });
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

        Center(child: Text("المواد", style: TextStyle(fontWeight: FontWeight.bold, fontSize:25),),),
        SizedBox(height: 20,),
        Expanded(child: ListView(children: <Widget>[


         SizedBox(height: 25,),

          // SizedBox(width:500,
          // child : RaisedButton(
          //   elevation: 0,
          //   color: primaryColor,
          //   onPressed: (){
          //   Navigator.of(context)
          //   .push(new MaterialPageRoute(builder: (BuildContext context) => QuestionnaireEditor()));
          //   },
          //   child: Text("إضافة استبيان", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),)
          // ),

           SizedBox(height: 25,),

                  isLoading ?  Column(children: [

                  SizedBox(height: 40,),

                  SpinKitDoubleBounce	(
                  color: Colors.black,
                  size: 50.0,
                  )

                ],) : Column(children: [
                  ... questioneares.map<Widget>((e) => ListItem
                  (id: e.data["subjectId"],
                  grade : e.data["grade"],
                  title: e.data["subjectName"],
                  type: e.data["type"],)).toList(),
                ],),


        ],))
      ],),)
    ),
    ),
    );
  }
}


class ListItem extends StatelessWidget {

  final String id,title,type,grade;

  ListItem({this.id,this.title,this.type,this.grade});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
            Text("العنوان : " + title,style: TextStyle(fontWeight: FontWeight.bold),),
           grade == null ? SizedBox() : Text("السنة الدراسية : " + grade),

            type == "regular" || type == "tahsili"  ? SizedBox(width:500,
            child : RaisedButton(
              elevation: 0,
              color: primaryColor,
              onPressed: (){
                                print("here " + type);


              Navigator.of(context)
              .push(new MaterialPageRoute(builder: (BuildContext context) => ListOfLessons(subjectId: id,sem: 1,typeOfSubject: type,)));


              },
              child: Text("عرض دروس الفصل الاول", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),)
            ) : SizedBox(),

            type == "regular" || type == "tahsili" ? SizedBox(width:500,
            child : RaisedButton(
              elevation: 0,
              color: primaryColor,
              onPressed: (){
                print("here " + type);
              Navigator.of(context)
              .push(new MaterialPageRoute(builder: (BuildContext context) => ListOfLessons(subjectId: id,sem: 1,typeOfSubject: type,)));
              },
              child: Text("عرض دروس الفصل الثاني", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),)
            ) : SizedBox(),

            type == "qudrat" ? SizedBox(width:500,
            child : RaisedButton(
              elevation: 0,
              color: primaryColor,
              onPressed: (){
                                print("here " + type);

              Navigator.of(context)
              .push(new MaterialPageRoute(builder: (BuildContext context) => ListOfLessons(subjectId: id,sem: 0,typeOfSubject: type,)));
              },
              child: Text("عرض الدروس", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),)
            ) : SizedBox(),



          ],),
          // trailing: InkWell(
          //   child: FaIcon(FontAwesomeIcons.pen,size: 20,color: Colors.black,),
          //   onTap: (){
          //     Navigator.push(context,MaterialPageRoute(builder: (context) => QuestionnaireEditor(statusOfEditor: "edit",itemId: id,)),);
          //   }
          //   ,),
          ),
          Divider(),
    ],);
  }
}


