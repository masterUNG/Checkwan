import 'package:checkwan/screen/homescreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthService {
  final FirebaseAuth _auth;

  AuthService(this._auth);

  Stream<User?> get authStateChanges => _auth.idTokenChanges();

  Future<String> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "Logged In";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> signUp(
    String email,
    String password,
    String fname,
    String lname,
    String bdate,
    String pnumber,
    String time,
    String age,
    String other,
    // String uploadTask,
  ) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        User? user = FirebaseAuth.instance.currentUser;

        await FirebaseFirestore.instance
            .collection('profile')
            .doc(user!.uid)
            .set({
          'uid': user.uid,
          'email': email,
          'password': password,
          'fname': fname,
          'lname': lname,
          'bdate': bdate,
          'pnumber': pnumber,
          'time': time,
          'age': age,
          'other': other,
          // 'imageUrl': uploadTask,
        });
      });
      return "Signed Up";
    } catch (e) {
      return e.toString();
    }
  }
}
