import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_management_app/patient/patient_appointments_listing.dart';
import 'package:hospital_management_app/patient/patient_doctor_listing.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';

class Patient {
  final int id;
  final String name;
  final String address;
  final String sex;
  final int phNo;
  Patient(@required this.id, @required this.name, @required this.address,
      @required this.sex, @required this.phNo);
}

class DoctorUpcomingAppointments extends StatefulWidget {
  @override
  _DoctorUpcomingAppointmentsState createState() =>
      _DoctorUpcomingAppointmentsState();
}

class _DoctorUpcomingAppointmentsState
    extends State<DoctorUpcomingAppointments> {
  Database database;
  int doctorId = 1;
  List<Appointments> allAppointments = [];

  Future<void> _retrieveAppointments() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'myDatabase.db');
    database = await openDatabase(path);
    print('Opened database');
    await _retrieveAppointmentData();
  }

  Future<void> _updateAppointmentStatus(int appointmentId) async {
    await database.rawUpdate(
        'UPDATE APPOINTMENT SET accepted = "true" WHERE appointmentId = $appointmentId');
    await _retrieveAppointmentData();
  }

  Future<void> _retrieveAppointmentData() async {
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
        .rawQuery('SELECT * FROM APPOINTMENT WHERE docId = "$doctorId"');
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
    List<Appointments> allUpcomingAppointments = allAppointments
        .where((element) =>
            element.date.isAfter(DateTime.now()) && element.accepted == true)
        .toList();
    List<Appointments> allUnacceptedAppointments = allAppointments
        .where((element) =>
            element.date.isAfter(DateTime.now()) && element.accepted == false)
        .toList();

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
        .where((element) =>
            element.date.isAfter(DateTime.now()) && element.accepted == true)
        .toList();
    List<Appointments> allUnacceptedAppointments = allAppointments
        .where((element) =>
            element.date.isAfter(DateTime.now()) && element.accepted == false)
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
                                            .patient
                                            .name,
                                        style: GoogleFonts.aBeeZee(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff1c1427)),
                                      ),
                                      Text(
                                        'Patient Id: ${allUpcomingAppointments[index].patient.id}',
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
                                        'Contact: ${allUpcomingAppointments[index].patient.phNo}',
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
                                        // Navigator.of(context).push(
                                        //     MaterialPageRoute(
                                        //         builder: (c) =>
                                        //             PatientPrescriptionPage()));
                                      },
                                      child: Text(
                                        'Edit Prescription',
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
                'Pending for Approval',
                style: GoogleFonts.aBeeZee(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff1c1427)),
              ),
            ),
          ),
          allUnacceptedAppointments.isEmpty
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
                  itemCount: allUnacceptedAppointments.length,
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
                                        allUnacceptedAppointments[index]
                                            .patient
                                            .name,
                                        style: GoogleFonts.aBeeZee(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff1c1427)),
                                      ),
                                      Text(
                                        'Patient Id: ${allUnacceptedAppointments[index].patient.id}',
                                        style: GoogleFonts.aBeeZee(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff1c1427)),
                                      ),
                                      // SizedBox(
                                      //   height: 10,
                                      // ),
                                      Text(
                                        allUnacceptedAppointments[index].time,
                                        style: GoogleFonts.aBeeZee(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff1c1427)),
                                      ),
                                      Text(
                                        DateFormat.yMMMMEEEEd()
                                            .format(
                                                allUnacceptedAppointments[index]
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
                                        'Contact: ${allUnacceptedAppointments[index].patient.phNo}',
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
                                      onPressed: () async {
                                        await _updateAppointmentStatus(
                                            allUnacceptedAppointments[index]
                                                .appointmentId);
                                        // Navigator.of(context).push(
                                        //     MaterialPageRoute(
                                        //         builder: (c) =>
                                        //             PatientPrescriptionPage()));
                                      },
                                      child: Text(
                                        'Accept Appointment',
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
