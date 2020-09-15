import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart' as intl;
import 'package:maherteacher/questionnaire/QuestionnaireEditor.dart';
import 'package:maherteacher/services/firestore_service.dart';
import '../components/const.dart';
import '../components/drawer.dart';
import 'UserEditor.dart';
class ListOfUser extends StatefulWidget {


  @override
  _QuestionnaireEditorState createState() => _QuestionnaireEditorState();
}

class _QuestionnaireEditorState extends State<ListOfUser> {
  String dropdownValue;
  var questioneares;
  var subjects;
  bool isLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  

  getInitData() async{
    // get Data from Firesotre
      var subjectstemp = await FirestoreService().getSubjects("all");
    var tempQuestions = await FirestoreService().getUsers();

    setState(() {
      questioneares = tempQuestions.documents;
      subjects = subjectstemp.documents;
    });

    print(subjects);

  }

  @override
  void initState() {
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

        Center(child: Text("المستخدمين", style: TextStyle(fontWeight: FontWeight.bold, fontSize:25),),),
        SizedBox(height: 20,),
        Expanded(child: ListView(children: <Widget>[


         SizedBox(height: 25,),

          SizedBox(width:500,
          child : RaisedButton(
            elevation: 0,
            color: primaryColor,
            onPressed: (){
            Navigator.of(context)
            .push(new MaterialPageRoute(builder: (BuildContext context) => UserEditor(subjects: subjects,)));
            },
            child: Text("إضافة مستخدم جديد", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),)
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
                  fullName: e.data["fullName"],
                  phone: e.data["phone"],
                  email: e.data["email"],
                  type: e.data["type"],
                  
                  )).toList(),
                ],),


        ],))
      ],),)
    ),
    ),
    );
  }
}


class ListItem extends StatelessWidget {

  final String id,fullName,phone,type,email;

  ListItem({this.id,this.fullName,this.phone,this.type,this.email});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
            fullName != null ? Text("الاسم : " + fullName,style: TextStyle(fontWeight: FontWeight.bold),) : SizedBox(),
            phone != null ? Text("رقم الجوال : " + phone,style: TextStyle(fontWeight: FontWeight.bold),) : SizedBox(),
            email != null ? Text("البريد الالكتروني : " + email,style: TextStyle(fontWeight: FontWeight.bold),) : SizedBox(),
            type != null ? Text("نوع الحساب : " + type,style: TextStyle(fontWeight: FontWeight.bold),) : SizedBox(),

          ],),
          trailing: InkWell(
            child: FaIcon(FontAwesomeIcons.pen,size: 20,color: Colors.black,),
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context) => UserEditor(statusOfEditor: "edit",itemId: id,)),);
            }
            ,),
          ),
          Divider(),
          Divider(),
              ],);
  }
}


