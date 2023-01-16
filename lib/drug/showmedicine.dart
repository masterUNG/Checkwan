import 'package:checkwan/drug/formmedicine.dart';
import 'package:checkwan/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Showmedicine extends StatefulWidget {
  const Showmedicine({Key? key}) : super(key: key);

  @override
  _ShowmedicineState createState() => _ShowmedicineState();
}

class _ShowmedicineState extends State<Showmedicine> {
  var now = DateTime.now();
  CollectionReference _drugCollection =
      FirebaseFirestore.instance.collection("drug");
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
        title: Text('ข้อมูลยา',
            style: GoogleFonts.prompt(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
        leading: BackButton(color: Colors.black),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black),
            tooltip: 'เพิ่มยา',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Formmedicine();
              }));
            },
          )
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("drug").snapshots(),
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
                                          15, 40, 10, 20),
                                      child: Column(children: [
                                        ConstrainedBox(
                                          constraints: BoxConstraints(
                                            minWidth: 40,
                                            minHeight: 40,
                                            maxWidth: 40,
                                            maxHeight: 40,
                                          ),
                                          child: Image.asset(
                                              "assets/icons/syringe_2.png",
                                              width: 60,
                                              height: 50),
                                        ),
                                      ])),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 5, 10, 0),
                                            child: Row(children: [
                                              SizedBox(width: 10),
                                              Text(
                                                "ชื่อยา",
                                                style: GoogleFonts.prompt(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text('   ' + document["dname"],
                                                  style: GoogleFonts.prompt(
                                                      fontSize: 16,
                                                      height: 1.4))
                                            ])),
                                        Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
                                            child: Row(children: [
                                              SizedBox(width: 10),
                                              Text(
                                                "รูปแบบยา",
                                                style: GoogleFonts.prompt(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text('    ' + document["typeya"],
                                                  style: GoogleFonts.prompt(
                                                      fontSize: 16,
                                                      height: 1.4))
                                            ])),
                                        Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
                                            child: Row(children: [
                                              SizedBox(width: 10),
                                              Text(
                                                "จำนวน",
                                                style: GoogleFonts.prompt(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                  '        ' +
                                                      document["damount"],
                                                  style: GoogleFonts.prompt(
                                                      fontSize: 16,
                                                      height: 1.4)),
                                              Text('    ' + document["dunit"],
                                                  style: GoogleFonts.prompt(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold))
                                            ])),
                                        Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
                                            child: Row(children: [
                                              SizedBox(width: 10),
                                              Text(document["ftime"],
                                                  style: GoogleFonts.prompt(
                                                      fontSize: 16,
                                                      height: 1.4)),
                                            ])),
                                        Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
                                            child: Row(children: [
                                              SizedBox(width: 10),
                                              Text(document["timedrug"],
                                                  style: GoogleFonts.prompt(
                                                      fontSize: 16,
                                                      height: 1.4))
                                            ])),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
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
