import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PatientProfile extends StatefulWidget {
  @override
  _PatientProfileState createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 10,
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xffccffbd),
              borderRadius: BorderRadius.all(Radius.circular(15))),
          height: 400,
          width: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Profile.',
                style: GoogleFonts.aBeeZee(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff1c1427)),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Patient Id : 1234',
                  style: GoogleFonts.aBeeZee(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff1c1427)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Patient Name : stephen',
                  style: GoogleFonts.aBeeZee(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff1c1427)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Address: My Address is Sooooooooooooooooo o o o o Long .',
                  textAlign: TextAlign.center,
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Contact Number: ',
                  style: GoogleFonts.aBeeZee(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff1c1427)),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 40,
                width: 220,
                child: RaisedButton.icon(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    onPressed: () {},
                    icon: Icon(
                      Icons.done,
                      color: Colors.white,
                    ),
                    color: Color(0xff1c1427),
                    label: Text(
                      'Edit Profile',
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
    );
  }
}
