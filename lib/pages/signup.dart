import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  //String gender;
  bool loading = false;
  bool hidePass = true;
  bool confHidePass = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Image.asset(
          "assets/images/login.jpg",
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
        ),
        Container(
          color: Colors.black.withOpacity(0.5),
          width: double.infinity,
          height: double.infinity,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 100.0),
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
          padding: const EdgeInsets.only(top: 200.0),
          child: Center(
              child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                //=============================NAME=================================//
                Padding(
                  padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white.withOpacity(0.8),
                    elevation: 0.0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Full Name",
                            icon: Icon(Icons.person_outline),
                            border: InputBorder.none,
                          ),
                          controller: _nameTextController,
                          validator: (value) {
                            if (value.isEmpty)
                              return 'The name field cannot be empty';
                            else if (value.length < 5)
                              return 'The name has to be atleast 5 characters long';
                            else
                              return null;
                          }),
                    ),
                  ),
                ),
                //=============================EMAIL=================================//
                Padding(
                  padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
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
                            border: InputBorder.none,
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
                  padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white.withOpacity(0.8),
                    elevation: 0.0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: ListTile(
                        title: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Password",
                              icon: Icon(Icons.lock_outline),
                              border: InputBorder.none,
                            ),
                            controller: _passwordTextController,
                            obscureText: confHidePass,
                            validator: (value) {
                              if (value.isEmpty)
                                return 'The password field cannot be empty';
                              else if (value.length < 8)
                                return 'The password has to be atleast 8 characters long';
                              else if (_passwordTextController.text != value)
                                return 'the password do not match';
                              else
                                return null;
                            }),
                        trailing: IconButton(
                            icon: Icon(Icons.remove_red_eye),
                            onPressed: () {
                              setState(() {
                                confHidePass = confHidePass ? false : true;
                              });
                            }),
                      ),
                    ),
                  ),
                ),
                //=============================CONFIRM PASSWORD=================================//
                Padding(
                  padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white.withOpacity(0.8),
                    elevation: 0.0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: ListTile(
                        title: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Confirm Password",
                              icon: Icon(Icons.lock_outline),
                              border: InputBorder.none,
                            ),
                            controller: _confirmPasswordController,
                            obscureText: hidePass,
                            validator: (value) {
                              if (value.isEmpty)
                                return 'The password field cannot be empty';
                              else if (value.length < 8)
                                return 'The password has to be atleast 8 characters long';
                              else
                                return null;
                            }),
                        trailing: IconButton(
                            icon: Icon(Icons.remove_red_eye),
                            onPressed: () {
                              setState(() {
                                hidePass = hidePass ? false : true;
                              });
                            }),
                      ),
                    ),
                  ),
                ),
                //=============================SignUp Button=================================//
                Padding(
                  padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                  child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.blue.withOpacity(0.9),
                      elevation: 0.0,
                      child: MaterialButton(
                          onPressed: () {
                            validateForm();
                          },
                          minWidth: MediaQuery.of(context).size.width,
                          child: Text(
                            "Sign Up",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ))),
                ),
                //=============================Divider=================================//
                Divider(
                  color: Colors.white,
                ),
                //=============================Goto Login=================================//
                Padding(
                  padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "LogIn",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                  ),
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
    ));
  }

  //=====================CUSTOM METHODS======================== /
  void validateForm() {
    FormState formState = _formKey.currentState;
    if (formState.validate()) {}
  }
}
