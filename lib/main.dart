import 'package:flutter/material.dart';
import 'addCompetition.dart';
import 'login.dart';
import 'subjects/listOfSubjectjs.dart';
import 'subjects/listOFLessons.dart';
import 'questionnaire/QuestionnaireEditor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "GE SS Two",
        primarySwatch: Colors.blue,
      ),
      home: Login(),
    );
  }
}
