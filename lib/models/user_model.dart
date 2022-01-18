import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String username;
  String email;
  String bio;
  String profileUrl;
  List followers;
  List following;

  UserModel(
      {required this.username,
      required this.uid,
      required this.profileUrl,
      required this.email,
      required this.bio,
      required this.followers,
      required this.following});

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "username": username,
        "email": email,
        "bio": bio,
        "profileUrl": profileUrl,
        "followers": followers,
        "following": following,
      };

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
      username: snapshot["username"],
      uid: snapshot["uid"],
      email: snapshot["email"],
      profileUrl: snapshot["profileUrl"],
      bio: snapshot["bio"],
      followers: snapshot["followers"],
      following: snapshot["following"],
    );
  }
}
