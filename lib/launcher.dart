import 'package:checkwan/knowledge/knowledge.dart';
import 'package:checkwan/profile/profilescreen.dart';
import 'package:checkwan/screen/addinfomation_screen.dart';
import 'package:checkwan/screen/homepage.dart';
import 'package:checkwan/screen/process.dart';
import 'package:checkwan/screen/processscreen.dart';
import 'package:checkwan/screen/register.dart';
import 'package:checkwan/service/app_dialog.dart';
import 'package:checkwan/service/authservice.dart';
import 'package:checkwan/sugarscreen/psugar.dart';
import 'package:checkwan/sugarscreen/sugarscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  InitializationSettings? initializationSettings;
  AndroidInitializationSettings? androidInitializationSettings;

  int timesDrink = 1;

  DateTime? startDateTime;

  @override
  void initState() {
    super.initState();
    setupLocalNoti();

    checkTimeStart();
  }

  Future<void> setupLocalNoti() async {
    androidInitializationSettings =
        const AndroidInitializationSettings('app_icon');
    initializationSettings =
        InitializationSettings(android: androidInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings!,
    );
  }

  Future<void> processShowLocationNoti(
      {required String title, required String body}) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      'channelId',
      'channelName',
      priority: Priority.high,
      importance: Importance.max,
      ticker: 'test',
    );

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin
        .show(0, title, body, notificationDetails)
        .then((value) => print('##17jan showNoti Success'));
  }

  Future<void> onSelectNoti(String? string) async {
    if (string != null) {
      print('##17jan strint => $string');
    }
  }

  Future<void> startNoti() async {
    print('##17jan startNot Work at $startDateTime');

    Future.delayed(
      startDateTime!.difference(
        DateTime.now(),
      ),
      () async {
        await Future.delayed(
          Duration(seconds: 10),
          () {
            processShowLocationNoti(
                title: 'แจ้งเตือนการดื่มน้ำ',
                body: 'วันนี่ดื่มน้ำหรือยัง แก้วที่ $timesDrink');
            timesDrink++;
            if (timesDrink < 6) {
              startNoti();
            }
          },
        );
      },
    );
  }

  void checkTimeStart() {
    startDateTime = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, 8, 0, 0, 0, 0); // เปลี่ยนเวลา

    if (DateTime.now().isBefore(startDateTime!)) {
      // ก่อน 8.00
      // AppDialog(context: context).normalDialog(
      //     title: 'ระบบการแจ้งเตือน', message: 'จะเริ่มเดี๋ยวนี่ นะครับ');
      startNoti();
    } else {
      // หลัง 8.00
      startDateTime = startDateTime!.add(Duration(days: 1));
      // AppDialog(context: context).normalDialog(
      //     title: 'ระบบการแจ้งเตือน', message: 'จะเริ่มแจ้งวันพรุ่งนี่ นะครับ');
      startNoti();
    }
  }

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
