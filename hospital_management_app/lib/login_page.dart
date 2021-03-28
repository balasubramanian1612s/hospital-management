import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_management_app/patient/patient_home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int _radioValue = 0;

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          break;
        case 1:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1c1427),
        title: Text('Hospital Management App'),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.supervised_user_circle_sharp), onPressed: () {})
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 10,
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xffccffbd),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              height: 500,
              width: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Login.',
                    style: GoogleFonts.aBeeZee(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff1c1427)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: Container(
                      width: double.infinity,
                      child: Text(
                        'I am',
                        style: GoogleFonts.aBeeZee(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff1c1427)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        new Radio(
                          value: 0,
                          groupValue: _radioValue,
                          onChanged: _handleRadioValueChange,
                        ),
                        new Text(
                          'Doctor',
                          style: new TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        new Radio(
                          value: 1,
                          groupValue: _radioValue,
                          onChanged: _handleRadioValueChange,
                        ),
                        new Text(
                          'Patient',
                          style: new TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Theme(
                      data: ThemeData(primaryColor: Color(0xff1c1427)),
                      child: TextField(
                        cursorColor: Color(0xff1c1427),
                        // controller: nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText:
                              _radioValue == 0 ? 'Doctor Id' : 'Patient Id',
                        ),
                        // onChanged: (text) {
                        //   setState(() {
                        //     fullName = text;
                        //     //you can access nameController in its scope to get
                        //     // the value of text entered as shown below
                        //     //fullName = nameController.text;
                        //   });
                        // },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
                    child: Theme(
                      data: ThemeData(primaryColor: Color(0xff1c1427)),
                      child: TextField(
                        cursorColor: Color(0xff1c1427),
                        // controller: nameController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                        // onChanged: (text) {
                        //   setState(() {
                        //     fullName = text;
                        //     //you can access nameController in its scope to get
                        //     // the value of text entered as shown below
                        //     //fullName = nameController.text;
                        //   });
                        // },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    width: 200,
                    child: RaisedButton.icon(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        onPressed: () {
                          _radioValue == 1
                              ? Navigator.of(context).push(MaterialPageRoute(
                                  builder: (c) => PatientHomePage()))
                              : null;
                        },
                        icon: Icon(
                          Icons.done,
                          color: Colors.white,
                        ),
                        color: Color(0xff1c1427),
                        label: Text(
                          'Submit',
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
        ),
      ),
    );
  }
}
