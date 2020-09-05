import 'package:ecommerce/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    title: "Ecommerce",
    debugShowCheckedModeBanner: false,
    home: Login(),
  ));
}
