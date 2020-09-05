import 'package:ecommerce/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
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
      await Firebase.initializeApp();
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Login In'),
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: FlatButton(
                onPressed: () {
                  handleSignIn();
                },
                child: Text('Sign In/Sign Up')),
          ),
          Visibility(
              visible: loading ?? true,
              child: Container(
                  color: Colors.white.withOpacity(0.7),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                  )))
        ],
      ),
    );
  }
}
