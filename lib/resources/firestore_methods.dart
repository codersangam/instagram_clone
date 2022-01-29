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

  Future<void> postLike(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('Posts').doc(postId).update({
          'postLikes': FieldValue.arrayRemove([uid])
        });
      } else {
        await _firestore.collection('Posts').doc(postId).update({
          'postLikes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Future<void> postComment(String postId, String comment, String uId,
      String userName, String profileImageUrl) async {
    try {
      if (comment.isNotEmpty) {
        String commentId = const Uuid().v1();
        await _firestore
            .collection('Posts')
            .doc(postId)
            .collection('Comments')
            .doc(commentId)
            .set({
          'profileImageUrl': profileImageUrl,
          'uId': uId,
          'userName': userName,
          'comment': comment,
          'commentId': commentId,
          'commentedDate': DateTime.now(),
        });
      } else {
        // ignore: avoid_print
        print('No comments');
      }
    } catch (e) {
      // ignore: avoid_print
      print(
        e.toString(),
      );
    }
  }

  Future<void> deletePosts(String postId) async {
    try {
      await _firestore.collection('Posts').doc(postId).delete();
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Future<void> followUser(String uid, String followUid) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('Users').doc(uid).get();
      List following = (snapshot.data()! as dynamic)['following'];
      if (following.contains(followUid)) {
        await _firestore.collection('Users').doc(followUid).update({
          'followers': FieldValue.arrayRemove([uid])
        });
        await _firestore.collection('Users').doc(uid).update({
          'following': FieldValue.arrayRemove([followUid])
        });
      } else {
        await _firestore.collection('Users').doc(followUid).update({
          'followers': FieldValue.arrayUnion([uid])
        });
        await _firestore.collection('Users').doc(uid).update({
          'following': FieldValue.arrayUnion([followUid])
        });
      }
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }
}
