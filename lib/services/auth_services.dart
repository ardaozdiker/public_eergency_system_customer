// This function is for authentication of system.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class  AuthService {
  //final FirebaseAuth _auth = FirebaseAuth.instance; //to use authentication
 // final FirebaseFirestore _firestore = FirebaseFirestore.instance; //to add use realtime database(for keep users informations.)


  Future<User?> signInWithEmail(String email, String password) async {
    //For login to the system
   await Firebase.initializeApp();
  final FirebaseAuth _auth = FirebaseAuth.instance; //to use authentication

    var user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    return user.user;
  }

  signOut() async {
    //for logout from the system
    Firebase.initializeApp();
  final FirebaseAuth _auth = FirebaseAuth.instance; //to use authentication

    return await _auth.signOut();
  }



  Future<User?> createPerson(String nameSurname, String email, String password,
      String phoneNumber, bool verification) async {
    //for registering the system
  await Firebase.initializeApp();
  final FirebaseAuth _auth = FirebaseAuth.instance; //to use authentication

   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    var user =  await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    await _firestore
        .collection("Users") //choose the users collection
        .doc(user.user?.uid ?? "") //adds userid to the document side
        .set({
      'nameSurname': nameSurname,
      'email': email,
      'phoneNumber': "+90"+phoneNumber,
     // 'verification': false  //if 'true' user is verificated with phone number, if 'false' user is not verificated.
    });
    return user.user;
  }
}
