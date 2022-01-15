import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MobileScreenLayout extends StatelessWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: "This is Mobile Screen".text.make(),
      ),
    );
  }
}
