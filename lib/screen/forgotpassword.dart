import 'package:animate_do/animate_do.dart';
import 'package:checkwan/Model/UserModel.dart';
import 'package:checkwan/screen/loginscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';

class Forgotpassword extends StatefulWidget {
  const Forgotpassword({super.key});

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  final _formKey = GlobalKey<FormState>();
  final Duration duration = const Duration(milliseconds: 800);
  Users user = Users(
      bdate: '',
      age: '',
      email: '',
      fname: '',
      lname: '',
      other: '',
      password: '',
      pnumber: '',
      time: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        // height: double.infinity,
        // width: double.infinity,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FadeInUp(
                      duration: duration,
                      delay: const Duration(milliseconds: 2000),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "ลืมรหัสผ่านใช่หรือไม่?",
                            style: GoogleFonts.prompt(
                              color: Colors.red.shade400,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    FadeInUp(
                      duration: duration,
                      delay: const Duration(milliseconds: 1600),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "กรุณากรอกอีเมลของคุณ",
                            style: GoogleFonts.prompt(
                              color: Colors.red.shade400,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    FadeInUp(
                        duration: duration,
                        delay: const Duration(milliseconds: 600),
                        child: Box()),
                    FadeInUp(
                      duration: duration,
                      delay: const Duration(milliseconds: 600),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Button(),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    FadeInUp(
                      duration: duration,
                      delay: const Duration(milliseconds: 600),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "ลิงก์รีเซ็ตถูกส่งไปที่อีเมลของคุณแล้ว คลิกที่ \n  ลิงก์เพื่อรีเซ็ต เพื่อเปลี่ยนรหัสผ่านของคุณ",
                            style: GoogleFonts.prompt(
                              color: Colors.grey,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Container Box() {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 130, 250, 5),
            child: Text(
              'อีเมล',
              style: GoogleFonts.prompt(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          ),
          Container(
            height: 45,
            width: 350,
            child: TextFormField(
              decoration: InputDecoration(
                filled: true,
                contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40.0)),
                  borderSide: BorderSide(color: Colors.white),
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(40.0)),
              ),
              validator: MultiValidator([
                RequiredValidator(errorText: "กรุณากรอกอีเมลให้ถูกต้อง"),
                EmailValidator(errorText: "กรุณากรอกอีเมลให้ถูกต้อง")
              ]),
              keyboardType: TextInputType.emailAddress,
              onSaved: (email) {
                user.email = email!;
              },
            ),
          ),
        ],
      ),
    );
  }

  Container Button() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
        child: Container(
          height: 50,
          width: 300,
          child: ElevatedButton(
            child: Text("เปลี่ยนรหัสผ่าน",
                style: GoogleFonts.prompt(fontSize: 18, color: Colors.white)),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromARGB(255, 54, 54, 54)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    side: BorderSide(color: Color.fromARGB(255, 54, 54, 54))),
              ),
            ),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                try {
                  await FirebaseAuth.instance
                      .sendPasswordResetEmail(email: user.email.toString())
                      .then((value) {
                    _formKey.currentState!.reset();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return LoginScreen();
                    }));
                  });
                } on FirebaseAuthException catch (e) {
                  Fluttertoast.showToast(
                      msg: "กรุณาลงทะเบียนก่อนทำรายการ",
                      gravity: ToastGravity.CENTER);
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
