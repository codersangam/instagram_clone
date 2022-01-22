import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/widgets/svg_icon.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

class PostCard extends StatelessWidget {
  const PostCard({Key? key, required this.data}) : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final data;

  @override
  Widget build(BuildContext context) {
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
                    image: NetworkImage(data['profileImage']),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        '${data["userName"]}'.text.bold.make(),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: ListView(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shrinkWrap: true,
                            children: [
                              "Delete",
                            ]
                                .map(
                                  (e) => InkWell(
                                    onTap: () {},
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
                ),
              ],
            ),
          ),
          InkWell(
            onLongPress: () {},
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.35,
              width: double.infinity,
              child: Image.network(
                data["postUrl"],
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16)
                .copyWith(right: 0),
            child: Row(
              children: [
                SvgIcon(
                  imgPath: 'assets/images/favourite.svg',
                  onTap: () {},
                ),
                10.widthBox,
                SvgIcon(
                  imgPath: 'assets/images/comment.svg',
                  onTap: () {},
                ),
                10.widthBox,
                SvgIcon(
                  imgPath: 'assets/images/share.svg',
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
                    "${data['postLikes'].length} likes",
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
                            text: data['userName'],
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                          text: " ${data['postDescription']}",
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: "View all 200 comments"
                        .text
                        .color(secondaryColor)
                        .size(16)
                        .make(),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: DateFormat.yMMMd()
                      .format(data['postDate'].toDate())
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
