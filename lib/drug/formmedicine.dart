import 'dart:io';

import 'package:checkwan/Model/drug.dart';
import 'package:checkwan/launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class Formmedicine extends StatefulWidget {
  const Formmedicine({Key? key}) : super(key: key);

  @override
  _FormmedicineState createState() => _FormmedicineState();
}

class _FormmedicineState extends State<Formmedicine> {
  final formkey = GlobalKey<FormState>();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  CollectionReference _drugCollection =
      FirebaseFirestore.instance.collection("drug");
  String? selectedValue;

  String? _ftime;
  String? dunit;
  String? _timedrug;
  Drug drug = Drug();

  String? value;
  String? _chosenValue;
  String? _typeya;

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'เพิ่มการทานยา',
          style: GoogleFonts.prompt(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        leading: BackButton(color: Colors.black),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Center(
            child: Column(
              children: [
                buildDname(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: buildTypedrug(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: builddamount(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 20, 0),
                  child: buildMealtime(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: builddtime(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: _buildBoximage(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 20, 70, 30),
                  child: _buildButtonsave(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildDname() {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 270, 10),
            child: Text('ชื่อยา',
                style: GoogleFonts.prompt(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
          ),
          Container(
            height: 45,
            width: 350,
            child: TextFormField(
              // initialValue: user.fname,
              //     validator: RequiredValidator(errorText: "กรุณากรอกชื่อ"),
              //     onSaved: (String? fname) {
              //       user.fname = fname;
              //     },
              // controller: bdatecontroller,
              decoration: InputDecoration(
                hintText: 'แตะเพื่อระบุ',
                hintStyle: GoogleFonts.prompt(
                    fontSize: 18, color: Colors.grey.shade400),
                filled: true,
                fillColor: Colors.grey.shade200,
                contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40.0)),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(40.0)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildTypedrug() {
    return Container(
      child: Column(
        children: [
          Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/icons/insulin.png",
                            width: 50,
                            height: 50,
                          ),
                          SizedBox(height: 5),
                          Text(
                            'ยาฉีด',
                            style: GoogleFonts.prompt(
                              fontSize: 16,
                            ),
                          ),
                          Radio(
                            value: 'ยาฉีด',
                            groupValue: _typeya,
                            activeColor: Colors.black,
                            onChanged: (value) {
                              setState(() {
                                _typeya = value as String?;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/icons/pills_1.png",
                            width: 50,
                            height: 50,
                          ),
                          SizedBox(height: 5),
                          Text('ยาเม็ด',
                              style: GoogleFonts.prompt(
                                fontSize: 16,
                              )),
                          Radio(
                            value: 'ยาเม็ด',
                            groupValue: _typeya,
                            activeColor: Colors.black,
                            onChanged: (value) {
                              setState(() {
                                _typeya = value as String?;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/icons/syrup.png",
                            width: 50,
                            height: 50,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'ยาน้ำ',
                            style: GoogleFonts.prompt(
                              fontSize: 16,
                            ),
                          ),
                          Radio(
                            value: 'ยาน้ำ',
                            groupValue: _typeya,
                            activeColor: Colors.black,
                            onChanged: (value) {
                              setState(() {
                                _typeya = value as String?;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container builddamount() {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 270, 10),
            child: Text('ปริมาณ',
                style: GoogleFonts.prompt(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
          ),
          Row(
            children: [
              Container(
                height: 45,
                width: 140,
                child: TextFormField(
                  // initialValue: user.fname,
                  //     validator: RequiredValidator(errorText: "กรุณากรอกชื่อ"),
                  //     onSaved: (String? fname) {
                  //       user.fname = fname;
                  //     },
                  // controller: bdatecontroller,
                  decoration: InputDecoration(
                    hintText: 'แตะเพื่อระบุ',
                    hintStyle: GoogleFonts.prompt(
                        fontSize: 16, color: Colors.grey.shade400),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      borderSide: BorderSide(color: Colors.grey.shade200),
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(40.0)),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text('หน่วย',
                  style: GoogleFonts.prompt(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                width: 10,
              ),
              Container(
                // height: 45,
                width: 150,
                child: Column(
                  children: [
                    DropdownButtonFormField2(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40.0)),
                          borderSide: BorderSide(color: Colors.grey.shade200),
                        ),
                        //Add isDense true and zero Padding.
                        //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade200),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        //Add more decoration as you want here
                        //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                      ),
                      isExpanded: true,
                      hint: Text(
                        '',
                        style: GoogleFonts.prompt(
                            fontSize: 16, color: Colors.grey),
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      iconSize: 30,
                      buttonHeight: 60,
                      buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      items: dunitItems
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: GoogleFonts.prompt(
                                      fontSize: 16, color: Colors.black),
                                ),
                              ))
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'กรุณาเลือกsหน่วยที่ทาน.';
                        }
                      },
                      onChanged: (String? dunit1) {
                        setState(() {
                          dunit = dunit1!;
                        });
                      },
                      onSaved: (String? damount1) {
                        drug.damount = damount1;
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  final List<String> dunitItems = [
    'ยูนิต',
    'เม็ด',
    'CC',
  ];

  Container buildMealtime() {
    return Container(
      child: Column(
        children: [
          Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: [
                    SizedBox(width: 15),
                    Radio(
                      value: 'ก่อนอาหาร',
                      groupValue: _ftime,
                      activeColor: Colors.black,
                      onChanged: (value) {
                        setState(() {
                          _ftime = value as String?;
                        });
                      },
                    ),
                    Expanded(
                        child: Text('ก่อนอาหาร',
                            style: GoogleFonts.prompt(
                              fontSize: 18,
                            )))
                  ],
                ),
                flex: 1,
              ),
              Expanded(
                child: Row(
                  children: [
                    Radio(
                      value: 'หลังอาหาร',
                      groupValue: _ftime,
                      activeColor: Colors.black,
                      onChanged: (value) {
                        setState(() {
                          _ftime = value as String?;
                        });
                      },
                    ),
                    Expanded(
                        child: Text('หลังอาหาร',
                            style: GoogleFonts.prompt(
                              fontSize: 18,
                            )))
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container builddtime() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 270, 10),
            child: Text('เวลา',
                style: GoogleFonts.prompt(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
          ),
          DropdownButtonFormField2(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade200,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(40.0)),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              //Add isDense true and zero Padding.
              //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(40),
              ),
              //Add more decoration as you want here
              //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
            ),
            isExpanded: true,
            hint: Text(
              'เลือกเวลา',
              style: GoogleFonts.prompt(fontSize: 16, color: Colors.grey),
            ),
            icon: const Icon(
              Icons.arrow_drop_down,
              color: Colors.black45,
            ),
            iconSize: 30,
            buttonHeight: 60,
            buttonPadding: const EdgeInsets.only(left: 20, right: 10),
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            items: timeItems
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: GoogleFonts.prompt(
                            fontSize: 16, color: Colors.black),
                      ),
                    ))
                .toList(),
            validator: (value) {
              if (value == null) {
                return 'กรุณาเลือกเวลาที่ทาน.';
              }
            },
            onChanged: (String? _timedrug1) {
              setState(() {
                _timedrug = _timedrug1!;
              });
            },
            onSaved: (value) {
              selectedValue = value.toString();
            },
          ),
        ],
      ),
    );
  }

  final List<String> timeItems = [
    'เช้า  กลางวัน  เย็น  ก่อนนอน',
    'เช้า  กลางวัน  เย็น',
    'เช้า  เย็น',
    'เช้า',
    'กลางวัน',
    'เย็น',
    'ก่อนนอน',
  ];

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
                              'assets/images/pills_2.png',
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
                  // eat.efood = efood1;
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
                    // if (formkey.currentState!.validate()) {
                    //   formkey.currentState!.save();
                    //   await _foodCollection.add({
                    //     //"epic": eat.epic,
                    //     "ename": eat.ename,
                    //     "efood": eat.efood,
                    //     "timefood": _mo
                    //   });
                    //   formkey.currentState!.reset();
                    //   Navigator.push(context,
                    //       MaterialPageRoute(builder: (context) {
                    //     return Launcher();
                    //   }));
                    // }
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Launcher();
                    }));
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
