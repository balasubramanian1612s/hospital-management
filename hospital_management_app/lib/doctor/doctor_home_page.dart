import 'package:flutter/material.dart';
import 'package:hospital_management_app/doctor/doctor_appointments_history.dart';
import 'package:hospital_management_app/doctor/doctor_profile.dart';
import 'package:hospital_management_app/doctor/doctor_upcoming_appointments.dart';

class DoctorHomePage extends StatefulWidget {
  @override
  _DoctorHomePageState createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
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
                child: Text('Appointment History'),
              ),
              Tab(
                child: Text('Upcoming Appointments'),
              ),
              Tab(
                child: Text('Profile'),
              ),
            ],
          ),
          title: Text('Hello Dr. Doctor'),
        ),
        body: TabBarView(
          children: [
            DoctorAppointmentsHistory(),
            DoctorUpcomingAppointments(),
            DoctorProfile(),
          ],
        ),
      ),
    );
  }
}
