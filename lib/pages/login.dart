import 'package:ecommerce/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  SharedPreferences preferences;
  bool loading = false;
  bool isLoggedIn = false;
  @override
  void initState() {
    super.initState();
    isSignedIn();
  }

  void isSignedIn() async {
    setState(() {
      loading = true;
    });
    preferences = await SharedPreferences.getInstance();
    isLoggedIn = await googleSignIn.isSignedIn();
    if (isLoggedIn) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
    setState(() {
      loading = false;
    });
  }

  Future handleSignIn() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      loading = true;
    });
    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final UserCredential authResult =
        await firebaseAuth.signInWithCredential(credential);
    final User user = authResult.user;
    if (user != null) {
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection("users")
          .where("id", isEqualTo: user.uid)
          .get();
      final List<DocumentSnapshot> docs = result.docs;
      if (docs.length == 0) {
        //insert to the user to our collection
        FirebaseFirestore.instance.collection("users").doc(user.uid).set({
          "id": user.uid,
          "username": user.displayName,
          "profilePicture": user.photoURL,
        });
        await preferences.setString("id", user.uid);
        await preferences.setString("username", user.displayName);
        await preferences.setString("photoUrl", user.photoURL);
      } else {
        await preferences.setString("id", docs[0].data()['id']);
        await preferences.setString("username", docs[0].data()['username']);
        await preferences.setString("photoUrl", docs[0].data()['photoUrl']);
      }
      Fluttertoast.showToast(msg: "Login was successfull");
      setState(() {
        loading = false;
      });
    } else {
      Fluttertoast.showToast(msg: "Login failed");
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            "assets/images/login.jpg",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            color: Colors.black.withOpacity(0.5),
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Container(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  "assets/images/logo.png",
                  width: 80.0,
                  height: 80.0,
                )),
          ),
//=============================FORM=================================//
          Padding(
            padding: const EdgeInsets.only(top: 300.0),
            child: Center(
                child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  //=============================EMAIL=================================//
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white.withOpacity(0.8),
                      elevation: 0.0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Email",
                              icon: Icon(Icons.alternate_email),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailTextController,
                            validator: (value) {
                              Pattern pattern =
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                              RegExp regex = new RegExp(pattern);
                              if (!regex.hasMatch(value))
                                return 'Enter Valid Email';
                              else
                                return null;
                            }),
                      ),
                    ),
                  ),
                  //=============================PASSWORD=================================//
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white.withOpacity(0.8),
                      elevation: 0.0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Password",
                              icon: Icon(Icons.lock_outline),
                            ),
                            controller: _passwordTextController,
                            validator: (value) {
                              if (value.length < 8)
                                return 'The password field cannot be empty';
                              else if (value.isEmpty)
                                return 'The password has to be atleast 8 characters long';
                              else
                                return null;
                            }),
                      ),
                    ),
                  ),
                  //=============================Login Button=================================//
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.blue.withOpacity(0.9),
                        elevation: 0.0,
                        child: MaterialButton(
                            onPressed: () {},
                            minWidth: MediaQuery.of(context).size.width,
                            child: Text(
                              "Login",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ))),
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                  Text(
                    "Other Login Option",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  //=============================Google Login Button=================================//
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.red.withOpacity(0.9),
                        elevation: 0.0,
                        child: MaterialButton(
                            onPressed: () {},
                            minWidth: MediaQuery.of(context).size.width,
                            child: Text(
                              "Goole SignIn",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ))),
                  ),
                ],
              ),
            )),
          ),
          Visibility(
              visible: loading ?? true,
              child: Center(
                child: Container(
                    alignment: Alignment.center,
                    color: Colors.white.withOpacity(0.7),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    )),
              ))
        ],
      ),
      bottomNavigationBar: Container(
          child: Padding(
        padding: const EdgeInsets.only(
            left: 12.0, right: 12.0, top: 8.0, bottom: 8.0),
        child: FlatButton(
            color: Colors.red.shade900,
            onPressed: () {
              handleSignIn();
            },
            child: Text(
              "Sign In / Sign Up with Google",
              style: TextStyle(color: Colors.white),
            )),
      )),
    );
  }
}
//=============================VALIDATION=================================//
