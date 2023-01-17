import 'package:animate_do/animate_do.dart';
import 'package:checkwan/launcher.dart';
import 'package:checkwan/screen/forgotpassword.dart';
import 'package:checkwan/screen/homepage.dart';
import 'package:checkwan/screen/homescreen.dart';
import 'package:checkwan/screen/register.dart';
import 'package:checkwan/service/authservice.dart';
import 'package:checkwan/service/authservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  // const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final Duration duration = const Duration(milliseconds: 800);
  bool showpassword = false;
  bool _validate = false;
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        key: _formKey,
        child: SafeArea(
          child: Stack(
            children: [
              // Container(
              //   height: MediaQuery.of(context).size.height,
              //   width: MediaQuery.of(context).size.width,
              //   color: Colors.white,
              // ),
              FadeInUp(
                duration: duration,
                delay: const Duration(milliseconds: 2000),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 50, 0, 0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "สวัสดี! ยินดีต้อนรับสู่... ",
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
                  padding: const EdgeInsets.fromLTRB(30, 90, 0, 0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "แอปพลิเคชันเช็กหวาน",
                      style: GoogleFonts.prompt(
                        color: Colors.red.shade400,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              FadeInUp(
                duration: duration,
                delay: const Duration(milliseconds: 1000),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: buildBox(context),
                ),
              ),
              FadeInUp(
                duration: duration,
                delay: const Duration(milliseconds: 600),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 660, 20, 0),
                  child: Row(
                    children: [
                      buildBackButton(),
                      SizedBox(width: 125),
                      // buildForgotPasswordButton(),
                    ],
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(30, 680, 20, 0),
              //   child: buildBackButton(),
              // )
            ],
          ),
        ),
      ),
    );
  }

  Container buildBox(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 180, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Theme.of(context).hintColor.withOpacity(0.2),
              offset: Offset(0, 5),
              blurRadius: 10),
        ],
      ),
      child: Container(
        padding: EdgeInsets.only(left: 0, top: 20, right: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "ล็อกอิน",
                style: GoogleFonts.prompt(
                  fontSize: 23,
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 30),
            buildUser(),
            SizedBox(height: 20),
            buildPassword(),
            SizedBox(height: 35),
            buildSigninButton(),
            SizedBox(height: 20),
            buildForgotPasswordButton(),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Container buildUser() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: TextFormField(
          controller: emailcontroller,
          decoration: InputDecoration(
            errorText: _validate ? 'กรุณากรอกอีเมลให้ถูกต้อง' : null,
            labelText: "อีเมล",
            labelStyle:
                GoogleFonts.prompt(fontSize: 16, color: Colors.grey.shade600),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400)),
          ),
        ),
      ),
    );
  }

  Container buildPassword() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: TextFormField(
          obscureText: showpassword == true ? false : true,
          controller: passwordcontroller,
          decoration: InputDecoration(
            errorText: _validate ? 'กรุณากรอกรหัสผ่านให้ถูกต้อง' : null,
            labelText: "รหัสผ่าน",
            labelStyle:
                GoogleFonts.prompt(fontSize: 16, color: Colors.grey.shade600),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400)),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  showpassword = !showpassword;
                });
              },
              child: Icon(
                showpassword == false
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: Colors.grey.shade300,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container buildSigninButton() {
    return Container(
      width: 250,
      height: 50,
      child: ElevatedButton(
        child: Text("เข้าสู่ระบบ",
            style: GoogleFonts.prompt(fontSize: 18, color: Colors.white)),
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(Color.fromARGB(255, 54, 54, 54)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
                side: BorderSide(color: Color.fromARGB(255, 54, 54, 54))),
          ),
        ),
        onPressed: () {
          final String email = emailcontroller.text.trim();
          final String password = passwordcontroller.text.trim();

          setState(() {
            emailcontroller.text.isEmpty ? _validate = true : _validate = false;
            if (email.isEmpty) {
              print("Email is Empty");
            } else {
              if (password.isEmpty) {
                print("Password is Empty");
              } else {
                context
                    .read<AuthService>()
                    .login(
                      email,
                      password,
                    )
                    .then((value) {
                  //    Navigator.push(
                  // context,
                  // PageTransition(
                  //     type: PageTransitionType.rightToLeft,
                  //     child: HomePage()));

                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Launcher(),
                      ),
                      (route) => false);
                });
              }
            }
          });
        },
        // if (email.isEmpty) {
        //   print("Email is Empty");
        // } else {
        //   if (password.isEmpty) {
        //     print("Password is Empty");
        //   } else {
        //     context.read<AuthService>().login(
        //           email,
        //           password,
        //         );
        //     Navigator.pushNamed(context, '/pageone');
        //   }
        // }
      ),
    );
  }

  Container buildForgotPasswordButton() {
    return Container(
      width: 250,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Forgotpassword();
          }));
        },
        child: Text(
          'ลืมรหัสผ่าน?',
          style: GoogleFonts.prompt(fontSize: 18),
        ),
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  side: BorderSide(color: Colors.white))),
        ),
      ),
    );
  }

  // Container buildRegisterButton() {
  //   return Container(
  //     width: 160,
  //     height: 40,
  //     child: ElevatedButton(
  //       child: Text("ลงทะเบียน",
  //           style: GoogleFonts.prompt(fontSize: 18, color: Colors.white)),
  //       style: ButtonStyle(
  //         backgroundColor:
  //             MaterialStateProperty.all<Color>(Colors.red.shade400),
  //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
  //           RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(18.0),
  //               side: BorderSide(color: Colors.red.shade400)),
  //         ),
  //       ),
  //       onPressed: () {
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(builder: (context) {
  //             return RegisterScreen();
  //           }),
  //         );
  //       },
  //     ),
  //   );
  // }

  Container buildBackButton() {
    return Container(
      child: FloatingActionButton(
        child: Icon(Icons.arrow_back_ios_new, color: Colors.white),
        backgroundColor: Color.fromARGB(255, 54, 54, 54),
        foregroundColor: Color.fromARGB(255, 54, 54, 54),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return HomeScreen();
          }),
        ),
      ),
    );
  }
}
