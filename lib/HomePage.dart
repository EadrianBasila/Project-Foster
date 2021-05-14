import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foster_app/logic/get_books.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:foster_app/models/book.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;

  int _index = 0;
  List<Book> books = GetBooks.books;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.of(context).pushReplacementNamed("start");
      }
    });
  }

  getUser() async {
    User firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isloggedin = true;
      });
    }
  }

  signOut() async {
    _auth.signOut();
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
    this.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
              child: SafeArea(
            child: !isloggedin
                ? CircularProgressIndicator(
                    backgroundColor: Colors.orange,
                    valueColor:
                        new AlwaysStoppedAnimation<Color>(Colors.indigoAccent),
                    strokeWidth: 10,
                  )
                :  
                Column(
                    children: <Widget>[
                      SizedBox(height: 10.0),
                       Row( 
                      mainAxisAlignment: MainAxisAlignment.start,
                       children: <Widget>[
                        Container(
                            height: 60,
                            width: 60,
                            child: Image(image: AssetImage("images/logo-icon.png"),
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
                          SizedBox(width: 125),
                          Container(
                            alignment: Alignment.topRight,
                            child: ElevatedButton.icon(
                              onPressed: signOut,
                              icon: Icon(Icons.exit_to_app,
                                color: Colors.white,
                                size: 24.0,),
                              label: Text(
                                'SIGN OUT',
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
                         ]
                       ),
                      SizedBox(height: 10),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          " Hello ${user.displayName}!",
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w500,
                              color: Colors.indigoAccent),
                          textAlign: TextAlign.left,
                        ),
                        // child: Text(
                        //   "Hello ${user.displayName} your are logged in as ${user.email}",
                        //   style: TextStyle(
                        //       fontSize: 20,
                        //       fontWeight: FontWeight.bold,
                        //       color: Colors.blue),
                        // ),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        height: 400,
                        decoration: BoxDecoration(color: Colors.orange,
                            boxShadow: [BoxShadow(
                            color: Colors.grey[300],
                            blurRadius: 15.0,
                            spreadRadius: 10.0,
                          ),]),                      
                        child: PageView.builder(
                          controller: PageController(viewportFraction: 0.6),
                          scrollDirection: Axis.horizontal,
                          itemCount: books.length,
                          onPageChanged: (int index) {
                            //print(_index.toString());
                            setState(() {
                              _index = index;
                            });
                            //print(_index.toString());
                          },
                          itemBuilder: (BuildContext context, int index) {
                            Book book = books[index];
                            return Transform.scale(
                              scale: _index == index ? 1 : 0.9,
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image(
                                            height: 310,
                                            width: 380,
                                            image: AssetImage(book.image),
                                            fit: BoxFit.cover),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text(
                                            '${book.name}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: _index == index ? 30 : 20,
                                              fontWeight: _index == index
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                            ),
                                          )),
                                      Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text(
                                            'Age: ${book.age}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.indigoAccent,
                                              fontSize: _index == index ? 20 : 15,
                                              fontWeight: _index == index
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                            ),
                                          )),
                                    ],
                                  ))),
                            );
                          },
                        ),
                      ),

                      SizedBox(height: 10.0),
                      Container(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            child: Text("View their stories..",
                                style: TextStyle(
                                    color: Colors.indigo[300], fontSize: 25)),
                            onTap: () {},
                          )),
                      SizedBox(height: 40.0),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'CHECK YOUR APPLICATION',
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 20),
                            primary: Colors.orange[700],
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            )),
                      ),
                      SizedBox(height: 10.0),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'SEND YOUR APPLICATION',
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 20),
                            primary: Colors.orange[700],
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            )),
                      ),
                      SizedBox(height: 80.0),
                      Container(
                        width: 380,
                        child: Center(
                          child: Text(
                            'This project aims to help the elderly who are struggling with financial and emotional needs. From the application name itself, people that uses the app will be able to foster someone, provide them with basic needs. ',
                            style: TextStyle(color: Colors.grey, fontSize: 10,),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ), 
                      SizedBox(height: 5.0),  
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
