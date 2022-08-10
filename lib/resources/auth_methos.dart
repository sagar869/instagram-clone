import 'dart:typed_data';

import 'package:demo/resources/storage_method.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/models/user.dart'as model;
class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async{
    User? currentUser = _auth.currentUser!;
    DocumentSnapshot snap = await _firestore.collection("users").doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }


  //sign up user
  signUpUser({
    required String email,
    required String password,
    required String userName,
    required Uint8List file,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty || userName.isNotEmpty) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cred.user!.displayName);

        //for image upload
        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        // add user to database firestore


        model.User user = model.User(
          userName: userName,
          uid: cred.user!.uid,
          email: email,
          followers: [],
          following: [],
          photoUrl: photoUrl,
        );

        await _firestore.collection("users").doc(cred.user!.uid).set(user.toJson());
        // .set({
        //   'userName': userName,
        //   'uid': cred.user!.uid,
        //   'email': email,
        //   'followers': [],
        //   'following': [],
        //   'photoUrl': photoUrl,
        // });


         await _firestore.collection('users').add({
           'userName': userName,
           'uid': cred.user!.uid,
           'email': email,
           'followers': [],
           'following': []
         });

        res = 'successfull';
      }
    }

    catch (err) {
      res = err.toString();
    }
    return res;
  }


  //logging in user
Future<String>loginUser ({
  required String email,
  required String password,
})async{
    String res = "some error occurred";

    try {
      if(email.isNotEmpty || password.isNotEmpty){
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        res = "succesfull";
      }else{
        res = "Please enter all the field";
      }
    } 

    catch(err){
      res = err.toString();
    }
    return res;
}

  Future<void> signOut() async {
    await _auth.signOut();
  }

}
