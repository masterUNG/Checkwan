// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Drug {
  String? dname;
  String? dtype; //ประภทยา
  String? damount; //ปริมาณยา
  String? dunit; //หน่วย
  String? ftime;
  String? time;
  String? dpic;
  String? dnote;
  Timestamp? timeStart;

  Drug({
    this.dname,
    this.dtype,
    this.damount,
    this.dunit,
    this.ftime,
    this.time,
    this.dpic,
    this.dnote,
    this.timeStart,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dname': dname,
      'dtype': dtype,
      'damount': damount,
      'dunit': dunit,
      'ftime': ftime,
      'time': time,
      'dpic': dpic,
      'dnote': dnote,
      'timeStart': timeStart,
    };
  }

  factory Drug.fromMap(Map<String, dynamic> map) {
    return Drug(
      dname: map['dname'] ?? '',
      dtype: map['dtype']?? '',
      damount: map['damount']?? '',
      dunit: map['dunit']?? '',
      ftime: map['ftime'] ?? '',
      time: map['time']?? '',
      dpic: map['dpic'] ?? '',
      dnote: map['dnote'] ?? '',
      timeStart: map['timeStart'] ,
    );
  }

  String toJson() => json.encode(toMap());

  factory Drug.fromJson(String source) =>
      Drug.fromMap(json.decode(source) as Map<String, dynamic>);
}
