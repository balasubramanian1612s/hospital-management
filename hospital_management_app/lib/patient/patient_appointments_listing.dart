import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_management_app/doctor/doctor_upcoming_appointments.dart';
import 'package:hospital_management_app/patient/patient_doctor_listing.dart';
import 'package:hospital_management_app/patient/patient_prescription_page.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Appointments {
  final int appointmentId;
  final int docId;
  final Doctor doctor;
  final int patientId;
  final Patient patient;
  final String prescription;
  final DateTime date;
  final String time;
  final bool accepted;
  Appointments(
    @required this.appointmentId,
    @required this.docId,
    @required this.doctor,
    @required this.patientId,
    @required this.patient,
    @required this.prescription,
    @required this.date,
    @required this.time,
    @required this.accepted,
  );
}

class PatientAppointmentsListing extends StatefulWidget {
  @override
  _PatientAppointmentsListingState createState() =>
      _PatientAppointmentsListingState();
}

class _PatientAppointmentsListingState
    extends State<PatientAppointmentsListing> {
  Database database;
  //DATA
  List<Appointments> allAppointments = [];
  int patientId = 1;

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget yesButton = FlatButton(
      child: Text("Yes"),
      onPressed: () {},
    );
    Widget noButton = FlatButton(
      child: Text("No"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Alert!"),
      content: Text("Are you sure you want to cancel the appointment?"),
      actions: [yesButton, noButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> _retrieveAppointments() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'myDatabase.db');
    database = await openDatabase(path);
    print('Opened database');
    List<Map> _retrievedDoctorData =
        await database.rawQuery('SELECT * FROM DOCTOR');
    Map<int, Map> _retrievedDoctors = {};
    _retrievedDoctorData
        .forEach((doctor) => _retrievedDoctors[doctor['id']] = doctor);
    List<Map> _retrievedPatientData =
        await database.rawQuery('SELECT * FROM PATIENT');
    Map<int, Map> _retrievedPatients = {};
    _retrievedPatientData
        .forEach((patient) => _retrievedPatients[patient['id']] = patient);
    List<Map> _retrievedAppointmentData = await database
        .rawQuery('SELECT * FROM APPOINTMENT WHERE patientId = "$patientId"');
    List<Appointments> _retrievedAppointments = _retrievedAppointmentData
        .map(
          (appointment) => Appointments(
            appointment['appointmentId'],
            appointment['docId'],
            Doctor(
                _retrievedDoctors[appointment['docId']]['id'],
                _retrievedDoctors[appointment['docId']]['name'],
                _retrievedDoctors[appointment['docId']]['address'],
                _retrievedDoctors[appointment['docId']]['sex'],
                _retrievedDoctors[appointment['docId']]['dept']),
            appointment['patientId'],
            Patient(
                _retrievedPatients[appointment['patientId']]['id'],
                _retrievedPatients[appointment['patientId']]['name'],
                _retrievedPatients[appointment['patientId']]['address'],
                _retrievedPatients[appointment['patientId']]['sex'],
                _retrievedPatients[appointment['patientId']]['phNo']),
            appointment['prescription'],
            DateTime.parse(appointment['date']),
            appointment['time'],
            appointment['accepted'] == 'true',
          ),
        )
        .toList();
    setState(() {
      allAppointments = _retrievedAppointments;
    });
  }

  @override
  void initState() {
    _retrieveAppointments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return allAppointments.isEmpty
        ? Center(
            child: Text(
              'You have no appointments!',
              style: GoogleFonts.aBeeZee(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff1c1427)),
            ),
          )
        : _buildMainWidget();
  }

  _buildMainWidget() {
    List<Appointments> allUpcomingAppointments = allAppointments
        .where((element) => element.date.isAfter(DateTime.now()))
        .toList();
    List<Appointments> allCompletedAppointments = allAppointments
        .where((element) => element.date.isBefore(DateTime.now()))
        .toList();
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Text(
                'Upcoming Appointments',
                style: GoogleFonts.aBeeZee(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff1c1427)),
              ),
            ),
          ),
          allUpcomingAppointments.isEmpty
              ? Center(
                  child: Text(
                    'You have NO Upcoming Appointments',
                    style: GoogleFonts.aBeeZee(
                        fontSize: 18,
                        // fontWeight: FontWeight.,
                        color: Color(0xff1c1427)),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: allUpcomingAppointments.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xff1c1427).withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ]),
                          width: 1000,
                          constraints:
                              BoxConstraints(minWidth: 100, maxWidth: 1000),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              direction: Axis.horizontal,
                              children: [
                                Icon(
                                  Icons.verified_user,
                                  size: 100,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        allUpcomingAppointments[index]
                                            .doctor
                                            .dept,
                                        style: GoogleFonts.aBeeZee(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff1c1427)),
                                      ),
                                      Text(
                                        allUpcomingAppointments[index]
                                            .doctor
                                            .name,
                                        style: GoogleFonts.aBeeZee(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff1c1427)),
                                      ),
                                      // SizedBox(
                                      //   height: 10,
                                      // ),
                                      Text(
                                        allUpcomingAppointments[index].time,
                                        style: GoogleFonts.aBeeZee(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff1c1427)),
                                      ),
                                      Text(
                                        DateFormat.yMMMMEEEEd()
                                            .format(
                                                allUpcomingAppointments[index]
                                                    .date)
                                            .toString(),
                                        style: GoogleFonts.aBeeZee(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff1c1427)),
                                      ),
                                      // SizedBox(
                                      //   height: 10,
                                      // ),
                                      Text(
                                        'Doctor Id: ${allUpcomingAppointments[index].doctor.id}',
                                        style: GoogleFonts.aBeeZee(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff1c1427)),
                                      ),
                                    ],
                                  ),
                                ),
                                // Expanded(child: Container()),
                                SizedBox(
                                  width: 40,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    height: 40,
                                    width: 200,
                                    child: !allUpcomingAppointments[index]
                                            .accepted
                                        ? RaisedButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                                side: BorderSide(
                                                    color: Color(0xff1c1427))),
                                            onPressed: () {
                                              showAlertDialog(context);
                                            },
                                            child: Text(
                                              'Cancel Appointment',
                                              style: GoogleFonts.aBeeZee(
                                                  // fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xff1c1427)),
                                            ),
                                            color: Colors.white)
                                        : RaisedButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            onPressed: () {},
                                            child: Text(
                                              'Appointment Confirmed',
                                              style: GoogleFonts.aBeeZee(
                                                  // fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                            color: Color(0xff1c1427),
                                          ),
                                  ),
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Text(
                'Appointments History',
                style: GoogleFonts.aBeeZee(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff1c1427)),
              ),
            ),
          ),
          allCompletedAppointments.isEmpty
              ? Center(
                  child: Text(
                    'You have NO Appointments history',
                    style: GoogleFonts.aBeeZee(
                        fontSize: 18,
                        // fontWeight: FontWeight.,
                        color: Color(0xff1c1427)),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: allCompletedAppointments.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xff1c1427).withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ]),
                          width: 1000,
                          constraints:
                              BoxConstraints(minWidth: 100, maxWidth: 1000),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              direction: Axis.horizontal,
                              children: [
                                Icon(
                                  Icons.verified_user,
                                  size: 100,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        allCompletedAppointments[index]
                                            .doctor
                                            .dept,
                                        style: GoogleFonts.aBeeZee(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff1c1427)),
                                      ),
                                      Text(
                                        allCompletedAppointments[index]
                                            .doctor
                                            .name,
                                        style: GoogleFonts.aBeeZee(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff1c1427)),
                                      ),
                                      // SizedBox(
                                      //   height: 10,
                                      // ),
                                      Text(
                                        allCompletedAppointments[index].time,
                                        style: GoogleFonts.aBeeZee(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff1c1427)),
                                      ),
                                      Text(
                                        DateFormat.yMMMMEEEEd()
                                            .format(
                                                allCompletedAppointments[index]
                                                    .date)
                                            .toString(),
                                        style: GoogleFonts.aBeeZee(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff1c1427)),
                                      ),
                                      // SizedBox(
                                      //   height: 10,
                                      // ),
                                      Text(
                                        'Doctor Id: ${allCompletedAppointments[index].doctor.id}',
                                        style: GoogleFonts.aBeeZee(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff1c1427)),
                                      ),
                                    ],
                                  ),
                                ),
                                // Expanded(child: Container()),
                                SizedBox(
                                  width: 40,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    height: 40,
                                    width: 200,
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (c) =>
                                                    PatientPrescriptionPage(
                                                        allCompletedAppointments[
                                                            index])));
                                      },
                                      child: Text(
                                        'View Prescription',
                                        style: GoogleFonts.aBeeZee(
                                            // fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      color: Color(0xff1c1427),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
        ],
      ),
    );
  }
}
