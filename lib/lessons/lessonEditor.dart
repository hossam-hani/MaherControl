import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../components/const.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../components/navbar.dart';
import 'package:image_picker_web/image_picker_web.dart';

class LessonEditor extends StatefulWidget {

  String subjectID,typeOfSubject;

  LessonEditor({this.subjectID,this.typeOfSubject});

  @override
  _LessonEditorState createState() => _LessonEditorState();
}

class _LessonEditorState extends State<LessonEditor> {

  int numberOfQuestion = 0;

  List<Map>  question = [];
  Image image;
  
  

  uploadImage() async {
    Image fromPicker = await ImagePickerWeb.getImage(outputType: ImageType.widget);
    if (fromPicker != null) {
      setState(() {
        image = fromPicker;
      });
    }
  }

  addLesson() async {
  }

  getFile() async{
    File file = await FilePicker.getFile();
  }

    final _formKey = GlobalKey<FormState>();
  final title = TextEditingController();
  final link = TextEditingController();
  final atachment = TextEditingController();

  String dropdownValue;
  @override
  Widget build(BuildContext context) {
    print(widget.typeOfSubject);
    return Scaffold(body:     Directionality(textDirection: TextDirection.rtl, child : 
    SafeArea(child: 
      Container(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
        child: Form(
        key: _formKey,
        child: Column(children: <Widget>[

          Navbar(),

          Center(child: Text("إضافة درس جديد", style: TextStyle(fontWeight: FontWeight.bold, fontSize:25),),),
          // Center(child: Text(widget.documentOfSubject["subjectName"], style: TextStyle(fontWeight: FontWeight.bold, fontSize:15, color: gray),),),
          SizedBox(height: 20,),
          Expanded(child: ListView(children: <Widget>[

          // SizedBox(height: 10,),
          // Text("المهارة", style: TextStyle(fontWeight: FontWeight.bold, fontSize:15)),         


          // Row(children: <Widget>[
          //   Expanded(child: DropdownButton<String>(
          //       value: 'متميز',
          //       onChanged: (String newValue) {
          //         // setState(() {
          //         //   // dropdownValue = newValue;
          //         // });
          //       },
          //       items: <String>[ 'متوسط', 'المبتدئ','متفوق','متميز','عبقيري']
          //         .map<DropdownMenuItem<String>>((String value) {
          //           return DropdownMenuItem<String>(
          //             value: value,
          //             child: Text(value),
          //           );
          //         })
          //         .toList(),
          // ),)
          // ],),

              TextFormField(
                controller: title,
              decoration: InputDecoration(
                hintText: "عنوان الدرس",
                disabledBorder: UnderlineInputBorder( borderSide: BorderSide(color: grayWhite),),
                focusedBorder: UnderlineInputBorder( borderSide: BorderSide(color: primaryColor),)
                ),
                // obscureText: true,
              ),

              TextFormField(
                controller: link,
              decoration: InputDecoration(
                hintText: "رابط الدرس",
                disabledBorder: UnderlineInputBorder( borderSide: BorderSide(color: grayWhite),),
                focusedBorder: UnderlineInputBorder( borderSide: BorderSide(color: primaryColor),)
                ),
              ),

          // FlatButton(
          //     onPressed: getFile,
          //     child: Text(
          //         'اختيار المرفقات',
          //         style: TextStyle(color: Colors.blue),
          //     )),

              TextFormField(
                controller: atachment,
              decoration: InputDecoration(
                hintText: "المرفقات",
                disabledBorder: UnderlineInputBorder( borderSide: BorderSide(color: grayWhite),),
                focusedBorder: UnderlineInputBorder( borderSide: BorderSide(color: primaryColor),)
                ),
              ),

              SizedBox(height: 15,),
              
              Text("اتاحة تحميل الدرس", style: TextStyle(fontWeight: FontWeight.bold, fontSize:15)),         

              DropdownButton<String>(
                    value: 'مفعلة',
                    onChanged: (String newValue) {
                      // setState(() {
                      //   // dropdownValue = newValue;
                      // });
                    },
                    items: <String>[ 'معطلة', 'مفعلة']
                      .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      })
                      .toList(),
              ),

              
             SizedBox(height: 15,),
              
              Text("حالة التعليقات", style: TextStyle(fontWeight: FontWeight.bold, fontSize:15)),         

              DropdownButton<String>(
                    value: 'مفعلة',
                    onChanged: (String newValue) {
                      // setState(() {
                      //   // dropdownValue = newValue;
                      // });
                    },
                    items: <String>[ 'معطلة', 'مفعلة']
                      .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      })
                      .toList(),
              ),


          SizedBox(height: 15,),
          
          Text("حالة الدرس", style: TextStyle(fontWeight: FontWeight.bold, fontSize:15)),         


          DropdownButton<String>(
                value: 'مباشر',
                onChanged: (String newValue) {
                  // setState(() {
                  //   // dropdownValue = newValue;
                  // });
                },
                items: <String>[ 'مباشر', 'مسجل']
                  .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  })
                  .toList(),
          ),


          
          SizedBox(height: 10,),
          Text("نوع محتوي الدرس", style: TextStyle(fontWeight: FontWeight.bold, fontSize:15)),         


          DropdownButton<String>(
                value: 'فيديو',
                onChanged: (String newValue) {
                  // setState(() {
                  //   // dropdownValue = newValue;
                  // });
                },
                items: <String>[ 'صورة', 'فيديو','powerpoint','word','excel','pdf']
                  .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  })
                  .toList(),
          ),

                  
          SizedBox(height: 10,),
          Text("إتاحة تحميل الدروس", style: TextStyle(fontWeight: FontWeight.bold, fontSize:15)),         

          DropdownButton<String>(
                value: 'مفعلة',
                onChanged: (String newValue) {
                  // setState(() {
                  //   // dropdownValue = newValue;
                  // });
                },
                items: <String>[ 'معطلة', 'مفعلة']
                  .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  })
                  .toList(),
          ),

          TextField(
          decoration: InputDecoration(
            hintText: "السعر",
            disabledBorder: UnderlineInputBorder( borderSide: BorderSide(color: grayWhite),),
            focusedBorder: UnderlineInputBorder( borderSide: BorderSide(color: primaryColor),)
            ),
          ),

          SizedBox(height: 15,),

          Text("موعد عرض الدرس", style: TextStyle(fontWeight: FontWeight.bold, fontSize:15)),         

          FlatButton(
              onPressed: () {
                  DatePicker.showDateTimePicker(context,
                                        showTitleActions: true,
                                        minTime: DateTime(2018, 3, 5),
                                        maxTime: DateTime(2021, 6, 7), onChanged: (date) {
                                      print('change $date');
                                    }, onConfirm: (date) {
                                      print('confirm $date');
                                    }, currentTime: DateTime.now()
                                    );
              },
              child: Text(
                  'تحديد الموعد',
                  style: TextStyle(color: Colors.blue),
              )),

             


            Divider(),

            SizedBox(height: 20,),
            Center(child: Text("الاسئلة", style: TextStyle(fontWeight: FontWeight.bold, fontSize:25),),),
            SizedBox(width:200,
            child : RaisedButton(
              elevation: 0,
              color: Colors.green,
              onPressed: (){
                              setState(() {
                  numberOfQuestion++;
                });

              //    var newQuestion = {
              //     "answers" : [
              //       {"text" : "","image" : ""},
              //     {"text" : "","image" : ""},
              //     {"text" : "","image" : ""},
              //       {"text" : "","image" : ""},
              //     ],
              //     "image" : "",
              //     "text" : "",
              //     "questionId" : "",
              //     "correctAnswer" : 3,
              //     "skillName" : "", // just for qudrat
              //     "skillCode" : 1 // just for qudrat
              //   };

              //   newQuestion["skillName"] = "";
              //   newQuestion["skillCode"] = "";

              //   question.add(newQuestion);

              },

              child: Text("إضافة سؤال جديد", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),)
            ),



            Container(
              height: 350,
              child: ListView.builder(
              itemCount: numberOfQuestion,
              itemBuilder: (context, index) {
                return QuestionItem(index: index,type: "ql",uploadImageFun: uploadImage,typeOfSubject: widget.typeOfSubject,);
              },
            ),),

            SizedBox(width:500,
            child : RaisedButton(
              elevation: 0,
              color: primaryColor,
              onPressed: (){

              },
              child: Text("حفظ الدرس", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),)
            ),

          ],))
      ],),
        ),)
    ),
    ),
    );
  }
}



class QuestionItem extends StatelessWidget {
  final index;
  final type;
  final uploadImageFun;
  final typeOfSubject;
  QuestionItem({this.index,this.type,this.uploadImageFun,this.typeOfSubject});


  @override
  Widget build(BuildContext context) {
    return 
            ExpansionTile(
              title: Text("السؤال "),
              children: <Widget>[
        SizedBox(height: 10,),



        Text("مستوي السؤال", style: TextStyle(fontWeight: FontWeight.bold, fontSize:15)),         


        Row(children: <Widget>[
          Expanded(child: DropdownButton<String>(
              value: 'متميز',
              onChanged: (String newValue) {
                // setState(() {
                //   // dropdownValue = newValue;
                // });
              },
              items: <String>[ 'متوسط', 'المبتدئ','متفوق','متميز','عبقيري']
                .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                })
                .toList(),
        ),)
        ],),

                TextField(
                decoration: InputDecoration(
                  hintText: "السؤال ",
                  disabledBorder: UnderlineInputBorder( borderSide: BorderSide(color: grayWhite),),
                  focusedBorder: UnderlineInputBorder( borderSide: BorderSide(color: primaryColor),)
                  ),
                ),

                RaisedButton(child: Text("اختيار صورة"),onPressed: uploadImageFun),

                                TextField(
                decoration: InputDecoration(
                  hintText: "الاجابة الاولي ",
                  disabledBorder: UnderlineInputBorder( borderSide: BorderSide(color: grayWhite),),
                  focusedBorder: UnderlineInputBorder( borderSide: BorderSide(color: primaryColor),)
                  ),
                ),
                
                RaisedButton(child: Text("اختيار صورة"),onPressed: uploadImageFun),

                                TextField(
                decoration: InputDecoration(
                  hintText: "الاجابة الثانية ",
                  disabledBorder: UnderlineInputBorder( borderSide: BorderSide(color: grayWhite),),
                  focusedBorder: UnderlineInputBorder( borderSide: BorderSide(color: primaryColor),)
                  ),
                ),

                RaisedButton(child: Text("اختيار صورة"),onPressed: uploadImageFun),

                                TextField(
                decoration: InputDecoration(
                  hintText: "الاجابة الثالثة ",
                  disabledBorder: UnderlineInputBorder( borderSide: BorderSide(color: grayWhite),),
                  focusedBorder: UnderlineInputBorder( borderSide: BorderSide(color: primaryColor),)
                  ),
                ),
                RaisedButton(child: Text("اختيار صورة"),onPressed: uploadImageFun),

                
              TextField(
                decoration: InputDecoration(
                  hintText: "الاجابة الرابعة ",
                  disabledBorder: UnderlineInputBorder( borderSide: BorderSide(color: grayWhite),),
                  focusedBorder: UnderlineInputBorder( borderSide: BorderSide(color: primaryColor),)
                  ),
                ),
                RaisedButton(child: Text("اختيار صورة"),onPressed: uploadImageFun),



              SizedBox(height: 10,),

              Center(child: Text("الاجابة الصحيحة", style: TextStyle(fontWeight: FontWeight.bold, fontSize:15, color: gray),),),
                DropdownButton<String>(
                  value: 'الاجابة الثالثة',
                  onChanged: (String newValue) {
                    // setState(() {
                    //   // dropdownValue = newValue;
                    // });
                  },
                  items: <String>['الجابة الاولي', 'الاجابة الثانية', 'الاجابة الثالثة', 'الاجابة الرابعة']
                    .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    })
                    .toList(),
                ),

              typeOfSubject == "qudrat"  ?  
              Column(children: <Widget>[
                Center(child: Text("المهارة", style: TextStyle(fontWeight: FontWeight.bold, fontSize:15, color: gray),),),
                DropdownButton<String>(
                  value: type == "qk" ? 'مسائل حسابية' : 'مهارة المفردة الشاذة'  ,
                  onChanged: (String newValue) {
                    // setState(() {
                    //   // dropdownValue = newValue;
                    // });
                  },

items: type == "qk" ? <String>['مسائل حسابية', 'هندسة', 'احصاء', 'أنماط', 'مسائل حياتية ', 'مقارنات']  : <String>['مهارة التناظر اللفظي', 'مهارة الخطأ السياقي', 'مهارة المفردة الشاذة', 'مهارة إكمال الجمل', 'مهارة استيعاب المقروء']                    .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    })
                    .toList(),
                )
              ],) : SizedBox()

              ],
              );
  }
}