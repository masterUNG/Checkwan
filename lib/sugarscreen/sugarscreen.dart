import 'package:checkwan/Model/sugar.dart';
import 'package:checkwan/Model/sugar_model.dart';
import 'package:checkwan/launcher.dart';
import 'package:checkwan/service/app_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
// import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';

class Sugar_Screen extends StatefulWidget {
  const Sugar_Screen({super.key});

  @override
  State<Sugar_Screen> createState() => _Sugar_ScreenState();
}

class _Sugar_ScreenState extends State<Sugar_Screen> {
  final formkey = GlobalKey<FormState>();
  String? _eatsugar;
  String? _timesugar;
  Sugar sugar = Sugar();
  var now = DateTime.now();
  DatePickerController _controller = DatePickerController();
  DateTime _selectedValue = DateTime.now();
  DateTime myDateTime = DateTime.now();

  DateTime recordDatetime = DateTime.now();

  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  CollectionReference _sugarCollection =
      FirebaseFirestore.instance.collection("sugar");

  late DateFormat dateFormat;
  final _text1 = TextEditingController();
  void _selectDate() async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2017, 1),
      lastDate: DateTime(2022, 7),
      helpText: 'Select a date',
    );
    if (newDate != null) {
      setState(() {
        _text1.value =
            TextEditingValue(text: dateFormat.format(newDate).toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formatter = DateFormat.MMMEd();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(60, 0, 0, 0),
          child: Text('บันทึกค่าน้ำตาล',
              style: GoogleFonts.prompt(
                fontSize: 20,
                color: Colors.black,
              )),
        ),
        leading: BackButton(color: Colors.black),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, top: 5, right: 15),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                  Widget>[
            Container(
              child: Container(
                padding: EdgeInsets.only(left: 20, top: 0, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                      child: Row(
                        children: [
                          Text("วันนี้",
                              style: GoogleFonts.prompt(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Spacer(flex: 100),
                          Icon(Icons.calendar_today, size: 25),
                        ],
                      ),
                    ),
                    Text(
                        '${formatter.format(myDateTime)} ${now.year}, ${now.hour}:${now.minute} น.',
                        style: GoogleFonts.prompt(
                            fontSize: 15, color: Colors.grey.shade400)),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        DatePicker(
                          DateTime(DateTime.now().year, DateTime.now().month,
                              DateTime.now().day - 2),
                          initialSelectedDate: DateTime.now(),
                          selectionColor: Colors.yellow.shade700,
                          selectedTextColor: Colors.black,
                          onDateChange: (date) {
                            // New date selected
                            setState(() {
                              _selectedValue = date;
                              recordDatetime = date;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Align(
              alignment: Alignment.center,
              child: Text('บันทึกน้ำตาลก่อน',
                  style: GoogleFonts.prompt(
                      fontSize: 25, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 20,
            ),
/////////////////////////////////////////
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
              child: Column(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
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
                                Text('อาหารเช้า',
                                    style: GoogleFonts.prompt(
                                      fontSize: 15,
                                    )),
                                Radio(
                                  value: 'อาหารเช้า',
                                  groupValue: _timesugar,
                                  activeColor: Colors.black,
                                  onChanged: (value) {
                                    setState(() {
                                      _timesugar = value as String?;
                                    });
                                  },
                                ),
                              ]),
                            ),
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
                              Text('อาหารกลางวัน',
                                  style: GoogleFonts.prompt(
                                    fontSize: 14,
                                  )),
                              Radio(
                                value: 'อาหารกลางวัน',
                                groupValue: _timesugar,
                                activeColor: Colors.black,
                                onChanged: (value) {
                                  setState(() {
                                    _timesugar = value as String?;
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
                                width: 40,
                                height: 50,
                              ),
                              Text('อาหารเย็น',
                                  style: GoogleFonts.prompt(
                                    fontSize: 15,
                                  )),
                              Radio(
                                value: 'อาหารเย็น',
                                groupValue: _timesugar,
                                activeColor: Colors.black,
                                onChanged: (value) {
                                  setState(() {
                                    _timesugar = value as String?;
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
                                "assets/images/moon.png",
                                width: 40,
                                height: 50,
                              ),
                              Text('ก่อนนอน',
                                  style: GoogleFonts.prompt(
                                    fontSize: 15,
                                  )),
                              Radio(
                                value: 'ก่อนนอน',
                                groupValue: _timesugar,
                                activeColor: Colors.black,
                                onChanged: (value) {
                                  setState(() {
                                    _timesugar = value as String?;
                                  });
                                },
                              ),
                            ])),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ]),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).hintColor.withOpacity(0.2),
                      offset: Offset(0, 5),
                      blurRadius: 10),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),

            Form(
              key: formkey,
              child: Column(children: [
                Container(
                  padding: EdgeInsets.only(left: 0, top: 0, right: 0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 500,
                          height: 120,
                          margin:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 10, 0, 0),
                                  child: Row(children: [
                                    Expanded(
                                      child: Text(
                                        "ระดับน้ำตาลในเลือด",
                                        style: GoogleFonts.prompt(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ])),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(80, 10, 20, 0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 40,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: TextFormField(
                                            decoration: InputDecoration(
                                              hintText: 'กรุณากรอกค่าน้ำตาล',
                                              hintStyle: GoogleFonts.prompt(
                                                  fontSize: 15,
                                                  color: Colors.grey.shade400),
                                              filled: true,
                                              fillColor: Colors.white,
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      20, 5, 20, 5),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                borderSide: BorderSide(
                                                    color:
                                                        Colors.grey.shade200),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          Colors.grey.shade200),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                            validator: RequiredValidator(
                                                errorText:
                                                    "กรุณากรอกค่าน้ำตาล"),
                                            onSaved: (String? sugar1) {
                                              sugar.sugar = sugar1;
                                            }),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "มก./ดล.",
                                      style: GoogleFonts.prompt(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.red[400],
                            boxShadow: [
                              BoxShadow(
                                  color: Theme.of(context)
                                      .hintColor
                                      .withOpacity(0.2),
                                  offset: Offset(0, 5),
                                  blurRadius: 20),
                            ],
                          ),
                        ),
                      ]),
                ),
              ]),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 20),
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

                              print(
                                  '##16jan timesugar -> $_timesugar, sugar -> ${sugar.toMap()}');
                              print('##16jan timeRecord --> $recordDatetime()');

                              if (_timesugar == null) {
                                AppDialog(context: context).normalDialog(
                                    title: 'เวลาอาหาร ?',
                                    message: 'ยังไม่ได้เลือกเวลาอาหาร');
                              } else {
                                var user = FirebaseAuth.instance.currentUser;

                                SugarModel sugarModel = SugarModel(
                                    uid: user!.uid,
                                    sugar: sugar.sugar!,
                                    timesugar: _timesugar!,
                                    timeRecord:
                                        Timestamp.fromDate(recordDatetime));

                                print(
                                    '##16jan sugarModel --> ${sugarModel.toMap()}');

                                await FirebaseFirestore.instance
                                    .collection('sugar')
                                    .doc()
                                    .set(sugarModel.toMap())
                                    .then((value) => Navigator.pop(context));
                              }

                              // await _sugarCollection.add({
                              //   "timesugar": _timesugar,
                              //   "sugar": sugar.sugar,
                              // });
                              // formkey.currentState!.reset();
                              //_showinfo(context);

                              // Navigator.push(context,
                              //     MaterialPageRoute(builder: (context) {
                              //   return Launcher();
                              // }));
                            }
                          },
                          child: Text(
                            'ยืนยัน',
                            style: GoogleFonts.prompt(
                                fontSize: 18, color: Colors.white),
                          ),
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.green.shade300),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    side: BorderSide(
                                        color: Colors.green.shade300))),
                          ),
                        ),
                      )),
                    ),
                  ],
                ),
              ]),
            ),
            SizedBox(height: 30),
            ExpansionTile(
              childrenPadding: EdgeInsets.all(16).copyWith(top: 0),
              title: Text("ภาวะน้ำตาลในเลือดสูงผิดปกติ  ",
                  style: GoogleFonts.prompt(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              children: [
                Text("  ระดับน้ำตาลในเลือดสูงมากกว่า 250	มก./ดล.",
                    style: GoogleFonts.prompt(
                      fontSize: 16,
                    )),
                Text("อาการและอาการแสดง",
                    style: GoogleFonts.prompt(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                Text(
                    "   กระหายน้ำมาก ปัสสาวะบ่อย คลื่นไว้อาเจียน หงุดหงิดง่าย โมโห ฉุนเฉียว ร้องไห้งอแง หายใจเร็ว หานใจหอบลึก หายใจกลิ่นผลไม้ อ่อนเพลีย ซึม หมดสติ",
                    style: GoogleFonts.prompt(
                      fontSize: 16,
                    )),
                Text(" การช่วยแหลือเบื้องต้น ",
                    style: GoogleFonts.prompt(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                Text(
                    "1.ตรวจคีโตนในปัสสาวะ \n2.ดื่มน้ำเปล่ามากๆ และให้หยุดพักกิจกรรม \n3.หากอาการไม่ดีขึ้น เจาะน้ำตาลปลายนิ้วยังสุงอยู่คีโตนในปัสสาวะตั้งแต่  ++ ให้รีบไปโรงพยาบาล",
                    style: GoogleFonts.prompt(
                      fontSize: 16,
                    )),
              ],
            ),
            ExpansionTile(
              childrenPadding: EdgeInsets.all(16).copyWith(top: 0),
              title: Text("ภาวะน้ำตาลในเลือดต่ำ  ",
                  style: GoogleFonts.prompt(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              children: [
                Text("  ระดับน้ำตาลปลายนิ้วน้อยกว่า 70 มก./ดล.",
                    style: GoogleFonts.prompt(
                      fontSize: 16,
                    )),
                Text("อาการและอาการแสดง",
                    style: GoogleFonts.prompt(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                Text(
                    "   อ่อนเพลีย เหงื่อออก ตัวเย็น หิว มือสั่น ใจสั่น หัวใจเต็นเร็ว หงุดหงิด ไม่สนใจสิ่งแวดล้อม เอะอะโวยวาย ปวดศีรษะ สับสน ชัก หมดสติ",
                    style: GoogleFonts.prompt(
                      fontSize: 16,
                    )),
                Text(" การช่วยแหลือเบื้องต้น ",
                    style: GoogleFonts.prompt(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                Text(
                    " 1.ทานคาร์โบไฮเดรตเชิงเดี่ยวออกทธิ์ เช่นน้ำหวาน 2 ช้อนโต๊ะ (30 CC) หรือลูกอม 2-4 เม็ดหรือ น้ำผลไม้ 1 กล่อง \n 2.ตรวจน้ำตาลปลายนิ้วซ้ำหลังทาน 15 นาที \n 3.หากระดับน้ำตาลปลายนิ้วน้อยกว่า 70 อยู่ให้ทานน้ำหวาน 2 ช้อนโต๊ะ (30 CC) หรือ ลูกอม 2-4 เม็ด หรือ น้ำผลไม้ 1 กล่อง อีก 1 ครั้ง \n 4.ตรวจน้ำตาลปลายนิ้วซ้ำหลังทาน 15 นาที \n 5.หากระดับน้ำตาลปลายนิ้วมากกว่า 70 แล้วให้ทานนม 1 กล่อง หรือ ขนมปัง 1 แผ่น \n 6.หากระดับน้ำตาลปลายนิ้วยังน้อยกว่า 70 ให้รีบไปโรงพยาบาลใกล้บ้านและห้ามหยุดฉีดอินซูลิน",
                    style: GoogleFonts.prompt(
                      fontSize: 16,
                    )),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  void _showinfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: new Text("!!"),
          content: Row(children: [
            Image.asset("assets/images/Screen-Shot.png",
                width: 250, height: 100, fit: BoxFit.contain),
          ]),
          actions: <Widget>[
            new TextButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return Launcher();
                  }),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
