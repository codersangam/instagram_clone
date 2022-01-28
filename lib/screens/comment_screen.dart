import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/resources/firestore_methods.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/widgets/comment_card.dart';
import 'package:instagram_clone/widgets/svg_icon.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({Key? key, required this.postId}) : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final postId;

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  TextEditingController commentsController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    commentsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserModel? userModel = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        actions: [
          SvgIcon(
            imgPath: 'assets/images/share.svg',
            onTap: () {},
            color: Vx.white,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              child: Row(
                children: [
                  VxCircle(
                    radius: 40,
                    backgroundImage: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.postId['profileImage']),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(color: primaryColor),
                              children: [
                                TextSpan(
                                    text: widget.postId['userName'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                TextSpan(
                                  text: " ${widget.postId['postDescription']}",
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: DateFormat.yMMMd()
                                .format(widget.postId['postDate'].toDate())
                                .text
                                .color(secondaryColor)
                                .size(10)
                                .make(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Vx.white,
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Posts')
                    .doc(widget.postId['postId'].toString())
                    .collection('Comments')
                    .orderBy('commentedDate', descending: true)
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    );
                  }
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data!.docs[index];
                        return CommentCard(snap: data);
                      });
                }),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          color: Vx.gray900,
          height: kToolbarHeight,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Row(
            children: [
              VxCircle(
                radius: 40,
                backgroundImage: DecorationImage(
                  image: NetworkImage(
                    userModel!.profileUrl,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: TextField(
                  controller: commentsController,
                  decoration:
                      const InputDecoration(hintText: 'Add a comment...'),
                ).pOnly(left: 16, right: 8),
              ),
              InkWell(
                onTap: () async {
                  await FireStoreMethods().postComment(
                      widget.postId['postId'],
                      commentsController.text,
                      userModel.uid,
                      userModel.username,
                      userModel.profileUrl);

                  setState(() {
                    commentsController.text = "";
                  });
                },
                child: Container(
                  child: 'Post'.text.blue900.bold.make(),
                ).pSymmetric(h: 8, v: 8),
              )
            ],
          ),
        ),
      ),
    );
  }
}
