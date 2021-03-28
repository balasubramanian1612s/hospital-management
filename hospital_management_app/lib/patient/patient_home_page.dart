import 'package:flutter/material.dart';
import 'package:hospital_management_app/patient/patient_appointments_listing.dart';
import 'package:hospital_management_app/patient/patient_doctor_listing.dart';
import 'package:hospital_management_app/patient/patient_profile.dart';

class PatientHomePage extends StatefulWidget {
  @override
  _PatientHomePageState createState() => _PatientHomePageState();
}

class _PatientHomePageState extends State<PatientHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text('Doctors'),
              ),
              Tab(
                child: Text('My Appointments'),
              ),
              Tab(
                child: Text('Profile'),
              ),
            ],
          ),
          title: Text('Hello Mr. Patient'),
        ),
        body: TabBarView(
          children: [
            PatientDoctorListing(),
            PatientAppointmentsListing(),
            PatientProfile(),
          ],
        ),
      ),
    );
  }
}
