import 'package:checkwan/knowledge/knowledge.dart';
import 'package:checkwan/profile/profilescreen.dart';
import 'package:checkwan/screen/addinfomation_screen.dart';
import 'package:checkwan/screen/homepage.dart';
import 'package:checkwan/screen/process.dart';
import 'package:checkwan/screen/processscreen.dart';
import 'package:checkwan/screen/register.dart';
import 'package:checkwan/service/authservice.dart';
import 'package:checkwan/sugarscreen/psugar.dart';
import 'package:checkwan/sugarscreen/sugarscreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Launcher extends StatefulWidget {
  const Launcher({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LauncherState();
  }
}

class _LauncherState extends State<Launcher> {
  int _selectedIndex = 0;
  PageController _controller = PageController(
    initialPage: 0,
  );
  int _page = 0;

  final screens = [
    HomePage(),
    Psugar(),
    AddinfoScreen(),
    // RegisterScreen(),
    ProcessScreen(),
    Knowledge(),
  ];

  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_page],
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        color: Colors.grey.shade200,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.grey.shade200,
        // backgroundColor: Colors.blueAccent,
        key: _bottomNavigationKey,
        items: <Widget>[
          Image.asset(
            "assets/icons/home2.png",
            width: 25.0,
            height: 25.0,
          ),
          Image.asset(
            "assets/icons/sugar.png",
            width: 25.0,
            height: 25.0,
          ),
          Icon(Icons.add, size: 35),
          Image.asset(
            "assets/icons/menu.png",
            width: 25.0,
          ),
          Image.asset(
            "assets/icons/book.png",
            width: 30.0,
            height: 30.0,
          ),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
    );
  }
}
