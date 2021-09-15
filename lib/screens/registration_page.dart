// import 'package:banking_app/screens/home.dart';
// import 'package:banking_app/screens/login.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// //import 'package:form_field_validator/form_field_validator.dart';
// //import 'package:http/http.dart' as http;\
// //import 'package:flutter_form_field_validator/flutter_form_field_validator.dart';

// class RegisterScreen extends StatefulWidget {
//   @override
//   _RegisterScreenState createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   String _firstName;
//   String _lastName;
//   String _userName;
//   String _idNumber;
//   String _phoneNumber;
//   String _cellno;
//   String _email;
//   String _password;
//   String _confirmpass;

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   Widget _buildfirstName() {
//     return TextFormField(
//       decoration: InputDecoration(labelText: 'Name'),
//       // validator: MultiValidator([
//       //   RequiredValidator(errorText: "Required"),
//       //   MinLengthValidator(1,
//       //       errorText: "First Name should be at least 2 letters long"),
//       //   PatternValidator(
//       //       r"^(?<firstchar>(?=[A-Za-z]))((?<alphachars>[A-Za-z])|(?<specialchars>[A-Za-z]['-](?=[A-Za-z]))|(?<spaces> (?=[A-Za-z])))*$",
//       //       errorText: 'Please enter a valid First Name')
//       // ]),
//       onSaved: (String value) {
//         _firstName = value;
//       },
//     );
//   }

//   Widget _buildlastName() {
//     return TextFormField(
//       decoration: InputDecoration(labelText: 'Last Name'),
//       // validator: MultiValidator([
//       //   RequiredValidator(errorText: "Required"),
//       //   MinLengthValidator(1,
//       //       errorText: "Last Name should be at least 2 letters long"),
//       //   PatternValidator(
//       //       r"^(?<firstchar>(?=[A-Za-z]))((?<alphachars>[A-Za-z])|(?<specialchars>[A-Za-z]['-](?=[A-Za-z]))|(?<spaces> (?=[A-Za-z])))*$",
//       //       errorText: 'Please enter a valid Last Name')
//       // ]),
//       onSaved: (String value) {
//         _lastName = value;
//       },
//     );
//   }

//   Widget _builduserName() {
//     return TextFormField(
//       decoration: InputDecoration(labelText: 'Username'),
//       // validator: MultiValidator([
//       //   RequiredValidator(errorText: "Required"),
//       //   MinLengthValidator(1,
//       //       errorText: "Username should be at least 2 letters long"),
//       // ]),
//       onSaved: (String value) {
//         _userName = value;
//       },
//     );
//   }

//   Widget _buildidNumber() {
//     return TextFormField(
//       decoration: InputDecoration(labelText: 'ID Number'),
//       // validator: MultiValidator([
//       //   RequiredValidator(errorText: "Required"),
//       //   PatternValidator(r"^(0|[1-9][0-9]*)$",
//       //       errorText: "ID Number Must be Numerics only"),
//       //   MinLengthValidator(13, errorText: "idNumber should be 13 numbers long"),
//       //   MaxLengthValidator(13, errorText: "idNumber should be 13 numbers long"),
//       // ]),
//       onSaved: (String value) {
//         _idNumber = value;
//       },
//     );
//   }

//   Widget _buildphoneNumber() {
//     return TextFormField(
//       decoration: InputDecoration(labelText: 'Phone Number'),
//       // validator: MultiValidator([
//       //   RequiredValidator(errorText: "Required"),
//       //   PatternValidator(r"^(0|[1-9][0-9]*)$",
//       //       errorText: "Phone Number Must be Numerics only"),
//       //   MinLengthValidator(9,
//       //       errorText: "Phone number should be 9 numbers long"),
//       //   MaxLengthValidator(9,
//       //       errorText: "Phone number should be 9 numbers long"),
//       // ]),
//       onSaved: (String value) {
//         _phoneNumber = value;
//       },
//     );
//   }

//   Widget _buildcellNumber() {
//     return TextFormField(
//       decoration: InputDecoration(labelText: 'Cellphone Number'),
//       // validator: MultiValidator([
//       //   RequiredValidator(errorText: "Required"),
//       //   PatternValidator(r"^(0|[1-9][0-9]*)$",
//       //       errorText: "Cellphone Number Must be Numerics only"),
//       //   MinLengthValidator(9,
//       //       errorText: "Phone number should be 9 numbers long"),
//       //   MaxLengthValidator(9,
//       //       errorText: "Phone number should be 9 numbers long"),
//       // ]),
//       onSaved: (String value) {
//         _cellno = value;
//       },
//     );
//   }

//   Widget _buildEmail() {
//     return TextFormField(
//       decoration: InputDecoration(labelText: 'Email'),
//       // validator: MultiValidator([
//       //   EmailValidator(errorText: "Enter Valid Email"),
//       //   RequiredValidator(errorText: "Required"),
//       // ]),
//       onSaved: (String value) {
//         _email = value;
//       },
//     );
//   }

//   Widget _buildPassword() {
//     return TextFormField(
//       decoration: InputDecoration(labelText: 'Password'),
//       keyboardType: TextInputType.visiblePassword,
//       // validator: MultiValidator([
//       //   RequiredValidator(errorText: "Required"),
//       //   PatternValidator(r'(?=.*?[#?!@$%^&*-])',
//       //       errorText: "Enter Password with at lease one special character"),
//       // ]),
//       onSaved: (String value) {
//         _password = value;
//       },
//     );
//   }

//   Widget _buildconfirmPassword() {
//     return TextFormField(
//       decoration: InputDecoration(labelText: 'Password'),
//       keyboardType: TextInputType.visiblePassword,
//       // validator: MultiValidator([
//       //   RequiredValidator(errorText: "Required"),
//       //   PatternValidator(r'(?=.*?[#?!@$%^&*-])',
//       //       errorText: "Enter Password with at lease one special character"),
//       // ]),
//       onSaved: (String value) {
//         _confirmpass = value;
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Registration Page")),
//       body: SingleChildScrollView(
//         child: Container(
//           margin: EdgeInsets.all(24),
//           child: Form(
//             autovalidateMode: AutovalidateMode.always,
//             key: _formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 _buildfirstName(),
//                 _buildlastName(),
//                 _builduserName(),
//                 _buildidNumber(),
//                 _buildphoneNumber(),
//                 _buildcellNumber(),
//                 _buildEmail(),
//                 _buildPassword(),
//                 _buildconfirmPassword(),
//                 SizedBox(height: 100),
//                 // ignore: deprecated_member_use
//                 RaisedButton(
//                   child: Text(
//                     'Submit',
//                     style: TextStyle(color: Colors.blue, fontSize: 16),
//                   ),
//                   onPressed: () {
//                     if (!_formKey.currentState.validate()) {
//                       return;
//                     }

//                     _formKey.currentState.save();

//                     print(_firstName);
//                     print(_lastName);
//                     print(_userName);
//                     print(_idNumber);
//                     print(_phoneNumber);
//                     print(_cellno);
//                     print(_email);
//                     print(_phoneNumber);
//                     print(_password);
//                     print(_confirmpass);

//                     //Sending to API
//                     // _apiResponse();
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) => LoginScreen()));
//                   },
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   /* Future<void> _apiResponse() async {
//     var url =
//         Uri.parse('https://lamp.ms.wits.ac.za/home/s2092154/bankCli_reg.php');
//     var response = await http.post(
//       url,
//       body: {
//         'User_Type_ID': '201',
//         'Username': _userName,
//         'Password': _password,
//         'ID_Number': _idNumber,
//         'First_Name': _firstName,
//         'Last_Name': _lastName,
//         'Phone': _cellno,
//         'email': _email,

//         //print('Response status: ${response.statusCode}');
//         //print('Response body: ${response.body}');
//       },
//     );
//   }*/
// }
