import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:checkwan/Appointment/shownud.dart';
import 'package:checkwan/animation/FadeAnimation.dart';
import 'package:checkwan/drug/formmedicine.dart';
import 'package:checkwan/drug/showmedicine.dart';
import 'package:checkwan/profile/profilescreen.dart';
import 'package:checkwan/screen/foodscreen/addfood.dart';
import 'package:checkwan/sugarscreen/sugarscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter/widgets.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const appTitle = '';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: appTitle,
    );
  }
}

class AddinfoScreen extends StatefulWidget {
  @override
  _AddinfoScreenState createState() => _AddinfoScreenState();
}

class _AddinfoScreenState extends State<AddinfoScreen> {
  String name = '...';
  String email = '...';
  String fname = '...';
  String lname = '...';
  //เชื่อมต่อ Firebase
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  FirebaseAuth auth = FirebaseAuth.instance;

  List<List> _settings = [
    [
      'บันทึกอาหารที่ทาน',
      'บันทึกอาหารในแต่ละมื้อของคุณ',
      Icons.dinner_dining,
      Colors.yellow[400]
    ],
    [
      'เพิ่มการทานยา',
      'บันทึกหรือเพิ่มยาที่คุณทาน',
      Icons.medical_services,
      Colors.purple[200]
    ],
    [
      'บันทึกค่าน้ำตาล',
      'บันทึกค่าน้ำตาลตามเวลา',
      Icons.icecream,
      Colors.red[400]
    ],
    [
      'เพิ่มการนัดหมาย',
      'เพิ่มการพบแพทย์',
      Icons.local_hospital,
      Colors.green[300]
    ],
  ];

  Future<String?> getUser() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null)
      await FirebaseFirestore.instance
          .collection('profile')
          .doc(user.uid)
          .get()
          .then((data) {
        setState(() {
          name = data['fname'] + " " + data['lname'];
          email = data['email'];
          // emailcontroller.text = data['email'];
        });
      }).catchError((e) {
        print(e);
      });
  }

  int activeStatus = 0;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUser(),
      builder: (context, snapshot) {
        //กรณีที่่มี Error เกิดขึ้นจาการเชี่ยมต่อ
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Error"),
            ),
            body: Center(
              child: Text("${snapshot.error}"),
            ),
          );
        }
        // ถ้าเชื่อมต่อ firebase สำเร็จ
        if (snapshot.connectionState == ConnectionState.done)
          //กรณีที่ไม่เกิด Error ให้โหลดข้อมูลหน้าแอปพลิเคชัน
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                color: Colors.red,
              ),
            ),
          );
        return Padding(
          padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 10, 20),
                child: Container(
                  child: Row(
                    children: [
                      FadeAnimation(
                        1.2,
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey[200],
                          backgroundImage: NetworkImage(
                              'https://randomuser.me/api/portraits/men/81.jpg'),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FadeAnimation(
                            1.2,
                            Text(
                              '$name',
                              style: GoogleFonts.prompt(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          FadeAnimation(
                            1.2,
                            Text(
                              '$email',
                              style: GoogleFonts.prompt(
                                color: Colors.grey.shade600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfileScreen()));
                            },
                            icon: FadeAnimation(
                              1,
                              Icon(
                                Icons.mode_edit_outline_outlined,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).hintColor.withOpacity(0.2),
                          offset: Offset(0, 3),
                          blurRadius: 5),
                    ],
                  ),
                  child: Container(
                    height: 450,
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _settings.length,
                        itemBuilder: (context, index) {
                          return FadeAnimation(
                              (1.0 + index) / 4,
                              settingsOption(
                                  _settings[index][0],
                                  _settings[index][1],
                                  _settings[index][2],
                                  _settings[index][3]));
                        }),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FadeAnimation(
                1.2,
                Container(
                  width: 230,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      // _signOut();
                      await Firebase.initializeApp().then((value) =>
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/login', (route) => false));
                    },
                    child: Text(
                      'ออกจากระบบ',
                      style:
                          GoogleFonts.prompt(fontSize: 18, color: Colors.white),
                    ),
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.red.shade400),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red.shade400),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              side: BorderSide(color: Colors.red.shade400))),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  settingsOption(String title, String subtitle, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 12, 5, 15),
      child: ListTile(
        onTap: () {
          if (title == 'บันทึกอาหารที่ทาน') {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return AddFoodScreen();
            }));
          }
          if (title == 'เพิ่มการทานยา') {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Showmedicine();
            }));
          }
          if (title == 'บันทึกค่าน้ำตาล') {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Sugar_Screen();
            }));
          }
          if (title == 'เพิ่มการนัดหมาย') {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Shownud();
            }));
          }
        },
        subtitle: Text(
          subtitle,
          style: GoogleFonts.prompt(
            fontSize: 15,
          ),
        ),
        leading: Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: color,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 30,
          ),
        ),
        title: Text(
          title,
          style: GoogleFonts.prompt(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          color: Colors.grey.shade400,
        ),
      ),
    );
  }

  // Future<void> _signOut() async {
  //   await FirebaseAuth.instance.signOut();
  // }
}
