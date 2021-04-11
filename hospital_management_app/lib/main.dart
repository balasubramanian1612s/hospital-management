import 'package:flutter/material.dart';
import 'package:hospital_management_app/doctor/doctor_home_page.dart';
import 'package:hospital_management_app/login_page.dart';
import 'package:hospital_management_app/patient/patient_home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.green),
      home: DoctorHomePage(),
    );
  }
}
