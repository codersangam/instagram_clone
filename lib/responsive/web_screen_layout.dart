import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/global_variables.dart';
import 'package:velocity_x/velocity_x.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({Key? key}) : super(key: key);

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  int _page = 0;

  late PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
    setState(() {
      _page = page;
    });
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          title: SvgPicture.asset(
            'assets/images/ic_instagram.svg',
            color: Vx.white,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.home_outlined),
              color: _page == 0 ? primaryColor : secondaryColor,
              onPressed: () => navigationTapped(0),
            ),
            IconButton(
              icon: const Icon(Icons.search),
              color: _page == 1 ? primaryColor : secondaryColor,
              onPressed: () => navigationTapped(1),
            ),
            IconButton(
              icon: const Icon(Icons.add_a_photo),
              color: _page == 2 ? primaryColor : secondaryColor,
              onPressed: () => navigationTapped(2),
            ),
            IconButton(
              icon: const Icon(Icons.favorite),
              color: _page == 3 ? primaryColor : secondaryColor,
              onPressed: () => navigationTapped(3),
            ),
            IconButton(
              icon: const Icon(Icons.person),
              color: _page == 4 ? primaryColor : secondaryColor,
              onPressed: () => navigationTapped(4),
            ),
          ],
        ),
        body: PageView(
          children: homeScreenItems,
          controller: pageController,
          onPageChanged: onPageChanged,
          physics: const NeverScrollableScrollPhysics(),
        ));
  }
}
