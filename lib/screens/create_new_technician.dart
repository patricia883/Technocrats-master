import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/painting.dart';
//import 'package:flutter_projects/screens/home/home.dart';
import 'package:flutter_projects/Shared/constants.dart';
import 'package:flutter_projects/Shared/loading.dart';
import 'package:flutter_projects/screens/admin_dashboard.dart';
import 'package:flutter_projects/services/auth2.dart';
import 'package:toast/toast.dart';

class Create_New_Technician extends StatefulWidget {
  const Create_New_Technician({Key key}) : super(key: key);

  @override
  _Create_New_TechnicianState createState() => _Create_New_TechnicianState();
}

class _Create_New_TechnicianState extends State<Create_New_Technician> {

  String email = '';
  String password = '';
  String fullName = '';
  //String surname = '';
  String phoneNo = '';
  String role = '';
  String assignedRole = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  bool loading = false;
  bool checkedValue = false;
  bool _passwordVisible = false;

  final List<String> roles = ['Technician', 'Driver' , 'Admin'];

  // form values
  String _assignedRole;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen())),
        ),
        title: Text("Create New Employee Profile" , style: TextStyle(fontWeight: FontWeight.bold)) ,
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 20.0,
              ),
              child: Form(
                // TODO : implement key
                key: _formKey,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    // TODO : Implement fields

                    // CheckboxListTile(
                    //   title: Text("Use Default Password ?"),
                    //   value: checkedValue,
                    //   onChanged: (newValue) {
                    //     setState(() {
                    //       checkedValue = newValue!;
                    //     });
                    //   },
                    //   controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                    // ),
                    // SizedBox(
                    //   height: 20.0,
                    // ),
                    SizedBox(
                      width: 500.0,
                      child: TextFormField(
                        decoration: textInputDecoration.copyWith(
                          labelText: 'Full name',
                          prefixIcon: Icon(Icons.person),
                        ),
                        validator: (input) => input.isEmpty ? 'Please enter name in full' : null,
                        onChanged: (input) {
                          setState(() => fullName = input);
                        },
                        onSaved: (input) => fullName  = input,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),

                    // SizedBox(
                    //   width: 500.0,
                    //   child: TextFormField(
                    //     decoration: textInputDecoration.copyWith(
                    //       labelText: 'Surname',
                    //       prefixIcon: Icon(Icons.person),
                    //     ),
                    //     validator: (input) => input.isEmpty ? 'Please enter Surname' : null,
                    //     onChanged: (input) {
                    //       setState(() => surname = input);
                    //     },
                    //     onSaved: (input) => surname = input,
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 20.0,
                    // ),

                    SizedBox(
                      width: 500.0,
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: textInputDecoration.copyWith(
                          labelText: 'Phone Number',
                          prefixIcon: Icon(Icons.phone),
                        ),

                        validator: (String input) {
                          if (input.isEmpty) {
                            return 'Phone number is Required';
                          }
                          if (!RegExp(r"^([0][1-9][0-9]*)$").hasMatch(input)) {
                            return 'Invalid Phone Number';
                          }
                          if(input.length < 10) {
                            return 'Phone number needs to be 10 digits';
                          }
                          return null;
                        },

                        onChanged: (input) {
                          setState(() => phoneNo = input);
                        },

                        onSaved: (input) => phoneNo = input,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      width: 500.0,
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: textInputDecoration.copyWith(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.mail),
                        ),
                        validator: (String input) {
                          if (input.isEmpty) {
                            return 'Please enter an Email';
                          }

                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(input)) {
                            return 'Invalid Email';
                          }

                          return null;
                        },

                        onChanged: (input) {
                          setState(() => email = input);
                        },
                        onSaved: (input) => email = input,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      width: 500.0,
                      child: TextFormField(
                        obscureText: !_passwordVisible,
                        decoration: textInputDecoration.copyWith(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.password),
                          suffixIcon: IconButton(
                            icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                        ),
                        validator: (input) => input.length < 6 ? 'Password needs to be at least 6 characters' : null,
                        onChanged: (input) {
                          setState(() => password = input);
                        },
                        onSaved: (input) => password = input,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      width: 500.0,
                      child: DropdownButtonFormField(
                        value: _assignedRole ?? 'Technician',
                        decoration: textInputDecoration.copyWith(prefixIcon: Icon(Icons.info)),
                        items: roles.map((roles) {
                          return DropdownMenuItem(
                            value: roles,
                            child: Text('$roles'),
                          );
                        }).toList(),
                        onChanged: (val) => setState(() => _assignedRole = val.toString() ),
                        onSaved: (val) => _assignedRole = val.toString(),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      width: 105,
                      height: 50,
                      child: new RaisedButton(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.save),
                            Text(" Save", style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                        color: Colors.orange,
                        textColor: Colors.white,
                          onPressed: () async {
                            if(_formKey.currentState.validate()){
                              setState(() => loading = true);
                              if(_assignedRole == null) {
                                _assignedRole = 'Technician';
                                dynamic result = await _auth.registerUserWithEmailAndPassword(
                                    email, password, fullName, phoneNo, _assignedRole);
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                                Toast.show("New Employee successfully created", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                                if (result == null) {
                                  setState(() {
                                    loading = false;
                                    Toast.show("Error ! Please try again", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                                    //error = 'Please supply a valid email';
                                  });
                                }
                              }else{
                                dynamic result = await _auth.registerUserWithEmailAndPassword(
                                    email, password, fullName, phoneNo, _assignedRole);
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                                Toast.show("New Employee successfully created", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                                if (result == null) {
                                  setState(() {
                                    loading = false;
                                    Toast.show("Error ! Please try again", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                                    //error = 'Please supply a valid email';
                                  });
                                }
                              }
                            }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool defaultPassword = false;

  void _onRememberMeChanged(bool newValue) => setState(() {
    defaultPassword = newValue;

    if (defaultPassword) {
      // TODO: Here goes your functionality that remembers the user.
      password = 'abc123';
    } else {
      // TODO: Forget the user
      //   validator: (input) => input!.length < 6 ? 'Password needs to be at least 6 characters' : null,
      //   onChanged: (input) {
      //   setState(() => password = input);
      //   },
      //   onSaved: (input) => password = input!;,
    }
  });

// Future<void> signIn() async{
//   // TODO : validated fields
//   final formState = _formKey.currentState;
//
//   if(formState!.validate()){
//     // TODO : Sign in to firebase
//     formState.save();
//     setState(() => loading = true);
//
//     try{
//       UserCredential user = await FirebaseAuth.instance.
//       signInWithEmailAndPassword(email: _email, password: _password);
//
//       // TODO : Navigate to home
//       Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
//
//     }catch(e){
//       print(e.toString());
//     }
//
//   }
// }

// Future<void> signUp() async {
//   // TODO : validated fields
//   final formState = _formKey.currentState;
//
//   if (formState!.validate()) {
//     // TODO : Sign in to firebase
//     formState.save();
//     setState(() => loading = true);
//
//     try {
//       UserCredential user = await FirebaseAuth.instance.
//       createUserWithEmailAndPassword(email: _email, password: _password);
//
//       final CollectionReference Users = FirebaseFirestore.instance.collection('Users');
//
//       // TODO : Navigate to home
//       Navigator.push(
//           context, MaterialPageRoute(builder: (context) => Home()));
//     } catch (e) {
//       print(e.toString());
//     }
//   }
// }
}

// sign up