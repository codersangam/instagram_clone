import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

class CommentCard extends StatefulWidget {
  const CommentCard({Key? key, required this.snap}) : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final snap;

  @override
  _CommentCardState createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        children: [
          VxCircle(
            radius: 40,
            backgroundImage: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(widget.snap['profileImageUrl']),
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
                            text: widget.snap['userName'],
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                          text: " ${widget.snap['comment']}",
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: DateFormat.yMMMd()
                        .format(widget.snap['commentedDate'].toDate())
                        .text
                        .color(secondaryColor)
                        .size(10)
                        .make(),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.favorite_outline,
                size: 16,
              ),
            ),
          )
        ],
      ),
    );
  }
}
