import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/resources/firestore_methods.dart';
import 'package:instagram_clone/screens/comment_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/like_animation.dart';
import 'package:instagram_clone/widgets/svg_icon.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class PostCard extends StatefulWidget {
  const PostCard({Key? key, required this.data}) : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final data;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimation = false;
  int commentsLength = 0;

  @override
  void initState() {
    super.initState();
    getCommentsLength();
  }

  void getCommentsLength() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Posts')
          .doc(widget.data['postId'])
          .collection('Comments')
          .get();

      commentsLength = querySnapshot.docs.length;
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    UserModel? userModel = Provider.of<UserProvider>(context).getUser;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: mobileBackgroundColor,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16)
                .copyWith(right: 0),
            child: Row(
              children: [
                VxCircle(
                  radius: 40,
                  backgroundImage: DecorationImage(
                    image: NetworkImage(
                      widget.data['profileImage'],
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        '${widget.data["userName"]}'.text.bold.make(),
                      ],
                    ),
                  ),
                ),
                widget.data['uid'].toString() == userModel!.uid
                    ? IconButton(
                        icon: const Icon(Icons.more_vert),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => Dialog(
                              child: ListView(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  shrinkWrap: true,
                                  children: [
                                    "Delete",
                                  ]
                                      .map(
                                        (e) => InkWell(
                                          onTap: () async {
                                            FireStoreMethods().deletePosts(
                                                widget.data['postId']);
                                            Navigator.of(context).pop();
                                          },
                                          child: Container(
                                            child: Text(e),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 12),
                                          ),
                                        ),
                                      )
                                      .toList()),
                            ),
                          );
                        },
                      )
                    : Container(),
              ],
            ),
          ),
          GestureDetector(
            onDoubleTap: () async {
              await FireStoreMethods().postLike(widget.data['postId'],
                  userModel.uid, widget.data['postLikes']);

              setState(() {
                isLikeAnimation = true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: double.infinity,
                  child: Image.network(
                    widget.data["postUrl"],
                    fit: BoxFit.cover,
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: isLikeAnimation ? 1 : 0,
                  child: LikeAnimation(
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 100,
                    ),
                    isAnimation: isLikeAnimation,
                    duration: const Duration(milliseconds: 400),
                    onEnd: () {
                      setState(() {
                        isLikeAnimation = false;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16)
                .copyWith(right: 0),
            child: Row(
              children: [
                LikeAnimation(
                  isAnimation: widget.data['postLikes'].contains(userModel.uid),
                  smallLike: true,
                  child: SvgIcon(
                    onTap: () async {
                      await FireStoreMethods().postLike(widget.data['postId'],
                          userModel.uid, widget.data['postLikes']);
                    },
                    imgPath: widget.data['postLikes'].contains(userModel.uid)
                        ? 'assets/images/favourite-full.svg'
                        : 'assets/images/favourite.svg',
                    color: widget.data['postLikes'].contains(userModel.uid)
                        ? Colors.red
                        : Colors.white,
                  ),
                ),
                10.widthBox,
                SvgIcon(
                  imgPath: 'assets/images/comment.svg',
                  color: primaryColor,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CommentScreen(
                          postId: widget.data,
                        ),
                      ),
                    );
                  },
                ),
                10.widthBox,
                SvgIcon(
                  imgPath: 'assets/images/share.svg',
                  color: primaryColor,
                  onTap: () {},
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: SvgIcon(
                      imgPath: "assets/images/bookmark.svg",
                      onTap: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle(
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(fontWeight: FontWeight.w800),
                  child: Text(
                    "${widget.data['postLikes'].length} likes",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 8),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(color: primaryColor),
                      children: [
                        TextSpan(
                            text: widget.data['userName'],
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                          text: " ${widget.data['postDescription']}",
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: "View all $commentsLength comments"
                        .text
                        .color(secondaryColor)
                        .size(16)
                        .make(),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: DateFormat.yMMMd()
                      .format(widget.data['postDate'].toDate())
                      .text
                      .color(secondaryColor)
                      .size(10)
                      .make(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
