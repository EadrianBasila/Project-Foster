import 'package:flutter/material.dart';

class Check extends StatefulWidget {
  @override
  _CheckState createState() => _CheckState();
}

class _CheckState extends State<Check> {
  showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: Text(
        "Understood",
        style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.indigoAccent),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(
        "Reminder",
        style: TextStyle(
            fontSize: 50, fontWeight: FontWeight.bold, color: Colors.orange),
      ),
      content: Text(
        "Foster's Team will contact you thru specified channels: via email and phone call or text message, once your application has been approved.\n\nThe text above will also change from pending to 'Accepted' or 'Denied.'",
        style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black),
        textAlign: TextAlign.justify,
      ),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
              child: Form(
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
                    color: Colors.orange,
                  ),
                  child: Text(
                    "APPLICATION STATUS",
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  height: 300,
                  child: Image(
                      image: AssetImage("images/check.jpg"),
                      fit: BoxFit.contain),
                ),
                SizedBox(height: 10.0),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.yellow[600],
                          blurRadius: 20.0,
                          spreadRadius: 10.0,
                        ),
                      ]),
                  child: Text(
                    'PENDING',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 50.0),
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      showAlertDialog(context);
                    },
                    icon: Icon(
                      Icons.info_outline,
                      color: Colors.white,
                      size: 24.0,
                    ),
                    label: Text(
                      'CHECK STATUS',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.fromLTRB(25, 25, 25, 25),
                        primary: Colors.indigoAccent,
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        )),
                  ),
                ),
                SizedBox(height: 80.0),
                Text(
                  'Feel free to contact us at our:',
                  style: TextStyle(
                      color: Colors.orange,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '                        Phone Number:  0912-345-6789',
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '                        Telephone:        143-FOSTER',
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '                        Email: fosterHelp@gmail.com',
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                ),
                SizedBox(height: 100.0),
                Text(
                  'Project Foster. All Rights Reserved (2021)',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ],
            ),
          )),
        ));
  }
}
