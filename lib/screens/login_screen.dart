import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/widgets/text_input_field.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VxBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(flex: 2, child: VxBox().make()),
            SvgPicture.asset(
              'assets/images/ic_instagram.svg',
              color: primaryColor,
            ),
            40.heightBox,
            TextInputField(
                textEditingController: _emailController,
                isPassword: false,
                hintText: 'Enter your email',
                textInputType: TextInputType.emailAddress),
            24.heightBox,
            TextInputField(
                textEditingController: _passwordController,
                isPassword: true,
                hintText: 'Enter your password',
                textInputType: TextInputType.text),
            24.heightBox,
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: () {},
                child: 'Login'.text.make(),
              ),
            ),
            Flexible(flex: 2, child: VxBox().make()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                VxBox(
                  child: 'Already have an account?'.text.make(),
                ).make().pSymmetric(v: 8),
                5.widthBox,
                GestureDetector(
                  onTap: () {},
                  child: VxBox(
                    child: 'Sign up'.text.bold.make(),
                  ).make().pSymmetric(v: 8),
                ),
              ],
            )
          ],
        ),
      ).make().pSymmetric(h: 32).w(double.infinity),
    );
  }
}
