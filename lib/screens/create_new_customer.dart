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

class Create_New_Customer extends StatefulWidget {
  const Create_New_Customer({Key key}) : super(key: key);

  @override
  _Create_New_CustomerState createState() => _Create_New_CustomerState();
}

// ignore: camel_case_types
class _Create_New_CustomerState extends State<Create_New_Customer> {

  String customerBusinessName;
  String description;
  String address;
  String email;
  String password;
  String phoneNo;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  bool loading = false;
  bool checkedValue = false;
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen())),
        ),
        title: Text("Create New Customer Profile" , style: TextStyle(fontWeight: FontWeight.bold)) ,
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

                    SizedBox(
                      width: 500.0,
                      child: TextFormField(
                        decoration: textInputDecoration.copyWith(
                          labelText: 'Customer Business name',
                          prefixIcon: Icon(Icons.person),
                        ),
                        validator: (input) => input.isEmpty ? 'Please enter name in full' : null,
                        onChanged: (input) {
                          setState(() => customerBusinessName = input);
                        },
                        onSaved: (input) => customerBusinessName  = input,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),

                    SizedBox(
                      width: 500.0,
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        decoration: textInputDecoration.copyWith(
                          labelText: 'Description',
                          prefixIcon: Icon(Icons.description),
                        ),
                        validator: (input) => input.isEmpty ? 'Please provide a description of the Customers business' : null,
                        onChanged: (input) {
                          setState(() => description = input);
                        },
                        onSaved: (input) => description = input,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),

                    SizedBox(
                      width: 500.0,
                      child: TextFormField(
                        keyboardType: TextInputType.streetAddress,
                        decoration: textInputDecoration.copyWith(
                          labelText: 'Address',
                          prefixIcon: Icon(Icons.location_on),
                        ),
                        validator: (input) => input.isEmpty ? 'Please enter Address' : null,
                        onChanged: (input) {
                          setState(() => address = input);
                        },
                        onSaved: (input) => address  = input,
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
                            dynamic result = await _auth.registerCustomerWithEmailAndPassword(
                                email, password, customerBusinessName, description, phoneNo, address);
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                            Toast.show("New Customer successfully created", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                Toast.show("Error ! Please try again", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                                //error = 'Please supply a valid email';
                              });
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
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_projects/Shared/constants.dart';
// import 'package:flutter_projects/Shared/loading.dart';
// import 'package:flutter_projects/screens/admin_dashboard.dart';
// //import 'package:flutter_projects/screens/home/home.dart';
// import 'package:flutter_projects/services/auth2.dart';
// import 'package:toast/toast.dart';
//
// class Create_New_Customer extends StatefulWidget {
//   const Create_New_Customer({Key key}) : super(key: key);
//
//   @override
//   _Create_New_CustomerState createState() => _Create_New_CustomerState();
// }
//
// // ignore: camel_case_types
// class _Create_New_CustomerState extends State<Create_New_Customer> {
//
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final AuthService _auth = AuthService();
//
//   bool loading = false;
//   bool checkedValue = false;
//
//   String customerName = '';
//   String description = '';
//   String address = '';
//   String email = '';
//   String phoneNo = '';
//
//   TextEditingController customerNameController = new TextEditingController();
//   TextEditingController descriptionController = new TextEditingController();
//   TextEditingController addressController = new TextEditingController();
//   TextEditingController emailController = new TextEditingController();
//   TextEditingController phoneNoController = new TextEditingController();
//
//   Map<String,dynamic> customerData;
//   CollectionReference customers = FirebaseFirestore.instance.collection('Customers');
//   CollectionReference C = FirebaseFirestore.instance.collection('Customers');
//
//   Future createCustomer() async {
//
//     try{
//
//       customerData = {
//         'Customer name': customerNameController.text,
//         'Description': descriptionController.text,
//         'Address': addressController.text,
//         'Email': emailController.text,
//         'Phone number': phoneNoController.text,
//       };
//
//       return customers.add(customerData).whenComplete(() => print('Added to Database Successfully'));
//
//     } catch(e){
//       print(e.toString());
//     }
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return loading ? Loading() : Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen())),
//         ),
//         title: Text("Create New Customer Profile", style: TextStyle(fontWeight: FontWeight.bold)),
//         centerTitle: true,
//         backgroundColor: Colors.orange,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 15.0),
//         child: ListView(
//           children: <Widget>[
//             Container(
//               alignment: Alignment.center,
//               padding: EdgeInsets.symmetric(
//                 vertical: 20.0,
//                 horizontal: 20.0,
//               ),
//               child: Form(
//                 // TODO : implement key
//                 key: _formKey,
//                 child: Column(
//                   children: <Widget>[
//                     SizedBox(
//                       height: 20.0,
//                     ),
//                     // TODO : Implement fields
//                     SizedBox(
//                       width: 500.0,
//                       child: TextFormField(
//                         controller: customerNameController,
//                         decoration: textInputDecoration.copyWith(
//                           labelText: 'Customer Business Name',
//                           prefixIcon: Icon(Icons.person),
//                         ),
//                         validator: (input) => input.isEmpty ? 'Please enter a Name' : null,
//                         onChanged: (input) {
//                           setState(() => customerName = input);
//                         },
//                         onSaved: (input) => customerName = input,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20.0,
//                     ),
//                     SizedBox(
//                       width: 500.0,
//                       child: TextFormField(
//                         keyboardType: TextInputType.multiline,
//                         controller: descriptionController,
//                         decoration: textInputDecoration.copyWith(
//                           labelText: 'Description',
//                           prefixIcon: Icon(Icons.description),
//                         ),
//                         validator: (input) => input.isEmpty ? 'Please provide a description of the Customers business' : null,
//                         onChanged: (input) {
//                           setState(() => description = input);
//                         },
//                         onSaved: (input) => description = input,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20.0,
//                     ),
//                     SizedBox(
//                       width: 500.0,
//                       child: TextFormField(
//                         controller: addressController,
//                         keyboardType: TextInputType.streetAddress,
//                         decoration: textInputDecoration.copyWith(
//                           labelText: 'Address',
//                           prefixIcon: Icon(Icons.location_on),
//                         ),
//                         validator: (input) => input.isEmpty ? 'Please enter Address' : null,
//                         onChanged: (input) {
//                           setState(() => address = input);
//                         },
//                         onSaved: (input) => address  = input,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20.0,
//                     ),
//                     SizedBox(
//                       width: 500.0,
//                       child: TextFormField(
//                         controller: emailController,
//                         keyboardType: TextInputType.emailAddress,
//                         decoration: textInputDecoration.copyWith(
//                           labelText: 'Email',
//                           prefixIcon: Icon(Icons.email),
//                         ),
//                         validator: (String input) {
//                           if (input.isEmpty) {
//                             return 'Please enter an Email';
//                           }
//
//                           if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
//                               .hasMatch(input)) {
//                             return 'Invalid Email';
//                           }
//
//                           return null;
//                         },                      onChanged: (input) {
//                           setState(() => email = input);
//                         },
//                         onSaved: (input) => email = input,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20.0,
//                     ),
//                     SizedBox(
//                       width: 500.0,
//                       child: TextFormField(
//                         controller: phoneNoController,
//                         keyboardType: TextInputType.phone,
//                         decoration: textInputDecoration.copyWith(
//                           labelText: 'Phone Number',
//                           prefixIcon: Icon(Icons.phone),
//                         ),
//                         validator: (String input) {
//                           if (input.isEmpty) {
//                             return 'Please enter Phone Number';
//                           }
//                           if (!RegExp(r"^([0][1-9][0-9]*)$").hasMatch(input)) {
//                             return 'Invalid Phone Number';
//                           }
//                           if(input.length < 10) {
//                             return 'Invalid Phone Number';
//                           }
//                           return null;
//                         },
//
//                         onChanged: (input) {
//                           setState(() => phoneNo = input);
//                         },
//                         onSaved: (input) => phoneNo = input,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20.0,
//                     ),
//                     SizedBox(
//                       width: 105,
//                       height: 50,
//                       child: new RaisedButton(
//                         child: Row(
//                           children: <Widget>[
//                             Icon(Icons.save),
//                             Text(" Save", style: TextStyle(fontWeight: FontWeight.bold)),
//                           ],
//                         ),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(16),
//                           ),
//                         ),
//                         color: Colors.orange,
//                         textColor: Colors.white,
//                         onPressed: () async {
//
//                           if(_formKey.currentState.validate()){
//
//                             setState(() => loading = true);
//                             dynamic result = await createCustomer();
//                             Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
//                             Toast.show("New customer successfully created", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
//
//                             if(result == null){
//                               setState(() {
//                                 loading = false;
//                                 Toast.show("Error ! Please try again", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
//                                 //error = 'Please supply a valid email';
//                               });
//                             }
//                           }
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }