import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  

  

  CUser _userFromFirebaseUser(User user){
    if(user != null){
      return CUser(uid: user.uid);
    }
    else{
      
      return null;
    }
  }

  //auth change user stream
  Stream<CUser> get user {
    return _auth.authStateChanges()
      .map((User user) => _userFromFirebaseUser(user));
  }


  //sign in an  on
  Future signInAnon() async{
    try{
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return  _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // sign in email and password
  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }


  //register email and password
  Future registerWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      //create a new document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData("Kayn", "Baris", 13);
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }



  //sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

}