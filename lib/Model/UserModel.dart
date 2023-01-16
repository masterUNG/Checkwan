import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Users {
  String? id;
  String? email;
  String? password;
  String? fname;
  String? lname;
  String? bdate;
  String? pnumber;
  String? time;
  String? age;
  String? other;

  Users({
    this.id,
    this.email,
    this.password,
    this.fname,
    this.lname,
    this.bdate,
    this.pnumber,
    this.time,
    this.age,
    this.other,
  });

// class Users {
//   final String? id;
//   final String? email;
//   final String? password;
//   final String? fname;
//   final String? lname;
//   final String? bdate;
//   final String? pnumber;
//   final String? time;
//   final String? age;
//   final String? other;

//   Users({
//     this.id,
//     required this.email,
//     required this.password,
//     required this.fname,
//     required this.lname,
//     required this.bdate,
//     required this.pnumber,
//     required this.time,
//     required this.age,
//     required this.other,
//   });

  // toJson() {
  //   return {
  //     'id': id,
  //     'email': email,
  //     'password': password,
  //     'fname': fname,
  //     'lname': lname,
  //     'bdate': bdate,
  //     'pnumber': pnumber,
  //     'time': time,
  //     'age': age,
  //     'other': other,
  //   };
  // }

  // factory Users.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
  //   final data = document.data()!;
  //   return Users(
  //     id: document.id,
  //     email: data["email"],
  //     password: data["password"],
  //     fname: data[" fname"],
  //     lname: data["lname"],
  //     bdate: data["bdate"],
  //     pnumber: data["pnumber"],
  //     time: data["time"],
  //     age: data["age"],
  //     other: data["other"],
  //   );
  // }
}
