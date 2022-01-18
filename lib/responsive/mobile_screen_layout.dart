import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  @override
  Widget build(BuildContext context) {
    UserModel? userModel = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        title: "Mobile HomeScreen".text.make(),
      ),
      body: Center(
        child: Column(
          children: [
            "This is Mobile Screen".text.make(),
            '${userModel?.email}'.text.make(),
            '${userModel?.username}'.text.make(),
            '${userModel?.bio}'.text.make()
          ],
        ),
      ),
    );
  }
}
