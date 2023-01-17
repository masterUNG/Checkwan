// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class FoodModel {
  final String nameFood;
  final String detailFood;
  final String urlImage;
  final String uid;
  final String timeFood;
  final Timestamp timestampFood;
  FoodModel({
    required this.nameFood,
    required this.detailFood,
    required this.urlImage,
    required this.uid,
    required this.timeFood,
    required this.timestampFood,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nameFood': nameFood,
      'detailFood': detailFood,
      'urlImage': urlImage,
      'uid': uid,
      'timeFood': timeFood,
      'timestampFood': timestampFood,
    };
  }

  factory FoodModel.fromMap(Map<String, dynamic> map) {
    return FoodModel(
      nameFood: (map['nameFood'] ?? '') as String,
      detailFood: (map['detailFood'] ?? '') as String,
      urlImage: (map['urlImage'] ?? '') as String,
      uid: (map['uid'] ?? '') as String,
      timeFood: (map['timeFood'] ?? '') as String,
      timestampFood: (map['timestampFood'] ),
    );
  }

  String toJson() => json.encode(toMap());

  factory FoodModel.fromJson(String source) => FoodModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
