import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_management_app/patient/patient_appointments_listing.dart';
import 'package:hospital_management_app/patient/patient_doctor_listing.dart';
import 'package:intl/intl.dart';

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
  List<Appointments> allAppointments = [
    Appointments(
        1,
        1234,
        Doctor(
            1234,
            'Gayathri Devi',
            'This is the address of the doctor which will be long.',
            'Female',
            'Dental'),
        2345,
        Patient(
            1234,
            'Bala',
            'This is the address of the doctor which will be long.',
            'Female',
            909),
        'Prescription',
        DateTime(2020, 03, 13, 10, 30),
        '10:30 AM',
        true),
    Appointments(
        2,
        1234,
        Doctor(
            1234,
            'Gayathri Devi',
            'This is the address of the doctor which will be long.',
            'Female',
            'Dental'),
        2345,
        Patient(
            1234,
            'Bala',
            'This is the address of the doctor which will be long.',
            'Female',
            909),
        'Prescription',
        DateTime(2021, 05, 20, 10, 30),
        '10:30 AM',
        true),
    Appointments(
        3,
        1234,
        Doctor(
            1234,
            'Gayathri Devi',
            'This is the address of the doctor which will be long.',
            'Female',
            'Dental'),
        2345,
        Patient(
            1234,
            'Bala',
            'This is the address of the doctor which will be long.',
            'Female',
            909),
        'Prescription',
        DateTime(2021, 05, 20, 10, 30),
        '10:30 AM',
        false)
  ];
  @override
  Widget build(BuildContext context) {
    List<Appointments> allUpcomingAppointments = allAppointments
        .where((element) => element.date.isAfter(DateTime.now()))
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
        : allUpcomingAppointments.isEmpty
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
                                offset:
                                    Offset(0, 3), // changes position of shadow
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          .format(allUpcomingAppointments[index]
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
                });
  }
}
