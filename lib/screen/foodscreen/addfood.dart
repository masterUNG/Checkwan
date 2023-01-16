import 'package:avatar_view/avatar_view.dart';
import 'package:checkwan/Model/food.dart';
import 'package:checkwan/animation/FadeAnimation.dart';
import 'package:checkwan/launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';

class AddFoodScreen extends StatefulWidget {
  const AddFoodScreen({Key? key}) : super(key: key);

  @override
  _AddFoodScreenState createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  final formkey = GlobalKey<FormState>();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  CollectionReference _foodCollection =
      FirebaseFirestore.instance.collection("Food");
  Eat eat = Eat();

  final ImagePicker imagePicker = ImagePicker();
  PickedFile? imgXFile;
  String? _mo;

  void getImageFromGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      imgXFile = pickedFile!;
    });
    Navigator.pop(context);
  }

  void _openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    setState(() {
      imgXFile = pickedFile!;
    });
    Navigator.pop(context);
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("กรุณาเลือก",
                style: GoogleFonts.prompt(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  ListTile(
                    onTap: () {
                      getImageFromGallery(context);
                    },
                    title: Text("แกลเลอรี",
                        style: GoogleFonts.prompt(
                            color: Colors.black, fontSize: 18)),
                    leading: Icon(
                      Icons.add_photo_alternate_rounded,
                      color: Colors.black,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      _openCamera(context);
                    },
                    title: Text("กล้อง",
                        style: GoogleFonts.prompt(
                            color: Colors.black, fontSize: 18)),
                    leading: Icon(
                      Icons.party_mode_rounded,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(60, 0, 0, 0),
          child: Text(
            'บันทึกอาหารที่ทาน',
            style: GoogleFonts.prompt(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
        leading: BackButton(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              _buildButton(),
              _buildBoximage(),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 20, 70, 0),
                child: _buildButtonsave(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container _buildButton() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 10, 20, 0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                        child: Column(children: [
                      Image.asset(
                        "assets/images/sun1.png",
                        width: 60,
                        height: 50,
                      ),
                      Text(
                        'เช้า',
                        style: GoogleFonts.prompt(
                          fontSize: 18,
                        ),
                      ),
                      Radio(
                        value: 'เช้า',
                        groupValue: _mo,
                        activeColor: Colors.black,
                        onChanged: (value) {
                          setState(() {
                            _mo = value as String?;
                          });
                        },
                      ),
                    ])),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                        child: Column(children: [
                      Image.asset(
                        "assets/images/sun2.png",
                        width: 60,
                        height: 50,
                      ),
                      Text('กลางวัน',
                          style: GoogleFonts.prompt(
                            fontSize: 18,
                          )),
                      Radio(
                        value: 'กลางวัน',
                        groupValue: _mo,
                        activeColor: Colors.black,
                        onChanged: (value) {
                          setState(() {
                            _mo = value as String?;
                          });
                        },
                      ),
                    ])),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(children: [
                        Image.asset(
                          "assets/images/sun3.png",
                          width: 60,
                          height: 50,
                        ),
                        Text('เย็น',
                            style: GoogleFonts.prompt(
                              fontSize: 18,
                            )),
                        Radio(
                          value: 'เย็น',
                          groupValue: _mo,
                          activeColor: Colors.black,
                          onChanged: (value) {
                            setState(() {
                              _mo = value as String?;
                            });
                          },
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Theme.of(context).hintColor.withOpacity(0.2),
              offset: Offset(0, 5),
              blurRadius: 5),
        ],
      ),
    );
  }

  Container _buildBoximage() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Theme.of(context).hintColor.withOpacity(0.2),
              offset: Offset(0, 5),
              blurRadius: 20),
        ],
      ),
      child: Container(
        padding: EdgeInsets.only(left: 20, top: 5, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: GestureDetector(
                onTap: () async {
                  _showChoiceDialog(context);
                },
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.yellow,
                      backgroundImage: imgXFile == null
                          ? null
                          : FileImage(File(imgXFile!.path)),
                      child: imgXFile == null
                          ? Image.asset(
                              'assets/images/salad.png',
                              width: 100,
                              height: 100,
                            )
                          : null,
                    ),
                    Positioned(
                      bottom: 1,
                      right: 1,
                      child: Container(
                        height: 40,
                        width: 40,
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ), //เพิ่มรูป
            SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 50, 0),
              child: Column(
                children: [
                  Text(
                    'ชื่ออาหาร',
                    style: GoogleFonts.prompt(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            TextFormField(
                decoration: InputDecoration(
                  labelText: "แตะเพื่อระบุ",
                  labelStyle: GoogleFonts.prompt(
                      fontSize: 15, color: Colors.grey.shade400),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                ),
                onSaved: (String? ename1) {
                  eat.ename = ename1;
                }),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 50, 0),
              child: Column(
                children: [
                  Text('อธิบายเพิ่มเติม',
                      style: GoogleFonts.prompt(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            TextFormField(
                decoration: InputDecoration(
                  labelText: "แตะเพื่อระบุ",
                  labelStyle: GoogleFonts.prompt(
                      fontSize: 15, color: Colors.grey.shade400),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade200)),
                ),
                onSaved: (String? efood1) {
                  eat.efood = efood1;
                }),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }

  Container _buildButtonsave() {
    return Container(
      child: Column(children: [
        Row(
          children: <Widget>[
            Expanded(
              child: (Container(
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      formkey.currentState!.save();
                      await _foodCollection.add({
                        //"epic": eat.epic,
                        "ename": eat.ename,
                        "efood": eat.efood,
                        "timefood": _mo
                      });
                      formkey.currentState!.reset();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Launcher();
                      }));
                    }
                  },
                  child: Text(
                    'ยืนยัน',
                    style:
                        GoogleFonts.prompt(fontSize: 18, color: Colors.white),
                  ),
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 54, 54, 54)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            side: BorderSide(
                                color: Color.fromARGB(255, 54, 54, 54)))),
                  ),
                ),
              )),
            ),
          ],
        ),
      ]),
    );
  }
}
