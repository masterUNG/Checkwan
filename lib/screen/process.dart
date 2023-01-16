import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';

class ProcessTest extends StatefulWidget {
  const ProcessTest({super.key});

  @override
  State<ProcessTest> createState() => _ProcessTestState();
}

class _ProcessTestState extends State<ProcessTest> {
  final _formKey = GlobalKey<FormState>();

  CollectionReference _reference =
      FirebaseFirestore.instance.collection('profile');

  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
