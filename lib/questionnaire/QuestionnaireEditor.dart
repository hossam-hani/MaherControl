import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart' as intl;
import 'package:maherteacher/services/firestore_service.dart';
import '../components/const.dart';
import '../components/drawer.dart';
class QuestionnaireEditor extends StatefulWidget {
  final String itemId,statusOfEditor;

  QuestionnaireEditor({this.itemId,this.statusOfEditor});

  @override
  _QuestionnaireEditorState createState() => _QuestionnaireEditorState();
}

class _QuestionnaireEditorState extends State<QuestionnaireEditor> {
  String dropdownValue;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // fields
  final title = TextEditingController();
  final linkOfQuestioner = TextEditingController();
  final linkOfResults = TextEditingController();
  String status;
  final format = intl.DateFormat("yyyy-MM-dd HH:mm");
  bool isLoading = false;
  DateTime currentTime;
  var oldTime;
  
  doAction(){

    setState(() {
      isLoading = true;
    });


    if(widget.itemId == null){
      FirestoreService().createQuestionnaire(title.text, linkOfQuestioner.text, linkOfResults.text, status, currentTime);
    }else{
       FirestoreService().updateQuestionnaire(widget.itemId,title.text, linkOfQuestioner.text, linkOfResults.text, status, currentTime);
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
        title.text = tempQuestionar.data["title"];
        linkOfQuestioner.text = tempQuestionar.data["link"];
        linkOfResults.text = tempQuestionar.data["linkOfResults"];
        status = tempQuestionar.data["status"] == "active" ? "مستمر" : "منتهي";
        oldTime = tempQuestionar.data["date"];
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

        Center(child: Text(widget.statusOfEditor == "edit" ? "تعديل الاستبيان" : "إضافة استبيان جديد", style: TextStyle(fontWeight: FontWeight.bold, fontSize:25),),),
        SizedBox(height: 20,),
        Expanded(child: ListView(children: <Widget>[


            TextField(
            controller: title,
            decoration: InputDecoration(
              hintText: "العنوان",
              disabledBorder: UnderlineInputBorder( borderSide: BorderSide(color: grayWhite),),
              focusedBorder: UnderlineInputBorder( borderSide: BorderSide(color: primaryColor),)
              ),
            ),

            TextField(
            controller: linkOfQuestioner,
            decoration: InputDecoration(
              hintText: "رابط الاستبيان",
              disabledBorder: UnderlineInputBorder( borderSide: BorderSide(color: grayWhite),),
              focusedBorder: UnderlineInputBorder( borderSide: BorderSide(color: primaryColor),)
              ),
            ),

            TextField(
            controller: linkOfResults,
            decoration: InputDecoration(
              hintText: "رابط النتيجة",
              disabledBorder: UnderlineInputBorder( borderSide: BorderSide(color: grayWhite),),
              focusedBorder: UnderlineInputBorder( borderSide: BorderSide(color: primaryColor),)
              ),
            ),

            SizedBox(height: 20,),

            SizedBox(height: 15,),
            
            Text("حالة الاستبيان", style: TextStyle(fontWeight: FontWeight.bold, fontSize:15)),         



            DropdownButton<String>(
                  value: status,
                  onChanged: (String newValue) {
                    setState(() {
                      status = newValue;
                    });
                  },
                  items: <String>[ 'منتهي', 'مستمر']
                    .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    })
                    .toList(),
            ),

            SizedBox(height: 10,),

            oldTime == null ? SizedBox() : Text(DateTime.fromMicrosecondsSinceEpoch(oldTime.microsecondsSinceEpoch).toString()) ,

        DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
          if (date != null) {
            final time = await showTimePicker(
              context: context,
              initialTime:
                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            );
            setState(() {
             currentTime = DateTimeField.combine(date, time);
            });
            return DateTimeField.combine(date, time);
          } else {
            setState(() {
             currentTime = currentValue;
            });

            return currentValue;
          }
        },
      ),

      SizedBox(height: 25,),

          isLoading ? SpinKitSquareCircle(
            color: primaryColor,
            size: 50.0,
          ) :  SizedBox(width:500,
          child : RaisedButton(
            elevation: 0,
            color: primaryColor,
            onPressed: doAction,
            child: Text(widget.statusOfEditor == "edit" ? "تعديل الاستبيان" : "إضافة الاستبيان" , style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),)
          ),

        ],))
      ],),)
    ),
    ),
    );
  }
}


