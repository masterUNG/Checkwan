import 'package:checkwan/Appointment/addnudscreen.dart';
import 'package:checkwan/main.dart';
// import 'package:checkwan/screens/Appointment/nut.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class Shownud extends StatefulWidget {
  const Shownud({Key? key}) : super(key: key);

  @override
  _ShownudState createState() => _ShownudState();
}

class _ShownudState extends State<Shownud> {
  var now = DateTime.now();
  DatePickerController _controller = DatePickerController();
  DateTime _selectedValue = DateTime.now();
  DateTime myDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formatter = DateFormat.MMMEd();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('รายละเอียดการนัดหมาย',
            style: GoogleFonts.prompt(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
        leading: BackButton(color: Colors.black),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black),
            tooltip: 'เพิ่มนัด',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AddnudScreen();
              }));
            },
          )
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Nut").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: snapshot.data!.docs.map((document) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).hintColor.withOpacity(0.2),
                          offset: Offset(0, 5),
                          blurRadius: 10),
                    ],
                  ),
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                      child: Row(children: <Widget>[
                        Expanded(
                          child: Row(children: [
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 40),
                                  Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          5, 30, 5, 20),
                                      child: Column(children: [
                                        ConstrainedBox(
                                          constraints: BoxConstraints(
                                            minWidth: 45,
                                            minHeight: 45,
                                            maxWidth: 45,
                                            maxHeight: 45,
                                          ),
                                          child: Image.asset(
                                              "assets/images/doctor_2.png",
                                              width: 60,
                                              height: 60),
                                        ),
                                      ])),
                                  Container(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 5, 10, 0),
                                              child: Row(children: [
                                                SizedBox(width: 10),
                                                Text(
                                                  "วันที่นัดหมาย",
                                                  style: GoogleFonts.prompt(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text('   ' + document["ndate"],
                                                    style: GoogleFonts.prompt(
                                                        fontSize: 15,
                                                        height: 1.4))
                                              ])),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 10, 0),
                                              child: Row(children: [
                                                SizedBox(width: 10),
                                                Text(
                                                  "เวลานัดหมาย",
                                                  style: GoogleFonts.prompt(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text('   ' + document["ntime"],
                                                    style: GoogleFonts.prompt(
                                                        fontSize: 15,
                                                        height: 1.4))
                                              ])),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 10, 0),
                                              child: Row(children: [
                                                SizedBox(width: 10),
                                                Text(
                                                  "ชื่อแพทย์",
                                                  style: GoogleFonts.prompt(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                    '         ' +
                                                        document["ndoc"],
                                                    style: GoogleFonts.prompt(
                                                        fontSize: 15,
                                                        height: 1.4)),
                                              ])),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 10, 0),
                                              child: Row(children: [
                                                SizedBox(width: 10),
                                                Text(
                                                  "โรงพยาบาล",
                                                  style: GoogleFonts.prompt(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text('     ' + document["nhos"],
                                                    style: GoogleFonts.prompt(
                                                        fontSize: 15,
                                                        height: 1.4))
                                              ])),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ]),
                                  ),
                                ]),
                          ]),
                        ),
                      ]),
                    ),
                  ]),
                );
              }).toList(),
            );
          }),
    );
  }
}
