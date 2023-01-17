// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class SugarModel {
  final String uid;
  final String sugar;
  final String timesugar;
  final Timestamp timeRecord;
  SugarModel({
    required this.uid,
    required this.sugar,
    required this.timesugar,
    required this.timeRecord,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'sugar': sugar,
      'timesugar': timesugar,
      'timeRecord': timeRecord,
    };
  }

  factory SugarModel.fromMap(Map<String, dynamic> map) {
    return SugarModel(
      uid: (map['uid'] ?? '') as String,
      sugar: (map['sugar'] ?? '') as String,
      timesugar: (map['timesugar'] ?? '') as String,
      timeRecord: (map['timeRecord']),
    );
  }

  String toJson() => json.encode(toMap());

  factory SugarModel.fromJson(String source) => SugarModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
