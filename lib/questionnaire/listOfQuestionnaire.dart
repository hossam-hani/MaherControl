import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart' as intl;
import 'package:maherteacher/questionnaire/QuestionnaireEditor.dart';
import 'package:maherteacher/services/firestore_service.dart';
import '../components/const.dart';
import '../components/drawer.dart';
class ListOfQuestionnaire extends StatefulWidget {


  @override
  _QuestionnaireEditorState createState() => _QuestionnaireEditorState();
}

class _QuestionnaireEditorState extends State<ListOfQuestionnaire> {
  String dropdownValue;
  var questioneares;
  bool isLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  getInitData() async{
    // get Data from Firesotre
    var tempQuestions = await FirestoreService().getQuestionnaires();
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

        Center(child: Text("الاستبيانات", style: TextStyle(fontWeight: FontWeight.bold, fontSize:25),),),
        SizedBox(height: 20,),
        Expanded(child: ListView(children: <Widget>[


         SizedBox(height: 25,),

          SizedBox(width:500,
          child : RaisedButton(
            elevation: 0,
            color: primaryColor,
            onPressed: (){
            Navigator.of(context)
            .push(new MaterialPageRoute(builder: (BuildContext context) => QuestionnaireEditor()));
            },
            child: Text("إضافة استبيان", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),)
          ),

           SizedBox(height: 25,),

                  isLoading ?  Column(children: [

                  SizedBox(height: 40,),

                  SpinKitDoubleBounce	(
                  color: Colors.black,
                  size: 50.0,
                  )

                ],) : Column(children: [
                  ... questioneares.map<Widget>((e) => ListItem
                  (id: e.data["id"],
                  title: e.data["title"],
                  link: e.data["link"],)).toList(),
                ],),


        ],))
      ],),)
    ),
    ),
    );
  }
}


class ListItem extends StatelessWidget {

  final String id,title,link;

  ListItem({this.id,this.title,this.link});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
            Text("العنوان : " + title,style: TextStyle(fontWeight: FontWeight.bold),),
            Text("الرابط : " + link,style: TextStyle(fontWeight: FontWeight.bold),),

          ],),
          trailing: InkWell(
            child: FaIcon(FontAwesomeIcons.pen,size: 20,color: Colors.black,),
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context) => QuestionnaireEditor(statusOfEditor: "edit",itemId: id,)),);
            }
            ,),
          ),
          Divider(),
    ],);
  }
}


