import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:instagram_clone/models/post_model.dart';
import 'package:instagram_clone/resources/storage_methods.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(String description, Uint8List file, String uid,
      String userName, String profileImage) async {
    String res = "Some error occurred";
    try {
      String postImageUrl = await StorageMethods()
          .uploadImageToStorage('UsersPostImage', file, true);

      String postId = const Uuid().v1();

      PostModel postModel = PostModel(
        postId: postId,
        postUrl: postImageUrl,
        postDate: DateTime.now(),
        postDescription: description,
        uid: uid,
        userName: userName,
        profileImage: profileImage,
        postLikes: [],
      );

      _firestore.collection('Posts').doc(postId).set(postModel.toJson());
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
