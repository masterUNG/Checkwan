import 'package:animate_do/animate_do.dart';
import 'package:checkwan/screen/loginscreen.dart';
import 'package:checkwan/screen/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Duration duration = const Duration(milliseconds: 800);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.all(8),
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ///
            FadeInUp(
              duration: duration,
              delay: const Duration(milliseconds: 2000),
              child: Container(
                margin: const EdgeInsets.only(
                  top: 100,
                  left: 5,
                  right: 5,
                ),
                width: size.width,
                height: 200,
                child: Image.asset("assets/icons/logo.png"),
              ),
            ),

            /// TITLE
            FadeInUp(
              duration: duration,
              delay: const Duration(milliseconds: 1600),
              child: Text(
                "CHECK WAN",
                style: GoogleFonts.prompt(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),

            ///
            const SizedBox(
              height: 10,
            ),

            /// SUBTITLE
            FadeInUp(
              duration: duration,
              delay: const Duration(milliseconds: 1000),
              child: Text(
                "ยินดีต้อนรับเข้าสู่แอปพลิเคชัน เช็กหวาน \n หวังว่าคุณจะสนุกและเพลิดเพลินไปกับแอปพลิเคชัน\nของเรา",
                textAlign: TextAlign.center,
                style: GoogleFonts.prompt(
                    height: 1.2,
                    color: Colors.grey,
                    fontSize: 17,
                    fontWeight: FontWeight.w300),
              ),
            ),

            ///
            Expanded(child: Container()),

            //GOOGLE BTN
            FadeInUp(
              duration: duration,
              delay: const Duration(milliseconds: 600),
              child: SButton(
                size: size,
                borderColor: Colors.grey,
                color: Colors.white,
                // img: 'assets/icons/logo.png',
                text: "เข้าสู่ระบบ",
                textStyle: GoogleFonts.prompt(
                    fontSize: 18, color: Color.fromARGB(255, 1, 1, 0)),
              ),
            ),

            ///
            const SizedBox(
              height: 20,
            ),

            /// GITHUB BTN
            FadeInUp(
              duration: duration,
              delay: const Duration(milliseconds: 200),
              child: SButton2(
                size: size,
                borderColor: Colors.white,
                color: const Color.fromARGB(255, 54, 54, 54),
                // img: 'assets/icons/logo.png',
                text: "ลงทะเบียน",
                textStyle:
                    GoogleFonts.prompt(fontSize: 18, color: Colors.white),
              ),
            ),

            ///
            const SizedBox(
              height: 90,
            ),
          ],
        ),
      ),
    );
  }
}

class SButton extends StatelessWidget {
  const SButton({
    Key? key,
    required this.size,
    required this.color,
    required this.borderColor,
    required this.text,
    required this.textStyle,
  }) : super(key: key);

  final Size size;
  final Color color;
  final Color borderColor;

  final String text;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: ((context) => LoginScreen()),
          ),
        );
      },
      child: Container(
        width: 300,
        height: size.height / 15,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).hintColor.withOpacity(0.2),
                offset: Offset(0, 5),
                blurRadius: 10),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}

class SButton2 extends StatelessWidget {
  const SButton2({
    Key? key,
    required this.size,
    required this.color,
    required this.borderColor,
    required this.text,
    required this.textStyle,
  }) : super(key: key);

  final Size size;
  final Color color;
  final Color borderColor;

  final String text;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return RegisterScreen();
          }),
        );
      },
      child: Container(
        width: 300,
        height: size.height / 15,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).hintColor.withOpacity(0.2),
                offset: Offset(0, 5),
                blurRadius: 10),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}
