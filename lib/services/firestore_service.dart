import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import './authentication_service.dart';

class FirestoreService {

  final Firestore _fireStore = Firestore.instance;
  final CollectionReference usersReference = Firestore.instance.collection("users");
  final CollectionReference subjectsReference = Firestore.instance.collection("subjects");

  final CollectionReference questionnairesRef = Firestore.instance.collection("questionnaires");
  final CollectionReference competitionRef = Firestore.instance.collection("competitions");


  final CollectionReference userCurrentRequestsReference = Firestore.instance.collection("users");


  // functions Jul // final 


  Future getUserDataT(String userId) async {
    return await usersReference.document(userId).get();
  }



  Future getListOfTeacher() async{
     var tempListOfTeacher = await usersReference.where("type", isEqualTo: "teacher").getDocuments();
     return tempListOfTeacher.documents;
  }

  Future createTeacher(String fullName, String email, String gender,
   String introDescription, String phone, List<dynamic> subjects) async {

      var uuid = Uuid();
      var v1 = uuid.v1();

      var newTeacher = {
        "email" : email,
        "fullName" : fullName,
        "gender" : gender,
        "introDescription" : introDescription,
        "phone" : phone,

        //TODO: implement school id when create CRUD for Schooles
        "school" : {
          "schoolId" : "1ZHWYbINIdgL6XGACJFf",
          "schoolName" : "منار السبيل الاهلية بنين"
        },
        "type" : "teacher",
        "statistics" : {},
        "userId" : v1
      };
      
      // firestore query 
      await usersReference.document(v1).setData(newTeacher);

      // add list of subjects for teacher
      subjects.map((subject) async {
        await usersReference.document(v1).collection("subjects").document(subject["id"]).setData(subject);
      });
      
  }

  Future updateTeacher(String id, String fullName, String email, String gender,
   String introDescription, String phone, List<dynamic> subjects) async {

      var updatedTeacher = {
        "email" : email,
        "fullName" : fullName,
        "gender" : gender,
        "introDescription" : introDescription,
        "phone" : phone,

        //TODO: implement school id when create CRUD for Schooles
        "school" : {
          "schoolId" : "1ZHWYbINIdgL6XGACJFf",
          "schoolName" : "منار السبيل الاهلية بنين"
        },
        "type" : "teacher",
        "statistics" : {},
        "userId" : id
      };

      await usersReference.document(id).setData(updatedTeacher);


      subjects.map((subject) async {
        await usersReference.document(id).collection("subjects").document(subject["id"]).setData(subject);
      });
  }




  // -- lessons functions
  Future createLesson(bool commentsEnabled, bool isActive, String link
  , bool isLive,String title, String type, String typeOfLesson, String userId, String userName, List<dynamic> questions){


    var uuid = Uuid();
    var v1 = uuid.v1();

    var lesson = {
      "commentsEnabled" : commentsEnabled,
      "isActive" : isActive,
      "lessonId" : v1,
      "link" : link,
      "isLive" : isLive,
      "statistics" : {},
      "title" : title,
      "type" : type,
      "typeOfLesson" : typeOfLesson,
      "user" : {
         "userId" : userId,
         "userName" : userName
      }
    };

    // database Query TODO: create lesson

    questions.map((question) async {
        await usersReference.document(v1).collection("subjects").document(question["id"]).setData(question);
    });
  }

  Future updateLesson(String id, bool commentsEnabled, bool isActive, String link
  , bool isLive,String title, String type, String typeOfLesson, String userId, String userName, List<dynamic> questions){

    var lesson = {
      "commentsEnabled" : commentsEnabled,
      "isActive" : isActive,
      "lessonId" : id,
      "link" : link,
      "isLive" : isLive,
      "statistics" : {},
      "title" : title,
      "type" : type,
      "typeOfLesson" : typeOfLesson,
      "user" : {
         "userId" : userId,
         "userName" : userName
      }
    };

    // database Query TODO: update lesson

    questions.map((question) async {
        await usersReference.document(id).collection("subjects").document(question["id"]).setData(question);
    });

  }

  Future getLessonsUsingSubjectId(String id) async {
     var tempListOfLessons = await usersReference.where("type", isEqualTo: "teacher").getDocuments();
     return tempListOfLessons.documents;
  }

  Future deletLesson(String id) async{
   await subjectsReference.document(id).delete();
   return 1;
  }




  // Competition -- 1
  Future getCompetition(String id) async{
    return await competitionRef.document(id).get();
  }

  Future getCompetitions() async{
    return await competitionRef.getDocuments();
  }




  Future createCompetition(String title,String linkOfQuestioner, String linkOfResults, String status, DateTime date) async{
    var uuid = Uuid();
    var v1 = uuid.v1(); 

    return await competitionRef.document(v1).setData({
      "id" : v1,
      "link" : linkOfQuestioner,
      "linkOfResults" : linkOfResults,
      "status" : status == "مستمر" ? "active" : "deactive",
      "title" : title,
      "date" : Timestamp.fromMillisecondsSinceEpoch(date.millisecondsSinceEpoch),
      "createdAt" : FieldValue.serverTimestamp(),


    });
  }

  
  Future updateCompetition(String id,String title,String linkOfQuestioner, String linkOfResults, String status, DateTime date) async{

    print(date);
    return await competitionRef.document(id).updateData(
     date != null ? {
      "id" : id,
      "link" : linkOfQuestioner,
      "linkOfResults" : linkOfResults,
      "status" : status,
      "title" : title,
      "date" : Timestamp.fromMillisecondsSinceEpoch(date.millisecondsSinceEpoch)
    } : 
    {
      "id" : id,
      "link" : linkOfQuestioner,
      "linkOfResults" : linkOfResults,
      "status" : status,
      "title" : title,
    }
    );
  }





  // Questionnaire -- 2
  Future getQuestionnaire(String id) async{
    return await questionnairesRef.document(id).get();
  }

  Future getQuestionnaires() async{
    return await questionnairesRef.getDocuments();
  }

  Future createQuestionnaire(String title,String linkOfQuestioner, String linkOfResults, String status, DateTime date) async{
    var uuid = Uuid();
    var v1 = uuid.v1(); 

    return await questionnairesRef.document(v1).setData({
      "id" : v1,
      "link" : linkOfQuestioner,
      "linkOfResults" : linkOfResults,
      "status" : status == "مستمر" ? "active" : "deactive",
      "title" : title,
      "date" : Timestamp.fromMillisecondsSinceEpoch(date.millisecondsSinceEpoch),
      "createdAt" : FieldValue.serverTimestamp(),

    });
  }

  Future updateQuestionnaire(String id,String title,String linkOfQuestioner, String linkOfResults, String status, DateTime date) async{

    print(date);
    return await questionnairesRef.document(id).updateData(
     date != null ? {
      "id" : id,
      "link" : linkOfQuestioner,
      "linkOfResults" : linkOfResults,
      "status" : status,
      "title" : title,
      "date" : Timestamp.fromMillisecondsSinceEpoch(date.millisecondsSinceEpoch)
    } : 
    {
      "id" : id,
      "link" : linkOfQuestioner,
      "linkOfResults" : linkOfResults,
      "status" : status,
      "title" : title,
    }
    );
  }


  // Questionnaire -- 3
  Future getUser(String id) async{
    return await userCurrentRequestsReference.document(id).get();
  }

  Future getUsers() async{
    return await userCurrentRequestsReference.getDocuments();
  }

  Future createUser(String title,String linkOfQuestioner, String linkOfResults, String status, DateTime date) async{
    var uuid = Uuid();
    var v1 = uuid.v1(); 

    return await userCurrentRequestsReference.document(v1).setData({
      "id" : v1,
      "link" : linkOfQuestioner,
      "linkOfResults" : linkOfResults,
      "status" : status == "مستمر" ? "active" : "deactive",
      "title" : title,
      "date" : Timestamp.fromMillisecondsSinceEpoch(date.millisecondsSinceEpoch),
      "createdAt" : FieldValue.serverTimestamp(),

    });
  }

  Future updateUser(String id,String title,String linkOfQuestioner, String linkOfResults, String status, DateTime date) async{

    print(date);
    return await userCurrentRequestsReference.document(id).updateData(
     date != null ? {
      "id" : id,
      "link" : linkOfQuestioner,
      "linkOfResults" : linkOfResults,
      "status" : status,
      "title" : title,
      "date" : Timestamp.fromMillisecondsSinceEpoch(date.millisecondsSinceEpoch)
    } : 
    {
      "id" : id,
      "link" : linkOfQuestioner,
      "linkOfResults" : linkOfResults,
      "status" : status,
      "title" : title,
    }
    );
  }




  // subjects -- 3

  Future getSubjects(type) async{
    if(type == "all"){
     return await subjectsReference.getDocuments();
    }else{
     return await subjectsReference.where("type", isEqualTo: type).getDocuments();
    }
  }



  // lessons -- 3
  Future getLessons(String subjectId, int sem) async{
    if(sem == 0){   
      return await subjectsReference.document(subjectId).collection("lessons").getDocuments();
    }else if(sem == 1){
      return await subjectsReference.document(subjectId).collection("semesters").document("firstSemester").collection("lessons").getDocuments();
    }else if(sem == 2){
      return await subjectsReference.document(subjectId).collection("semesters").document("secondSemester").collection("lessons").getDocuments();
    }
  }
  /// old functions -----------



  // Future addSubjectToTeacher(String subjectId, String educationalLevel, String grade, String image, String subjectName , String type
  // , String userId) async {
    
  //   var request = {
  //     "subjectId" :subjectId,
  //     "subjectName" : subjectName,
  //     "type" : type,
  //     "image" : image,
  //     "educationalLevel" : educationalLevel,
  //     "grade" : grade,
  //   };

  //   await usersReference.document(userId).collection("subjects").document(subjectId).setData(request);

  // }


  // Future createNewLesson(String subject) async {
    

  //   var request = {
  //     "commentsEnabled" : true,
  //     "date" : "",
  //     "download" : {
  //       "extension" : "png",
  //       "fileName" : "image",
  //       "link" : "link"
  //     },
  //     "downloadEnabled" : true,
  //     "educationalLevel" : "",
  //     "grade" : "",
  //     "isActive" : true,
  //     "lessonId" : "",
  //     "link" : "",
  //     "liveLesson" : false,
  //     "title" : "",
  //     "type" : "",
  //     "user" : { "userId" : "b29X2pEhMAbllC2gu2bJPStosjC3"},
  //     "statistics" : {
  //       "comments" : 0,
  //       "followers" : 0,
  //       "rate" : 0,
  //       "reviews" : 0,
  //       "views" : 0
  //     }

  //   };

  //   // await usersReference.document(userId).collection("subjects").document(subjectId).setData(request);

  // }



}