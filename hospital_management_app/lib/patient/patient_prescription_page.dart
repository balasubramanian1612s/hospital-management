import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_management_app/doctor/doctor_upcoming_appointments.dart';
import 'package:hospital_management_app/patient/patient_appointments_listing.dart';
import 'package:intl/intl.dart';

class PatientPrescriptionPage extends StatefulWidget {
  Appointments ap;
  PatientPrescriptionPage(this.ap);
  @override
  _PatientPrescriptionPageState createState() =>
      _PatientPrescriptionPageState();
}

class _PatientPrescriptionPageState extends State<PatientPrescriptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prescription'),
      ),
      body: Column(
        children: [
          Padding(
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
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ]),
                width: 1000,
                constraints: BoxConstraints(minWidth: 100, maxWidth: 1000),
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
                              // allCompletedAppointments[index].dept,
                              widget.ap.patient.name,
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff1c1427)),
                            ),

                            // SizedBox(
                            //   height: 10,
                            // ),
                            Text(
                              // allCompletedAppointments[index].time,
                              widget.ap.time,
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff1c1427)),
                            ),
                            Text(
                              // DateFormat.yMMMMEEEEd()
                              //     .format(
                              //         allCompletedAppointments[index]
                              //             .date)
                              //     .toString(),
                              widget.ap.date.toString(),
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff1c1427)),
                            ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            Text(
                              // 'Doctor Id: ${allCompletedAppointments[index].id}',
                              'Patient Id: ${widget.ap.patient.id}',
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
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: SizedBox(
                      //     height: 40,
                      //     width: 200,
                      //     child: RaisedButton(
                      //       shape: RoundedRectangleBorder(
                      //           borderRadius:
                      //               BorderRadius.all(Radius.circular(20))),
                      //       onPressed: () {},
                      //       child: Text(
                      //         'View Prescription',
                      //         style: GoogleFonts.aBeeZee(
                      //             // fontSize: 30,
                      //             fontWeight: FontWeight.bold,
                      //             color: Colors.white),
                      //       ),
                      //       color: Color(0xff1c1427),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        width: 40,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: 100, maxWidth: 1000),
              child: Container(
                width: 1000,
                decoration: BoxDecoration(
                    color: Color(0xffccffbd),
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
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ]),

                // height: 500,
                // width: 400,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Prescription',
                        style: GoogleFonts.aBeeZee(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff1c1427)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.ap.prescription,
                        style: GoogleFonts.aBeeZee(
                            fontSize: 15,
                            // fontWeight: FontWeight.bold,
                            color: Color(0xff1c1427)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
