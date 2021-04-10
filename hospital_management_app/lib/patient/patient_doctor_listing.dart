import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_management_app/patient/patient_appointment_booking.dart';

class Doctor {
  final int id;
  final String name;
  final String address;
  final String sex;
  final String dept;
  Doctor(@required this.id, @required this.name, @required this.address,
      @required this.sex, @required this.dept);
}

class PatientDoctorListing extends StatefulWidget {
  @override
  _PatientDoctorListingState createState() => _PatientDoctorListingState();
}

class _PatientDoctorListingState extends State<PatientDoctorListing> {
  //DATA
  List<Doctor> allDoctors = [
    Doctor(
        1234,
        'Gayathri Devi',
        'This is the address of the doctor which will be long.',
        'Female',
        'Dental'),
    Doctor(
        1234,
        'Gayathri Devi',
        'This is the address of the doctor which will be long.',
        'Female',
        'Dental'),
    Doctor(
        1234,
        'Gayathri Devi',
        'This is the address of the doctor which will be long.',
        'Female',
        'Dental'),
  ];
  @override
  Widget build(BuildContext context) {
    return allDoctors.isEmpty
        ? Center(
            child: Text(
              'We are sorry. No doctors found!',
              style: GoogleFonts.aBeeZee(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff1c1427)),
            ),
          )
        : SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, left: 8.0, right: 8.0, bottom: 20),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: 100, maxWidth: 1000),
                    child: Container(
                      height: 50.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color(0xff1c1427)),
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                            hintText: "Search with doctor name",
                            border: InputBorder.none,
                            // fillColor: Colors.orange,
                            hintStyle: TextStyle(color: Colors.white),
                            contentPadding:
                                EdgeInsets.only(left: 15.0, top: 15.0),
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                              onPressed: () {},
                              iconSize: 30.0,
                            )),
                        // onChanged: (val) {
                        //   setState(() {
                        //     searchAddr = val;
                        //   });
                        // },
                        // onSubmitted: (term) {
                        //   searchAndNavigate();
                        // },
                      ),
                    ),
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: allDoctors.length,
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
                                          allDoctors[index].dept,
                                          style: GoogleFonts.aBeeZee(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff1c1427)),
                                        ),
                                        Text(
                                          allDoctors[index].name,
                                          style: GoogleFonts.aBeeZee(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff1c1427)),
                                        ),
                                        Text(
                                          'Doctor Id: ${allDoctors[index].id}',
                                          style: GoogleFonts.aBeeZee(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff1c1427)),
                                        ),
                                        Text(
                                          'Sex: ${allDoctors[index].sex}',
                                          style: GoogleFonts.aBeeZee(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff1c1427)),
                                        ),
                                        Text(
                                          allDoctors[index].address,
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
                                                      PatientAppointmentBooking()));
                                        },
                                        child: Text(
                                          'Book an Appointment',
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
