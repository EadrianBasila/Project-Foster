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
        body: Container(
            child: SafeArea(
          child: !isloggedin
              ? CircularProgressIndicator(
                  backgroundColor: Colors.orange,
                  valueColor:
                      new AlwaysStoppedAnimation<Color>(Colors.indigoAccent),
                  strokeWidth: 5,
                )
              : Column(
                  children: <Widget>[
                    SizedBox(height: 10.0),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        " FOSTER",
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        " Hello ${user.displayName}!",
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.w300,
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
                    SizedBox(height: 20.0),
                    Container(
                      height: 400,
                      color: Colors.orange,
                      child: PageView.builder(
                        controller: PageController(viewportFraction: 0.6),
                        scrollDirection: Axis.horizontal,
                        itemCount: books.length,
                        onPageChanged: (int index) {
                          print(_index.toString());
                          setState(() {
                            _index = index;
                          });
                          print(_index.toString());
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

                    // Container(
                    //   height: 400,
                    //   child: Image(
                    //     image: AssetImage('images/homepage.jpg'),
                    //     fit: BoxFit.contain,
                    //   ),
                    // ),
                    // SizedBox(height: 40.0),
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
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                        onPressed: signOut,
                        child: Text(
                          'SIGN OUT',
                          style: TextStyle(
                            fontSize: 35.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.fromLTRB(80, 10, 80, 10),
                            primary: Colors.redAccent,
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            )),
                      ),
                    ),
                  ],
                ),
        )));
  }
}
