import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:checkwan/animation/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/link.dart';

class Knowledge1 extends StatefulWidget {
  const Knowledge1({Key? key}) : super(key: key);

  @override
  _Knowledge1State createState() => _Knowledge1State();
}

class _Knowledge1State extends State<Knowledge1> {
  int _current = 0;
  dynamic _selectedIndex = {};

  CarouselController _carouselController = new CarouselController();

  List<dynamic> _products = [
    {
      'title': 'สมุนไพรไทยกับการรักษาโรค \nเบาหวาน',
      'image':
          'https://www.foryoursweetheart.org/public/uploads/editor/231ec04f60be8e037bb50644f23c4b0d.jpg',
      'description':
          ' คำว่า “สมุนไพร”และ “แนวคิดของแพทย์ \n แผนไทย” ในการรักษาโรคเบาหวาน...',
      'url':
          'https://www.foryoursweetheart.org/บทความ/ไลฟ์สไตล์/อาหาร/สมุนไพรไทยกับการรักษาโรคเบาหวาน/TH',
    },
    {
      'title': 'พืชสมุนไพรลดความเสี่ยงเบาหวาน',
      'image':
          'https://www.glucerna.co.th/uploaded/article/image/15651092175d49abe1d8859.jpg',
      'description':
          ' การดูแลตัวเองของผู้ป่วยเบาหวานคือ \n ต้องควบคุมปริมาณน้ำตาลในเลือดอย่าง\n เคร่งครัด...',
      'url':
          'https://www.glucerna.co.th/diabetes/treatments/Medicinal-plants-reduce-the-risk-of-diabetes',
    },
    {
      'title': 'ผักและสมุนไพรรักษาเบาหวานได้\nจริงหรือ ?',
      'image':
          'https://res.cloudinary.com/dk0z4ums3/image/upload/v1504692754/attached_image_th/%E0%B8%9C%E0%B8%B1%E0%B8%81%E0%B9%81%E0%B8%A5%E0%B8%B0%E0%B8%AA%E0%B8%A1%E0%B8%B8%E0%B8%99%E0%B9%84%E0%B8%9E%E0%B8%A3%E0%B8%A3%E0%B8%B1%E0%B8%81%E0%B8%A9%E0%B8%B2%E0%B9%80%E0%B8%9A%E0%B8%B2%E0%B8%AB-pobpad.jpg',
      'description':
          ' พืชผักสมุนไพรหลากหลายชนิดที่กล่าวกัน \n ว่ามีสรรพคุณช่วยลดระดับน้ำตาลในเลือด \n มีคุณประโยชน์ต่อผู้ป่วยโรคเบาหวาน...',
      'url':
          'https://www.pobpad.com/%E0%B8%9C%E0%B8%B1%E0%B8%81%E0%B9%81%E0%B8%A5%E0%B8%B0%E0%B8%AA%E0%B8%A1%E0%B8%B8%E0%B8%99%E0%B9%84%E0%B8%9E%E0%B8%A3%E0%B8%A3%E0%B8%B1%E0%B8%81%E0%B8%A9%E0%B8%B2%E0%B9%80%E0%B8%9A%E0%B8%B2%E0%B8%AB',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white24,
        title: Text(
          'สมุนไพร',
          style: GoogleFonts.prompt(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(alignment: Alignment.bottomCenter, children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
          child: Container(
            width: double.infinity,
            height: 530,
            child: CarouselSlider(
                carouselController: _carouselController,
                options: CarouselOptions(
                    height: 500,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.70,
                    enlargeCenterPage: true,
                    pageSnapping: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
                items: _products.map((title) {
                  return Builder(
                    builder: (BuildContext context) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (_selectedIndex == title) {
                              _selectedIndex = {};
                            } else {
                              _selectedIndex = title;
                            }
                          });
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: _selectedIndex == title
                                  ? Border.all(color: Colors.white, width: 3)
                                  : null,
                              boxShadow: _selectedIndex == title
                                  ? [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 5,
                                          offset: Offset(0, 10))
                                    ]
                                  : [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          blurRadius: 5,
                                          offset: Offset(0, 5))
                                    ]),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  height: 250,
                                  margin: EdgeInsets.only(top: 5),
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Image.network(title['image'],
                                      fit: BoxFit.cover),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  title['title'],
                                  style: GoogleFonts.prompt(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  title['description'],
                                  style: GoogleFonts.prompt(
                                      fontSize: 14,
                                      color: Colors.grey.shade600),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Link(
                                  target: LinkTarget.blank,
                                  uri: Uri.parse(title['url']),
                                  builder: (context, followLink) => Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(70, 0, 70, 0),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          width: 300,
                                          height: 38,
                                          child: ElevatedButton(
                                            child: Text('อ่าน',
                                                style: GoogleFonts.prompt(
                                                    fontSize: 16,
                                                    color: Colors.white)),
                                            onPressed: followLink,
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                          Color>(
                                                      Colors.yellow.shade700),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18.0),
                                                    side: BorderSide(
                                                        color: Colors
                                                            .yellow.shade700)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }).toList()),
          ),
        ),
      ]),
    );
  }
}
