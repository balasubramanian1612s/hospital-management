import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hospital_management_app/doctor/doctor_home_page.dart';
import 'package:hospital_management_app/login_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
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

class Application extends StatefulWidget {
  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  static Database database;
  Future<void> open() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'myDatabase.db');
    database = await openDatabase(path, version: 1, onCreate: _onCreate);
    print('Opened database');
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE DOCTOR (
            id INTEGER PRIMARY KEY,
            name TEXT NOT NULL,
            address TEXT NOT NULL,
            sex TEXT NOT NULL,
            dept TEXT NOT NULL
          )
          ''');
    await db.execute('''
          CREATE TABLE PATIENT (
            id INTEGER PRIMARY KEY,
            name TEXT NOT NULL,
            address TEXT NOT NULL,
            sex TEXT NOT NULL,
            phNo INTEGER NOT NULL
          )
          ''');
    await db.execute('''
          CREATE TABLE APPOINTMENT (
            appointmentId INTEGER PRIMARY KEY,
            docId INTEGER NOT NULL,
            patientId INTEGER NOT NULL,
            prescription TEXT NOT NULL,
            date TEXT NOT NULL,
            time TEXT NOT NULL,
            accepted TEXT NOT NULL
          )
          ''');
  }

  @override
  void initState() {
    print('init state running');
    initDatabase();
    super.initState();
  }

  void initDatabase() async {
    await open();
    // await database.delete('DOCTOR');
    // await database.transaction((txn) async {
    //   int id = await txn.rawInsert(
    //       'INSERT INTO PATIENT(id,name,address,sex,phNo) VALUES(1,"Lilly","May Drive","FEMALE",455743)');

    //   print('inserted $id');
    // });
    // await database.transaction((txn) async {
    //   int id = await txn.rawInsert(
    //       'INSERT INTO PATIENT(id,name,address,sex,phNo) VALUES(2,"Ted","Apple Hills","MALE",867556)');

    //   print('inserted $id');
    // });
    List<Map> list = await database.rawQuery('SELECT * FROM PATIENT');
    print(list);
  }

  @override
  Widget build(BuildContext context) {
    return PatientHomePage();
  }
}
