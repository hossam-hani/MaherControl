

import 'package:firebase_auth/firebase_auth.dart';
import './firestore_service.dart';
class AuthenticationService {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future signIn(String email,String password) async {
      try{
        AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password); 
        FirebaseUser user = result.user;
        var userInfo = await FirestoreService().getUserDataT(user.uid);

        return user;
      }catch(e){
        return e.message;
      }
  }

  Future<FirebaseUser> createUser(String email,String password) async {
      try{
        AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
        FirebaseUser user = result.user;


        return user;
      }catch(e){
        return e.message;
      }
  }

  Future<bool> isLogin() async {
    return await _firebaseAuth.currentUser() != null;
  }

  Future<FirebaseUser> getCurrentUser() async {
    return await _firebaseAuth.currentUser();
  }

  Future<void> signOut(){
   return  _firebaseAuth.signOut();
  }



}