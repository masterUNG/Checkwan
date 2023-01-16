import 'dart:math';

import 'package:avatar_view/avatar_view.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:checkwan/Model/UserModel.dart';
import 'package:checkwan/screen/loginscreen.dart';
import 'package:checkwan/screen/process.dart';
import 'package:checkwan/service/authservice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'dart:io';

final today = DateUtils.dateOnly(DateTime.now());

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  CollectionReference _reference =
      FirebaseFirestore.instance.collection('profile');
  final _formKey = GlobalKey<FormState>();
  Users user = Users();
  bool showpassword = false;
  bool _validate = false;
  bool _fnamecontroller = true;
  bool _lnamecontroller = true;
  bool isLoading = false;

//เตรียมการเชื่อมต่อ Firebase
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  late DateFormat dateFormat;
  final TextEditingController emailcontroller = new TextEditingController();
  final TextEditingController passwordcontroller = new TextEditingController();
  final TextEditingController fnamecontroller = new TextEditingController();
  final TextEditingController lnamecontroller = new TextEditingController();
  final TextEditingController bdatecontroller = new TextEditingController();
  final TextEditingController pnumbercontroller = new TextEditingController();
  final TextEditingController timecontroller = new TextEditingController();
  final TextEditingController agecontroller = new TextEditingController();
  final TextEditingController othercontroller = new TextEditingController();
  String? sex, typesugar, rok;
  String? uploadTask;
  String fname = '...';
  final ImagePicker imagePicker = ImagePicker();
  PickedFile? imgXFile;

  void _selectDate() async {
    DateTime? newDateTime = await showRoundedDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1957, 1),
        lastDate: DateTime(2050, 12),
        locale: Locale("th", "TH"),
        era: EraMode.BUDDHIST_YEAR,
        borderRadius: 16,
        theme: ThemeData(primarySwatch: Colors.grey),
        styleDatePicker: MaterialRoundedDatePickerStyle(
          textStyleDayButton:
              GoogleFonts.prompt(fontSize: 25, color: Colors.black),
          textStyleYearButton:
              GoogleFonts.prompt(fontSize: 18, color: Colors.white),
          textStyleMonthYearHeader:
              GoogleFonts.prompt(fontSize: 18, color: Colors.black),
          textStyleDayHeader:
              GoogleFonts.prompt(fontSize: 18, color: Colors.black),
          textStyleCurrentDayOnCalendar: GoogleFonts.prompt(
              fontSize: 17, color: Colors.black, fontWeight: FontWeight.bold),
          textStyleDayOnCalendar:
              GoogleFonts.prompt(fontSize: 16, color: Colors.grey),
          textStyleDayOnCalendarSelected: GoogleFonts.prompt(fontSize: 18),
          textStyleButtonPositive: GoogleFonts.prompt(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          textStyleButtonNegative:
              GoogleFonts.prompt(fontSize: 18, color: Colors.grey[500]),
          paddingDateYearHeader: EdgeInsets.fromLTRB(10, 10, 10, 10),
          paddingMonthHeader: EdgeInsets.all(10),
          paddingDatePicker: EdgeInsets.all(0),
          sizeArrow: 30,
        ),
        styleYearPicker: MaterialRoundedYearPickerStyle(
            textStyleYear: GoogleFonts.prompt(fontSize: 18, color: Colors.grey),
            textStyleYearSelected: GoogleFonts.prompt(
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.bold)));
    if (newDateTime != null) {
      setState(() {
        bdatecontroller.value =
            TextEditingValue(text: dateFormat.format(newDateTime).toString());
      });
    }
  }

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

  @override
  void initState() {
    // กำหนดรูปแบบการจัดการวันที่และเวลา
    Intl.defaultLocale = 'th';
    initializeDateFormatting();
    dateFormat = DateFormat('d/MMMM/y', 'th');
    getUser();
    updateProfileData();
  }

  @override
  void dispose() {
    bdatecontroller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //สำหรับตรวจสอบfirebase ทำงานได้หรือไม่
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
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.black),
                title: Text('โปรไฟล์',
                    style: GoogleFonts.prompt(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  key: _formKey,
                  child: Stack(
                    children: [
                      Center(
                        child: Column(
                          children: [
                            SizedBox(height: 15),
                            _profileimage(),
                            SizedBox(height: 15),
                            buildNameUser(),
                            buildBirthday(),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(50, 10, 0, 0),
                              child: Row(
                                children: [
                                  buildTitleSex(),
                                  SizedBox(width: 2),
                                  buildSex1(),
                                ],
                              ),
                            ),
                            buildSex2(),
                            buildTel(),
                            SizedBox(height: 10),
                            buildTitleTypeSugser(),
                            buildTypeSugser1(),
                            buildTypeSugser2(),
                            buildHistory(),
                            buildAge(),
                            SizedBox(height: 10),
                            buildTitleRok(),
                            buildRok1(),
                            buildRok2(),
                            buildRok3(),
                            buildOther(),
                            buildBoxOther(),
                            buildUser(),
                            buildPassword(),
                            SizedBox(height: 20),
                            buildRegisterButton(),
                            SizedBox(height: 30),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          } //กรณีที่ไม่เกิด Error ให้โหลดข้อมูลหน้าแอปพลิเคชัน
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                color: Colors.red,
              ),
            ),
          );
        });
  }

  Container _profileimage() {
    return Container(
      child: GestureDetector(
        onTap: () async {
          _showChoiceDialog(context);
        },
        child: Stack(
          children: [
            CircleAvatar(
              radius: 80,
              backgroundColor: Colors.yellow,
              backgroundImage:
                  imgXFile == null ? null : FileImage(File(imgXFile!.path)),
              child: imgXFile == null
                  ? Icon(
                      Icons.person,
                      color: Colors.yellow.shade700,
                      size: 50,
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
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildNameUser() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                height: 45,
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  // initialValue: user.fname,
                  controller: fnamecontroller,
                  decoration: InputDecoration(
                    hintText: 'ชื่อ*',
                    hintStyle: GoogleFonts.prompt(
                        fontSize: 18, color: Colors.grey.shade400),
                    errorText: _fnamecontroller ? null : "Name too short",
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
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                height: 45,
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  controller: lnamecontroller,
                  decoration: InputDecoration(
                    hintText: 'นามสกุล*',
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
            ),
          ],
        ),
      ),
    );
  }

  Container buildBirthday() {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 210, 10),
            child: Text('วันเดือนปีเกิด',
                style: GoogleFonts.prompt(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
          ),
          Container(
            height: 45,
            width: 350,
            child: TextFormField(
              controller: bdatecontroller,
              decoration: InputDecoration(
                hintText: 'วว/ดด/ปปปป',
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
              onTap: _selectDate,
              readOnly: true,
            ),
          ),
        ],
      ),
    );
  }

  Container buildTitleSex() {
    return Container(
      height: 45,
      width: 70,
      child: Text(
        'เพศ*',
        style: GoogleFonts.prompt(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Container buildSex1() {
    return Container(
      height: 45,
      width: 150,
      child: RadioListTile(
        value: 'ชาย',
        groupValue: sex,
        activeColor: Colors.red[400],
        onChanged: (value) {
          setState(
            () {
              sex = value as String;
            },
          );
        },
        title: Text(
          'ชาย',
          style: GoogleFonts.prompt(
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Container buildSex2() {
    return Container(
      height: 45,
      width: 150,
      child: RadioListTile(
        value: 'หญิง',
        groupValue: sex,
        activeColor: Colors.red[400],
        onChanged: (value) {
          setState(
            () {
              sex = value as String;
            },
          );
        },
        title: Text(
          'หญิง',
          style: GoogleFonts.prompt(
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Container buildTel() {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Container(
              height: 45,
              width: MediaQuery.of(context).size.width,
              child: TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.]+')),
                  LengthLimitingTextInputFormatter(10)
                ],
                controller: pnumbercontroller,
                decoration: InputDecoration(
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
                  errorText: _validate ? 'กรุณากรอกเบอร์โทรศัพท์' : null,
                  hintText: 'เบอร์โทรศัพท์*',
                  hintStyle: GoogleFonts.prompt(
                      fontSize: 18, color: Colors.grey.shade400),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildTitleTypeSugser() {
    return Container(
      height: 30,
      width: 300,
      child: Text(
        'เป็นเบาหวานชนิดที่*',
        style: GoogleFonts.prompt(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Container buildTypeSugser1() {
    return Container(
      height: 40,
      width: 155,
      child: RadioListTile(
        value: 'ชนิดที่ 1',
        groupValue: typesugar,
        activeColor: Colors.red[400],
        onChanged: (value) {
          setState(
            () {
              typesugar = value as String;
            },
          );
        },
        title: Text(
          'ชนิดที่ 1',
          style: GoogleFonts.prompt(
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Container buildTypeSugser2() {
    return Container(
      width: 155,
      child: RadioListTile(
        value: 'ชนิดที่ 2',
        groupValue: typesugar,
        activeColor: Colors.red[400],
        onChanged: (value) {
          setState(
            () {
              typesugar = value as String;
            },
          );
        },
        title: Text(
          'ชนิดที่ 2',
          style: GoogleFonts.prompt(
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Container buildHistory() {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 170, 0),
            child: Column(
              children: [
                Text('ประวัติโรคเบาหวาน',
                    style: GoogleFonts.prompt(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(60, 10, 60, 0),
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: Text('เมื่อปี พ.ศ.',
                            style: GoogleFonts.prompt(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9.]+')),
                            LengthLimitingTextInputFormatter(4)
                          ],
                          controller: timecontroller,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40.0)),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade200),
                            ),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade200),
                                borderRadius: BorderRadius.circular(40.0)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container buildAge() {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(70, 10, 50, 0),
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: Text('อายุ',
                            style: GoogleFonts.prompt(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9.]+')),
                            LengthLimitingTextInputFormatter(3)
                          ],
                          controller: agecontroller,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40.0)),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade200),
                            ),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade200),
                                borderRadius: BorderRadius.circular(40.0)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Expanded(
                      child: Container(
                        child: Text('ปี',
                            style: GoogleFonts.prompt(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container buildTitleRok() {
    return Container(
      height: 30,
      width: 300,
      child: Text(
        'โรคประจำตัว',
        style: GoogleFonts.prompt(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Container buildRok1() {
    return Container(
      height: 40,
      width: 300,
      child: RadioListTile(
        value: 'ความดัน',
        groupValue: rok,
        activeColor: Colors.red[400],
        onChanged: (value) {
          setState(
            () {
              rok = value as String?;
            },
          );
        },
        title: Text(
          'ความดัน',
          style: GoogleFonts.prompt(
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Container buildRok2() {
    return Container(
      height: 40,
      width: 300,
      child: RadioListTile(
        value: 'ไขมันในเลือดสูง',
        groupValue: rok,
        activeColor: Colors.red[400],
        onChanged: (value) {
          setState(
            () {
              rok = value as String;
            },
          );
        },
        title: Text(
          'ไขมันในเลือดสูง',
          style: GoogleFonts.prompt(
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Container buildRok3() {
    return Container(
      height: 40,
      width: 300,
      child: RadioListTile(
        value: 'โรคหลอดเลือดหัวใจ',
        groupValue: rok,
        activeColor: Colors.red[400],
        onChanged: (value) {
          setState(
            () {
              rok = value as String;
            },
          );
        },
        title: Text(
          'โรคหลอดเลือดหัวใจ',
          style: GoogleFonts.prompt(
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Container buildOther() {
    return Container(
      width: 300,
      child: RadioListTile(
        value: 'อื่นๆ ระบุ',
        groupValue: rok,
        activeColor: Colors.red[400],
        onChanged: (value) {
          setState(
            () {
              rok = value as String;
            },
          );
        },
        title: Text(
          'อื่นๆ ระบุ',
          style: GoogleFonts.prompt(
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Container buildBoxOther() {
    return Container(
      child: Column(
        children: [
          Container(
            height: 45,
            width: 350,
            child: TextFormField(
              controller: othercontroller,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40.0)),
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(40.0))),
            ),
          ),
        ],
      ),
    );
  }

  Container buildUser() {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 230, 10),
            child: Text('อีเมล',
                style: GoogleFonts.prompt(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
          ),
          Container(
            height: 45,
            width: 350,
            child: TextFormField(
              // initialValue: user.email,
              controller: emailcontroller,
              decoration: InputDecoration(
                errorText: _validate ? 'กรุณากรอกอีเมล' : null,
                hintText: 'example@gmail.com',
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
              keyboardType: TextInputType.emailAddress,
            ),
          ),
        ],
      ),
    );
  }

  Container buildPassword() {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 230, 10),
            child: Text('รหัสผ่าน',
                style: GoogleFonts.prompt(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
          ),
          Container(
            height: 45,
            width: 350,
            child: TextFormField(
              // initialValue: user.password,
              controller: passwordcontroller,
              obscureText: showpassword == true ? false : true,
              decoration: InputDecoration(
                errorText: _validate ? 'กรุณากรอกรหัสผ่าน' : null,
                hintText: '******',
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
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Container buildRegisterButton() {
    return Container(
      height: 50,
      width: 300,
      child: ElevatedButton(
        child: Text("เข้าสู่ระบบ",
            style: GoogleFonts.prompt(fontSize: 18, color: Colors.white)),
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(Color.fromARGB(255, 54, 54, 54)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                side: BorderSide(color: Color.fromARGB(255, 54, 54, 54))),
          ),
        ),
        onPressed: () async {
          createAccountAndInsertInformation();
        },
      ),
    );
  }

  Future<Null> createAccountAndInsertInformation() async {
    final String email = emailcontroller.text.trim();
    final String password = passwordcontroller.text.trim();
    final String fname = fnamecontroller.text.trim();
    final String lname = lnamecontroller.text.trim();
    final String bdate = bdatecontroller.text.trim();
    final String pnumber = pnumbercontroller.text.trim();
    final String time = timecontroller.text.trim();
    final String age = agecontroller.text.trim();
    final String other = othercontroller.text.trim();
    // final String imgXFile = imgXFilecontroller.text.trim();

    setState(() {
      if (email.isEmpty) {
        print("Email is Empty");
      } else {
        if (password.isEmpty) {
          print("Password is Empty");
        } else {
          uploadPicture();
          context
              .read<AuthService>()
              .signUp(
                email,
                password,
                fname,
                lname,
                bdate,
                pnumber,
                time,
                age,
                other,
                // uploadTask,
              )
              .then(
            (value) async {
              User? user = FirebaseAuth.instance.currentUser;

              await FirebaseFirestore.instance
                  .collection("profile")
                  .doc(user!.uid)
                  .set({
                'uid': user.uid,
                'email': email,
                'password': password,
                'fname': fname,
                'lname': lname,
                'bdate': bdate,
                'sex': sex,
                'pnumber': pnumber,
                'typesugar': typesugar,
                'time': time,
                'age': age,
                'rok': rok,
                'other': other,
                // 'imageUrl': uploadTask,
              });
            },
          );
          Navigator.pushNamed(context, '/login');
        }
      }
    });
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
        fnamecontroller.text = data['fname'];
        lnamecontroller.text = data['lname'];
        bdatecontroller.text = data['bdate'];
        emailcontroller.text = data['email'];
        passwordcontroller.text = data['password'];
      }).catchError((e) {
        print(e);
      });
  }

  updateProfileData() async {
    await FirebaseFirestore.instance
        .collection('profile')
        .doc(user.id)
        .update({}).catchError((e) {
      print(e);
    });
  }

  Future<void> uploadPicture() async {
    Random random = Random();
    int i = random.nextInt(10000);

    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    Reference ref = firebaseStorage
        .ref()
        .child('profile/profile$i.jpg' + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(File(imgXFile!.path));
    // await uploadTask.whenComplete(() async {
    //   downloadUrl = await firebaseStorage.getDownloadURL();
    // });
    uploadTask.then((res) {
      res.ref.getDownloadURL();
      print('imgXFile!.path');
    });
    // return downloadUrl;
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("กรุณาเลือก",
              style: GoogleFonts.prompt(
                  fontSize: 18,
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
                          color: Color.fromARGB(255, 54, 54, 54),
                          fontSize: 16)),
                  leading: Icon(
                    Icons.account_box,
                    color: Color.fromARGB(255, 54, 54, 54),
                  ),
                ),
                Divider(
                  height: 1,
                  color: Color.fromARGB(255, 54, 54, 54),
                ),
                ListTile(
                  onTap: () {
                    _openCamera(context);
                  },
                  title: Text(
                    "กล้อง",
                    style: GoogleFonts.prompt(
                        fontSize: 16, color: Color.fromARGB(255, 54, 54, 54)),
                  ),
                  leading: Icon(
                    Icons.camera,
                    color: Color.fromARGB(255, 54, 54, 54),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
