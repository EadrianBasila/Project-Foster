import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email, _password, _name;

  checkAuthentication() async {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        Navigator.pushReplacementNamed(context, "/");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentication();
  }

  signUp() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {
        UserCredential user = await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
        if (user != null) {
          await _auth.currentUser.updateProfile(displayName: _name);
        }
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
            title: Text('ERROR'),
            content: Text(errormessage),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
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
              image: AssetImage("images/signup.jpg"),
              fit: BoxFit.contain,
            ),
          ),
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
                          return 'Enter Name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Name',
                          filled: true,
                          hoverColor: Colors.orange[50],
                          isDense: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25)),
                          prefixIcon: Icon(Icons.person)),
                      onSaved: (input) => _name = input,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: TextFormField(
                      validator: (input) {
                        if (input.isEmpty) {
                          return 'Enter Email';
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
                          isDense: true,
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
                          return 'Provide Minimum 6 Character';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Password',
                          filled: true,
                          hoverColor: Colors.orange[50],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          prefixIcon: Icon(Icons.lock)),
                      obscureText: true,
                      onSaved: (input) => _password = input,
                    ),
                  ),
                  SizedBox(height: 50.0),
                  
                   SizedBox(height: 5.0),
                  ElevatedButton(
                    onPressed: signUp,
                    child: Text(
                      'SIGNUP',
                      style: TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                        primary: Colors.orange[700],
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        )),
                  ),
                  SizedBox(height: 5.0),   Text(
                    'By signing up, You agree to Fosters Terms and Conditions.',
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),SizedBox(height: 5.0),
                 Container(
                    alignment: FractionalOffset.center,
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Already have an account? ",
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                        GestureDetector(
                          child: Text("Sign in here.",
                              style: TextStyle(
                                  color: Colors.indigoAccent, fontSize: 13)),
                          onTap: (){
                            _formKey.currentState.save();
                            Navigator.of(context).pushReplacementNamed("Login");
                          },
                        )
                      ],
                    )),
                  
                
                ],
              ),
            ),
          )
        ],
      )),
    ));
  }
}
