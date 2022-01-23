import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:velocity_x/velocity_x.dart';

class SvgIcon extends StatelessWidget {
  const SvgIcon({
    Key? key,
    required this.imgPath,
    required this.onTap,
    this.color,
  }) : super(key: key);

  final String imgPath;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SvgPicture.asset(
        imgPath,
        color: color,
        height: 30,
        width: 30,
      ).pOnly(right: 10),
    );
  }
}
