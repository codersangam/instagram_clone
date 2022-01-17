import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  // Sign Up Users
  Future<String> signUpUser({
    String? username,
    String? email,
    String? password,
    String? bio,
    Uint8List? image,
  }) async {
    String res = "Some error occurred";
    try {
      if (username!.isNotEmpty ||
          email!.isNotEmpty ||
          password!.isNotEmpty ||
          bio!.isNotEmpty ||
          image != null) {
        // Register User
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: email.toString(),
          password: password.toString(),
        );
        // ignore: avoid_print
        print(userCredential.user!.uid);

        String profileUrl = await StorageMethods()
            .uploadImageToStorage("UsersProfileImage", image!, false);

        // Add user to Database
        await _firebaseFirestore
            .collection('Users')
            .doc(userCredential.user!.uid)
            .set({
          'uid': userCredential.user!.uid,
          'username': username,
          'email': email,
          'bio': bio,
          'followers': [],
          'following': [],
          'profileUrl': profileUrl,
        });
        res = 'success';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
