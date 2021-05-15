import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
//import 'package:image_picker_web_redux/image_picker_web_redux.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Submit extends StatefulWidget {
  @override
  _SubmitState createState() => _SubmitState();
}

class _SubmitState extends State<Submit> {
  User user;
  bool isloggedin = false;

  String _image;
  String _userName;
  String _userAge;
  String _userAddress;
  String _userNumber;
  String _userEmail;
  String _userDescription;
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  sendToMail(String _emailBody) async {
    String username = 'zippsgame@gmail.com';
    String password = 'qedqerpxebokpgxh';

    // ignore: deprecated_member_use
    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'Foster Application Mailer')
      ..recipients.add('basilaeadrian@gmail.com.com')
      ..subject = 'Foster Application - [Test] :: 😀 :: ${DateTime.now()}'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = "<h1>$_emailBody</h1>\n<p>Hey! Here's some HTML content</p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
    // DONE
  }

  Widget _buildImage() {
    return Center(
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 80.0,
            backgroundImage: _imageFile == null
                ? AssetImage('images/profile.png')
                : FileImage(File(_imageFile.path)),
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: ((builder) => _buildSheet()),
                );
              },
              child: Icon(Icons.camera_alt_rounded,
                  color: Colors.orange, size: 28.0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.indigoAccent),
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          SizedBox(height: 10),
          Text("Choose Profile Image",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                icon: Icon(Icons.image_rounded, color: Colors.white),
                onPressed: () {
                  if (kIsWeb) {
                    takePhotoWeb(ImageSource.gallery);
                  } else {
                    takePhoto(ImageSource.gallery);
                  }
                },
                label: Text('Gallery',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.white)),
              ),
            ],
          )
        ],
      ),
    );
  }

  void takePhotoWeb(ImageSource source) async {
    final pickedFile = await ImagePicker().getImage(source: source);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  Widget _buildUsername() {
    return Container(
      padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
      child: TextFormField(
        validator: (String value) {
          if (value.isEmpty) {
            return 'Enter Name';
          }
          return null;
        },
        decoration: InputDecoration(
            labelText: 'Name',
            filled: true,
            hoverColor: Colors.orange[50],
            isDense: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
            prefixIcon: Icon(Icons.face_unlock_rounded)),
        onSaved: (String value) {
          _userName = value;
        },
      ),
    );
  }

  Widget _buildAge() {
    return Container(
      padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
      child: TextFormField(
        validator: (String value) {
          if (value.isEmpty) {
            return 'Enter Age';
          }
          return null;
        },
        decoration: InputDecoration(
            labelText: 'Age',
            filled: true,
            hoverColor: Colors.orange[50],
            isDense: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
            prefixIcon: Icon(Icons.calendar_today)),
        onSaved: (String value) {
          _userAge = value;
        },
      ),
    );
  }

  Widget _buildAddress() {
    return Container(
      padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
      child: TextFormField(
        validator: (String value) {
          if (value.isEmpty) {
            return 'Enter Home Address';
          }
          return null;
        },
        decoration: InputDecoration(
            labelText: 'Home Address',
            filled: true,
            hoverColor: Colors.orange[50],
            isDense: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
            prefixIcon: Icon(Icons.home_rounded)),
        onSaved: (String value) {
          _userAddress = value;
        },
      ),
    );
  }

  Widget _buildNumber() {
    return Container(
      padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
      child: TextFormField(
        validator: (String value) {
          if (value.isEmpty) {
            return 'Enter a valid Phone Number';
          }
          return null;
        },
        decoration: InputDecoration(
            labelText: 'Phone Number',
            filled: true,
            hoverColor: Colors.orange[50],
            isDense: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
            prefixIcon: Icon(Icons.phone)),
        onSaved: (String value) {
          _userNumber = value;
        },
      ),
    );
  }

  Widget _buildEmail() {
    return Container(
      padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
      child: TextFormField(
        validator: (String value) {
          if (value.isEmpty) {
            return 'Enter Email';
          }
          if (!RegExp(
                  r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
              .hasMatch(value)) {
            return 'Please enter a valid email adress';
          }
          return null;
        },
        decoration: InputDecoration(
            labelText: 'Email',
            filled: true,
            hoverColor: Colors.orange[50],
            isDense: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
            prefixIcon: Icon(Icons.email)),
        onSaved: (String value) {
          _userEmail = value;
        },
      ),
    );
  }

  Widget _buildDescription() {
    return Container(
      padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Enter your profile description';
          }
          return null;
        },
        decoration: InputDecoration(
            labelText: 'Profile Description',
            filled: true,
            hoverColor: Colors.orange[50],
            isDense: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
            prefixIcon: Icon(Icons.favorite)),
        onSaved: (String value) {
          _userDescription = value;
        },
         maxLines: 5,
         minLines: 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
              child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 10.0),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 60,
                        width: 60,
                        child: Image(
                            image: AssetImage("images/logo-icon.png"),
                            fit: BoxFit.contain),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "FOSTER",
                          style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(width: 140),
                      Container(
                        alignment: Alignment.topRight,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            _formKey.currentState.save();
                            Navigator.of(context).pushReplacementNamed("/");
                          },
                          icon: Icon(
                            Icons.exit_to_app,
                            color: Colors.white,
                            size: 24.0,
                          ),
                          label: Text(
                            'HOME',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.fromLTRB(19, 19, 19, 19),
                              primary: Colors.redAccent,
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              )),
                        ),
                      ),
                    ]),
                SizedBox(height: 10),
                Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.indigoAccent,
                  ),
                  child: Text(
                    "APPLICATION PAGE",
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(height: 10.0),
                _buildImage(),
                SizedBox(height: 10.0),
                _buildUsername(),
                SizedBox(height: 10.0),
                _buildAge(),
                SizedBox(height: 10.0),
                _buildAddress(),
                SizedBox(height: 10.0),
                _buildNumber(),
                SizedBox(height: 10.0),
                _buildEmail(),
                SizedBox(height: 10.0),
                _buildDescription(),
                SizedBox(height: 50.0),
                Container(
                  width: 380,
                  child: Center(
                    child: Text(
                      'By submitting your application, you agree to Fosters Terms and Conditions.',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 5.0),
                ElevatedButton(
                  onPressed: () {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }

                    _formKey.currentState.save();
                    String _emailBody =
                        ' Applicant Information: \n Applicant Image: {$_image} \n Applicant Name: {$_userName} \n Applicant Age: {$_userAge} \n Applicant Address: {$_userAddress} \n Applicant Number: {$_userNumber} \n Applicant Email: {$_userEmail} \n Applicant Description: {$_userDescription} ';
                    print(_emailBody);

                    // _launchURL('basilaeadrian@gmail.com',
                    //     'Foster Application - [Test]', '''
                    // [Applicant Information]
                    //     Applicant Name: {$_userName}
                    //     Applicant Age: {$_userAge}
                    //     Applicant Address: {$_userAddress}
                    //     Applicant Number: {$_userNumber}
                    //     Applicant Email: {$_userEmail}
                    // [---] ''');

                    //sendToMail(_emailBody);

                    Navigator.of(context).pushReplacementNamed("/");
                  },
                  child: Text(
                    'SEND YOUR APPLICATION',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                      primary: Colors.orange[700],
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      )),
                ),
              ],
            ),
          )),
        ));
  }
}
