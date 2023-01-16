import 'package:checkwan/Model/UserModel.dart';
import 'package:checkwan/profile/profilescreen.dart';
import 'package:checkwan/service/authservice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  // const HomePage({Key? key, required this.fname}) : super(key: key);
  // final String fname;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = '...';
  String email = '...';
  String fname = '...';
  String lname = '...';
  //เชื่อมต่อ Firebase
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  // final photoURL = state is ReloadImageState ? state.photoURL : null;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 70, 30, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              FutureBuilder(
                future: getUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done)
                    return Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          color: Colors.red,
                        ),
                      ),
                    );
                  // return Text('Loading....');

                  return Text(
                    'สวัสดี, $email',
                    style: GoogleFonts.prompt(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
              SizedBox(height: 2),
              Text(
                "เรามาเช็คความหวานกันเถอะ",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

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
          email = data['fname'] + '  ' + data['lname'];
        });
        print(email);
      }).catchError((e) {
        print(e);
      });
  }
}
