import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
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
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          "This is Home Screen".text.make(),
          "This is Search Screen".text.make(),
          "This is Post Screen".text.make(),
          "This is Favorite Screen".text.make(),
          "This is Profile Screen".text.make(),
        ],
      ),
      bottomNavigationBar: CupertinoTabBar(
        onTap: navigationTapped,
        backgroundColor: mobileBackgroundColor,
        activeColor: primaryColor,
        inactiveColor: primaryColor,
        items: [
          BottomNavigationBarItem(
            icon: _page == 0
                ? const Icon(Icons.home_filled)
                : const Icon(Icons.home_outlined),
          ),
          BottomNavigationBarItem(
            icon: _page == 1
                ? const Icon(Icons.search_rounded)
                : const Icon(Icons.search_outlined),
          ),
          BottomNavigationBarItem(
            icon: _page == 2
                ? const Icon(Icons.add_circle_outlined)
                : const Icon(Icons.add_circle_outline_outlined),
          ),
          BottomNavigationBarItem(
            icon: _page == 3
                ? const Icon(Icons.favorite)
                : const Icon(Icons.favorite_border_outlined),
          ),
          BottomNavigationBarItem(
            icon: _page == 4
                ? const Icon(Icons.person_add)
                : const Icon(Icons.person_outlined),
          ),
        ],
      ),
    );
  }
}
