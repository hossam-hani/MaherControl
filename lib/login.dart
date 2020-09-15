import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:maherteacher/questionnaire/QuestionnaireEditor.dart';
import 'package:maherteacher/subjects/listOfSubjectjs.dart';
import 'package:maherteacher/services/authentication_service.dart';
import './components/const.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'addSubjectToTeacher.dart';
import 'questionnaire/QuestionnaireEditor.dart';
import 'questionnaire/listOfQuestionnaire.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  
    final _formKey = GlobalKey<FormState>();
  final email = TextEditingController(text: "hossamhani@gmail.com");
  final password = TextEditingController(text: "123456789");

  var error = "";
  bool isLoading = false;


  login() async{
    
    AuthenticationService _auth = AuthenticationService();

    setState(() {
      isLoading = true;
    });

        if (_formKey.currentState.validate()) {
          var result = await _auth.signIn(email.text.trim(), password.text);
          if((result is String)){
            setState(() {
              error = result;
              isLoading = false;
            });
          }else{
            Navigator.of(context)
            .pushReplacement(new MaterialPageRoute(builder: (BuildContext context) => ListOfQuestionnaire()));
          }      

    setState(() {
      isLoading = false;
    });


    }



  }
  
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery. of(context). size. height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: 
        Directionality(textDirection: TextDirection.rtl,
        child: SingleChildScrollView (
          child: Container(
          height: height,
          padding: EdgeInsets.all(30),
          child: Form(
            key: _formKey,
            child:  Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            decoration: new BoxDecoration(
              boxShadow: shadow,
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            child: Image.asset("images/logo.png"),
            ),
          SizedBox(height: 20,),
          Text("تطبيق ماهر  ( المعلم )", style: TextStyle(fontWeight: FontWeight.bold, fontSize:20),),

          
          SizedBox(height: 20,),
          
          Divider(),
          TextFormField(
            controller: email,
            decoration: InputDecoration(
              hintText: "البريد الالكتروني",
              icon: FaIcon(FontAwesomeIcons.userAlt, color: primaryColor,),
              disabledBorder: UnderlineInputBorder( borderSide: BorderSide(color: grayWhite),),
              focusedBorder: UnderlineInputBorder( borderSide: BorderSide(color: primaryColor),)
              ),
              validator: (value) {
                if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                  return 'من فضلك ادخل بريد الكتروني صحيح';
                }
              },
            ),
          TextFormField(
            controller: password,
            style: TextStyle(fontFamily: "Lato"),
            decoration: InputDecoration(
              hintText: "كلمة المرور",
              
              icon: FaIcon(FontAwesomeIcons.lock, color: primaryColor,),
              disabledBorder: UnderlineInputBorder( borderSide: BorderSide(color: grayWhite),),
              focusedBorder: UnderlineInputBorder( borderSide: BorderSide(color: primaryColor),)
              ),
              validator: (value) {
              if (value.length < 3) {
              return 'كلمة المرور قصيرة';
                    }
                  },
              obscureText: true,
            ),
          SizedBox(height: 20,),
          
          isLoading ? SpinKitSquareCircle(
            color: primaryColor,
            size: 50.0,
          ) : SizedBox(width:500,
          child : RaisedButton(
            elevation: 0,
            color: primaryColor,
            onPressed: login,
            child: Text("تسجيل الدخول", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),)
            ),

                            SizedBox(height: 20,),
                Center(child: Text(error,style: TextStyle(color: Colors.red,fontWeight: FontWeight.w500,),textAlign: TextAlign.center,)),
        ],),
      ),
    ),
    )
    ),
    )
    );
  }
}