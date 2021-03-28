import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_management_app/patient/patient_home_page.dart';

class PatientAppointmentBooking extends StatefulWidget {
  @override
  _PatientAppointmentBookingState createState() =>
      _PatientAppointmentBookingState();
}

class _PatientAppointmentBookingState extends State<PatientAppointmentBooking> {
  DateTime selectedDate;
  TimeOfDay selectedTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked_s = await showTimePicker(
        context: context,
        initialTime: selectedTime ?? TimeOfDay.now(),
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );
        });

    if (picked_s != null && picked_s != selectedTime)
      setState(() {
        selectedTime = picked_s;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Appointment'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Doctor Id : 1234',
                  style: GoogleFonts.aBeeZee(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff1c1427)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Doctor Name : stephen',
                  style: GoogleFonts.aBeeZee(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff1c1427)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Department: Surgery',
                  style: GoogleFonts.aBeeZee(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff1c1427)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Sex: Male',
                  style: GoogleFonts.aBeeZee(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff1c1427)),
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Card(
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 10,
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xffccffbd),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  height: 300,
                  width: 400,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Book Appointment.',
                        style: GoogleFonts.aBeeZee(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff1c1427)),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          selectedDate == null
                              ? Text(
                                  "Select a Date",
                                  style: GoogleFonts.aBeeZee(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff1c1427)),
                                )
                              : Text(
                                  "${selectedDate.toLocal()}".split(' ')[0],
                                  style: GoogleFonts.aBeeZee(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff1c1427)),
                                ),
                          SizedBox(
                            height: 30,
                            width: 100,
                            child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                onPressed: () => _selectDate(context),
                                color: Color(0xff1c1427),
                                child: Text(
                                  'Click here',
                                  style: GoogleFonts.aBeeZee(
                                      // fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          selectedTime == null
                              ? Text(
                                  "Select a Time",
                                  style: GoogleFonts.aBeeZee(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff1c1427)),
                                )
                              : Text(
                                  "${selectedTime.hourOfPeriod} : ${selectedTime.minute} ${selectedTime.period.index == 0 ? 'AM' : 'PM'}",
                                  style: GoogleFonts.aBeeZee(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff1c1427)),
                                ),
                          SizedBox(
                            height: 30,
                            width: 100,
                            child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                onPressed: () => _selectTime(context),
                                color: Color(0xff1c1427),
                                child: Text(
                                  'Click here',
                                  style: GoogleFonts.aBeeZee(
                                      // fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      SizedBox(
                        height: 40,
                        width: 220,
                        child: RaisedButton.icon(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            onPressed: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => PatientHomePage()),
                                  (Route<dynamic> route) => false);
                            },
                            icon: Icon(
                              Icons.done,
                              color: Colors.white,
                            ),
                            color: Color(0xff1c1427),
                            label: Text(
                              'Confirm Appointment',
                              style: GoogleFonts.aBeeZee(
                                  // fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
