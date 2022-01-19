import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone/responsive/responsive_layout.dart';
import 'package:instagram_clone/responsive/web_screen_layout.dart';
import 'package:instagram_clone/screens/signup_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
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
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void login() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().userLogin(
        email: _emailController.text, password: _passwordController.text);
    // ignore: avoid_print
    print(res);
    setState(() {
      _isLoading = false;
    });
    if (res != "success") {
      showSnackBar(res, context);
    } else {
      Navigator.pushReplacement(
        context,
        (MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            webScreenLayout: WebScreenLayout(),
            mobileScreenLayout: MobileScreenLayout(),
          ),
        )),
      );
    }
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
              height: 50,
              child: ElevatedButton(
                onPressed: login,
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : 'Login'.text.make(),
              ),
            ),
            Flexible(flex: 2, child: VxBox().make()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                VxBox(
                  child: 'Don\'t have an account?'.text.make(),
                ).make().pSymmetric(v: 8),
                5.widthBox,
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      (MaterialPageRoute(
                        builder: (context) => const SignUpScreen(),
                      )),
                    );
                  },
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
