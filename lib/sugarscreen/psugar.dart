import 'package:checkwan/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Psugar extends StatefulWidget {
  const Psugar({Key? key}) : super(key: key);

  @override
  _PsugarState createState() => _PsugarState();
}

class _PsugarState extends State<Psugar> {
  var now = DateTime.now();
  CollectionReference _sugarCollection =
      FirebaseFirestore.instance.collection("sugar");
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
        title: Text('ผลน้ำตาลก่อน',
            style: GoogleFonts.prompt(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
        leading: BackButton(color: Colors.black),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("sugar").snapshots(),
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
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 40),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            5, 10, 5, 20),
                                        child: Column(children: [
                                          ConstrainedBox(
                                            constraints: BoxConstraints(
                                              minWidth: 45,
                                              minHeight: 45,
                                              maxWidth: 45,
                                              maxHeight: 45,
                                            ),
                                            child: Image.asset(
                                                "assets/icons/glucose-meter.png",
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
                                                      10, 5, 10, 0),
                                              child: Row(children: [
                                                SizedBox(width: 10),
                                                Text(
                                                  "เวลาที่ตรวจ",
                                                  style: GoogleFonts.prompt(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                    '    ก่อน' +
                                                        document["timesugar"],
                                                    style: GoogleFonts.prompt(
                                                        fontSize: 18,
                                                        height: 1.4))
                                              ])),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 0, 10, 15),
                                            child: Row(
                                              children: [
                                                SizedBox(width: 10),
                                                Text(
                                                  "ระดับน้ำตาลในเลือด",
                                                  style: GoogleFonts.prompt(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                    '  ' +
                                                        document["sugar"] +
                                                        'มก./ดล.',
                                                    style: GoogleFonts.prompt(
                                                        fontSize: 18,
                                                        height: 1.4))
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
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
