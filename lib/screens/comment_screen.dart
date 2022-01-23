import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/widgets/svg_icon.dart';
import 'package:velocity_x/velocity_x.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({Key? key}) : super(key: key);

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  @override
  Widget build(BuildContext context) {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VxCircle(
                  radius: 40,
                  backgroundImage: const DecorationImage(
                      image: NetworkImage(
                          'https://images.unsplash.com/photo-1642901798224-43b33b70c646?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80')),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(top: 8),
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(color: primaryColor),
                        children: [
                          TextSpan(
                              text: 'userName',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(
                            text: " postDescription",
                          ),
                        ],
                      ),
                    ),
                  ).pOnly(left: 8),
                ),
              ],
            ).pOnly(left: 16, right: 8),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              // child: DateFormat.yMMMd()
              //     .format(widget.data['postDate'].toDate())
              //     .text
              //     .color(secondaryColor)
              //     .size(10)
              //     .make(),
              child: 'Dec 10, 2022'.text.size(10).color(secondaryColor).make(),
            ),
            const Divider(
              color: Vx.white,
            )
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
                backgroundImage: const DecorationImage(
                    image: NetworkImage(
                        'https://images.unsplash.com/photo-1642901798224-43b33b70c646?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80')),
              ),
              Expanded(
                child: const TextField(
                  decoration: InputDecoration(hintText: 'Add a comment...'),
                ).pOnly(left: 16, right: 8),
              ),
              InkWell(
                onTap: () {},
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
