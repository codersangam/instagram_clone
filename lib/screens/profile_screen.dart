import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/widgets/svg_icon.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text('username'),
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
                      backgroundImage: const DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://images.unsplash.com/photo-1643130420613-886ba8952e75?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw1fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60')),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildStatColumn(10, 'Posts'),
                          buildStatColumn(1611, 'Followers'),
                          buildStatColumn(229, 'Following'),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
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
