import 'package:flutter/widgets.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  // Get User Details

  UserModel? _userModel;
  final AuthMethods _authMethods = AuthMethods();

  UserModel? get getUser => _userModel;

  Future<void> getUserDetails() async {
    UserModel userModel = await _authMethods.getUserDetail();
    _userModel = userModel;
    notifyListeners();
  }

  // UserModel? currentUserData;
  // fetchUserDetails() async {
  //   DocumentSnapshot value = await FirebaseFirestore.instance
  //       .collection('Users')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get();

  //   if (value.exists) {
  //     UserModel userModel = UserModel(
  //       uid: value.get('uid'),
  //       username: value.get('username'),
  //       email: value.get('email'),
  //       bio: value.get('bio'),
  //       profileUrl: value.get('profileUrl'),
  //       followers: value.get('followers'),
  //       following: value.get('following'),
  //     );
  //     currentUserData = userModel;
  //     notifyListeners();
  //   }
  // }

  // UserModel? get getUserDetails {
  //   return currentUserData;
  // }
}
