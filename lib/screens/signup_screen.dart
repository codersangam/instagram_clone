import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone/responsive/responsive_layout.dart';
import 'package:instagram_clone/responsive/web_screen_layout.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/text_input_field.dart';
import 'package:velocity_x/velocity_x.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void signUp() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      username: _usernameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      bio: _bioController.text,
      image: _image,
    );

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
            Flexible(flex: 2, child: Container()),
            SvgPicture.asset(
              'assets/images/ic_instagram.svg',
              color: primaryColor,
            ),
            40.heightBox,
            VStack([
              _image != null
                  ? VxCircle(
                      radius: 100,
                      backgroundImage: DecorationImage(
                        fit: BoxFit.cover,
                        image: MemoryImage(_image!),
                      ),
                      child: Align(
                        child: IconButton(
                          onPressed: selectImage,
                          icon: const Icon(Icons.add_a_photo),
                        ),
                        alignment: Alignment.bottomRight,
                      ),
                    )
                  : VxCircle(
                      radius: 100,
                      backgroundImage: const DecorationImage(
                        image: AssetImage('assets/images/default_image.png'),
                      ),
                      child: Align(
                        child: IconButton(
                          onPressed: selectImage,
                          icon: const Icon(Icons.add_a_photo),
                        ),
                        alignment: Alignment.bottomRight,
                      ),
                    ),
            ]),
            24.heightBox,
            TextInputField(
                textEditingController: _usernameController,
                isPassword: false,
                hintText: 'Enter your username',
                textInputType: TextInputType.text),
            24.heightBox,
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
            TextInputField(
                textEditingController: _bioController,
                isPassword: false,
                hintText: 'Enter your bio',
                textInputType: TextInputType.text),
            24.heightBox,
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: signUp,
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : 'Sign Up'.text.make(),
              ),
            ),
            Flexible(flex: 2, child: Container()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                VxBox(
                  child: 'Already have an account?'.text.make(),
                ).make().pSymmetric(v: 8),
                5.widthBox,
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      (MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      )),
                    );
                  },
                  child: VxBox(
                    child: 'Login'.text.bold.make(),
                  ).make().pSymmetric(v: 8),
                ),
              ],
            )
          ],
        ).expand(),
      ).make().pSymmetric(h: 32).w(double.infinity),
    );
  }
}
