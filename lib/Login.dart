import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foster_app/SignUp.dart';
//import 'package:foster_app/HomePage.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email, _password;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        print(user);

        Navigator.pushReplacementNamed(context, "/");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
  }

  login() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {
        await _auth.signInWithEmailAndPassword(
            email: _email, password: _password);
      } catch (e) {
        showError(e.message);
        print(e);
      }
    }
  }

  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Sign In Error.'),
              content: Text(errormessage),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'))
              ]);
        });
  }

  //navigateToSignUp() async {
  //  Navigator.pushReplacementNamed(context, "SignUp");
  //}

  navigateToSignUp() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          child: Column(
        children: <Widget>[
          Container(
            height: 400,
            child: Image(
              image: AssetImage("images/login.jpg"),
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 20.0),
          Container(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: TextFormField(
                      validator: (input) {
                        if (input.isEmpty) {
                          return 'Enter your Email.';
                        }
                        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(input)) {
          return 'Please enter a valid email adress';
        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Email',
                          filled: true,
                          hoverColor: Colors.orange[50],
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25)),
                          prefixIcon: Icon(Icons.email)),
                      onSaved: (input) => _email = input,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: TextFormField(
                      validator: (input) {
                        if (input.length < 6) {
                          return 'Provide a Minimum of 6 Character Password.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Password',
                          filled: true,
                          hoverColor: Colors.orange[50],
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25)),
                          prefixIcon: Icon(Icons.lock)),
                      obscureText: true, 
                      onSaved: (input) => _password = input,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: login,
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                        primary: Colors.orange[700],
                        onPrimary: Colors.white,
                        //shadowColor: Colors.grey,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        )),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Container(
              alignment: FractionalOffset.center,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Doesn't have an account yet? ",
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                  GestureDetector(
                    child: Text("Create an account here.",
                        style: TextStyle(
                            color: Colors.indigoAccent, fontSize: 15)),
                    onTap: navigateToSignUp,
                  )
                ],
              )),
          SizedBox(height: 150.0),  
             Text(
              '[Secure Login] Powered by: Firebase Authentication',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ), 
            Text(
              'Project Foster. All Rights Reserved (2021)',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),     
        ],
      )),
    ));
  }
}
