import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/resources/firestore_methods.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/dimensions.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/follow_button.dart';
import 'package:instagram_clone/widgets/svg_icon.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  final String uid;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData = {};
  int postCount = 0;
  int followersCount = 0;
  int followingCount = 0;
  bool isFollowing = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.uid)
          .get();

      var postSnap = await FirebaseFirestore.instance
          .collection('Posts')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      postCount = postSnap.docs.length;
      userData = userSnap.data()!;
      followersCount = userSnap.data()!['followers'].length;
      followingCount = userSnap.data()!['following'].length;
      isFollowing = userSnap
          .data()!['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);
      setState(() {});
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(
              color: primaryColor,
            ),
          )
        : Scaffold(
            appBar: width > webScreenSize
                ? null
                : AppBar(
                    backgroundColor: mobileBackgroundColor,
                    title: Text(userData['username']),
                    centerTitle: false,
                    actions: [
                      SvgIcon(
                        imgPath: 'assets/images/plus.svg',
                        onTap: () {},
                        color: primaryColor,
                      ),
                      10.widthBox,
                      SvgIcon(
                        imgPath: 'assets/images/menu.svg',
                        onTap: () {},
                        color: primaryColor,
                      ),
                    ],
                  ),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          VxCircle(
                            radius: 100,
                            backgroundImage: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(userData['profileUrl'])),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    buildStatColumn(postCount, 'Posts'),
                                    buildStatColumn(
                                        followersCount, 'Followers'),
                                    buildStatColumn(
                                        followingCount, 'Following'),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FirebaseAuth.instance.currentUser!.uid ==
                                            widget.uid
                                        ? FollowButton(
                                            backgroundColor:
                                                mobileBackgroundColor,
                                            borderColor: Vx.gray500,
                                            text: 'Logout',
                                            textColor: primaryColor,
                                            function: () async {
                                              await AuthMethods().signOut();
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const LoginScreen(),
                                                ),
                                              );
                                            },
                                          )
                                        : isFollowing
                                            ? FollowButton(
                                                backgroundColor: Colors.white,
                                                borderColor: Vx.gray500,
                                                text: 'Unfollow',
                                                textColor: Colors.black,
                                                function: () async {
                                                  await FireStoreMethods()
                                                      .followUser(
                                                          FirebaseAuth.instance
                                                              .currentUser!.uid,
                                                          userData['uid']);

                                                  setState(() {
                                                    isFollowing = false;
                                                    followersCount--;
                                                  });
                                                },
                                              )
                                            : FollowButton(
                                                backgroundColor: Colors.blue,
                                                borderColor: Colors.blue,
                                                text: 'Follow',
                                                textColor: primaryColor,
                                                function: () async {
                                                  await FireStoreMethods()
                                                      .followUser(
                                                          FirebaseAuth.instance
                                                              .currentUser!.uid,
                                                          userData['uid']);

                                                  setState(() {
                                                    isFollowing = true;
                                                    followersCount++;
                                                  });
                                                },
                                              ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(top: 15),
                        child: '${userData['username']}'.text.bold.make(),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(top: 2),
                        child: '${userData['bio']}'.text.make(),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('Posts')
                        .where('uid',
                            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        );
                      }
                      return GridView.builder(
                          itemCount: (snapshot.data as dynamic).docs.length,
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 1.5,
                            childAspectRatio: 1,
                          ),
                          itemBuilder: (context, index) {
                            return Image(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                (snapshot.data as dynamic).docs[index]
                                    ['postUrl'],
                              ),
                            );
                          });
                    })
              ],
            ),
          );
  }

  Column buildStatColumn(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        num.toString().text.size(22).bold.make(),
        label.text.size(15).make(),
      ],
    );
  }
}
