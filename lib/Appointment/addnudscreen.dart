import 'package:checkwan/launcher.dart';
import 'package:checkwan/model/nut.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class AddnudScreen extends StatefulWidget {
  const AddnudScreen({Key? key}) : super(key: key);

  @override
  _AddnudScreenState createState() => _AddnudScreenState();
}

class _AddnudScreenState extends State<AddnudScreen> {
  final formkey = GlobalKey<FormState>();
  Nut nut = Nut();
  var now = DateTime.now();
  DatePickerController _controller = DatePickerController();
  DateTime _selectedValue = DateTime.now();
  DateTime myDateTime = DateTime.now();
  late DateFormat dateFormat; // รูปแบบการจัดการวันที่และเวลา
  final _ndate = TextEditingController();
  final _ntime = TextEditingController();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  CollectionReference _nutCollection =
      FirebaseFirestore.instance.collection("Nut");

  void _Date() async {
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
        _ndate.value =
            TextEditingValue(text: dateFormat.format(newDateTime).toString());
      });
    }
  }

  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (newTime != null) {
      setState(() {
        _ntime.value = TextEditingValue(text: newTime.format(context));
      });
    }
  }

  @override
  void initState() {
    Intl.defaultLocale = 'th';
    initializeDateFormatting();
    dateFormat = DateFormat('d/MM/y', 'en');
  }

  @override
  void dispose() {
    _ndate.dispose();
    _ntime.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formatter = DateFormat.MMMM();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('เพิ่มการนัดหมาย',
            style: GoogleFonts.prompt(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
        leading: BackButton(color: Colors.black),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Form(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color:
                                  Theme.of(context).hintColor.withOpacity(0.2),
                              offset: Offset(0, 5),
                              blurRadius: 20),
                        ],
                      ),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(40, 5, 40, 20),
                        child: Column(children: [
                          SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "ใบนัด",
                              style: GoogleFonts.prompt(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Form(
                              key: formkey,
                              child: Column(children: [
                                Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                    child: Row(children: [
                                      Container(
                                        width: 100,
                                        height: 50,
                                        child: Row(children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 70, 0, 0),
                                          ),
                                          Container(
                                            width: 30,
                                            height: 30,
                                            decoration: new BoxDecoration(
                                              image: new DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/calendar.png'),
                                                fit: BoxFit.fitHeight,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            child: Text("วันที่",
                                                style: GoogleFonts.prompt(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                          ),
                                        ]),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 40,
                                          width: 100,
                                          child: TextFormField(
                                              style: GoogleFonts.prompt(),
                                              decoration: InputDecoration(
                                                labelText: 'วว/ดด/ปป',
                                                filled: true,
                                                fillColor: Colors.white,
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        50, 5, 20, 5),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                  borderSide: BorderSide(
                                                      color:
                                                          Colors.grey.shade200),
                                                ),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors
                                                            .grey.shade200),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                              controller: _ndate,
                                              onTap: _Date,
                                              readOnly: true,
                                              onSaved: (String? ndate) {
                                                nut.ndate = ndate;
                                              }),
                                        ),
                                        flex: 5,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                    ])),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Row(
                                    children: [
                                      Container(
                                        child: Row(children: <Widget>[
                                          Container(
                                            width: 30,
                                            height: 30,
                                            decoration: new BoxDecoration(
                                              image: new DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/clock.png'),
                                                fit: BoxFit.fitHeight,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            child: Text("เวลา",
                                                style: GoogleFonts.prompt(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                          ),
                                        ]),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 40,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: TextFormField(
                                              style: GoogleFonts.prompt(),
                                              decoration: InputDecoration(
                                                labelText: '00.00',
                                                filled: true,
                                                fillColor: Colors.white,
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        60, 5, 20, 5),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                  borderSide: BorderSide(
                                                      color:
                                                          Colors.grey.shade200),
                                                ),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors
                                                            .grey.shade200),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                              controller: _ntime,
                                              onTap: _selectTime,
                                              readOnly: true,
                                              onSaved: (String? ntime) {
                                                nut.ntime = ntime;
                                              }),
                                        ),
                                        flex: 2,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "น.",
                                        style: GoogleFonts.prompt(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 50,
                                        child: Row(children: <Widget>[
                                          Container(
                                              width: 30,
                                              height: 30,
                                              decoration: new BoxDecoration(
                                                image: new DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/doctor_1.png'),
                                                  fit: BoxFit.fitHeight,
                                                ),
                                              )),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            child: Text("แพทย์",
                                                style: GoogleFonts.prompt(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                          ),
                                        ]),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 40,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: TextFormField(
                                              style: GoogleFonts.prompt(),
                                              decoration: InputDecoration(
                                                labelText: 'ชื่อแพทย์',
                                                filled: true,
                                                fillColor: Colors.white,
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        60, 5, 20, 5),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                  borderSide: BorderSide(
                                                      color:
                                                          Colors.grey.shade200),
                                                ),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors
                                                            .grey.shade200),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                              validator: RequiredValidator(
                                                  errorText: "ชื่อแพทย์"),
                                              onSaved: (String? ndoc1) {
                                                nut.ndoc = ndoc1;
                                              }),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Row(
                                    children: [
                                      Container(
                                        child: Row(children: <Widget>[
                                          Container(
                                              width: 30,
                                              height: 30,
                                              decoration: new BoxDecoration(
                                                image: new DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/hospital.png'),
                                                  fit: BoxFit.fitHeight,
                                                ),
                                              )),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            child: Text("โรงพยาบาล",
                                                style: GoogleFonts.prompt(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                          ),
                                        ]),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 40,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: TextFormField(
                                              style: GoogleFonts.prompt(),
                                              decoration: InputDecoration(
                                                labelText: 'ชื่อโรงพยาบาล',
                                                filled: true,
                                                fillColor: Colors.white,
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        25, 5, 0, 5),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                  borderSide: BorderSide(
                                                      color:
                                                          Colors.grey.shade200),
                                                ),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors
                                                            .grey.shade200),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                              validator: RequiredValidator(
                                                  errorText: "ชื่อโรงพยาบาล"),
                                              onSaved: (String? nhos1) {
                                                nut.nhos = nhos1;
                                              }),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ])),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 100, 30, 0),
                            child: Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: (Container(
                                    height: 40,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (formkey.currentState!.validate()) {
                                          formkey.currentState!.save();
                                          await _nutCollection.add({
                                            "ndate": nut.ndate,
                                            "ntime": nut.ntime,
                                            "ndoc": nut.ndoc,
                                            "nhos": nut.nhos,
                                          });
                                          formkey.currentState!.reset();
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return Launcher();
                                          }));
                                        }
                                      },
                                      child: Text(
                                        'ยืนยัน',
                                        style: GoogleFonts.prompt(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                      style: ButtonStyle(
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.red.shade400),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25.0),
                                                side: BorderSide(
                                                    color:
                                                        Colors.red.shade400))),
                                      ),
                                    ),
                                  )),
                                ),
                              ],
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
