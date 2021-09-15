import 'package:flutter/material.dart';
import 'package:flutter_projects/screens/login.dart';
import 'package:flutter_projects/services/auth.dart';
//import 'package:http/http.dart' as http;
//import 'package:form_field_validator/form_field_validator.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({@required this.auth});
  final AuthBase auth;
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _userName = TextEditingController();
  final _cellno = TextEditingController();
  final _email = TextEditingController();
  final _idNumber = TextEditingController();
  final _password = TextEditingController();
  final _confirmpass = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _submitted = false;
  bool _isLoading = false;

  void _submit() async {
    print("submit called");
    setState(() {
      _submitted = true;
      _isLoading = true;
    });
    try {
      await widget.auth
          .createUserWithEmailAndPassword(_email.text, _password.text);

      Navigator.of(context).pop();
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(title: Text("Registration Page"),
      backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(24),
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextFormField(
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'First Name is required';
                    }

                    if (!RegExp(
                            r"^(?<firstchar>(?=[A-Za-z]))((?<alphachars>[A-Za-z])|(?<specialchars>[A-Za-z]['-](?=[A-Za-z]))|(?<spaces> (?=[A-Za-z])))*$")
                        .hasMatch(value)) {
                      return 'Please enter a valid First Name';
                    }

                    return null;
                  },
                  controller: _firstName,
                  decoration: InputDecoration(
                    hintText: "First Name",
                  ),
                ),
                TextFormField(
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Last Name is required';
                    }

                    if (!RegExp(
                            r"^(?<firstchar>(?=[A-Za-z]))((?<alphachars>[A-Za-z])|(?<specialchars>[A-Za-z]['-](?=[A-Za-z]))|(?<spaces> (?=[A-Za-z])))*$")
                        .hasMatch(value)) {
                      return 'Please enter a valid Last Name';
                    }

                    return null;
                  },
                  controller: _lastName,
                  decoration: InputDecoration(
                    hintText: "Last Name",
                  ),
                ),
                TextFormField(
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Username is required';
                    }
                    return null;
                  },
                  controller: _userName,
                  decoration: InputDecoration(
                    hintText: "Username",
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'ID Number is Required';
                    }

                    if (!RegExp(r"^(0|[1-9][0-9]*)$").hasMatch(value)) {
                      return 'Enter Valid ID Number';
                    }

                    return null;
                  },
                  controller: _idNumber,
                  decoration: InputDecoration(
                    hintText: "ID Number",
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Cellphone number is Required';
                    }

                    if (!RegExp(r"^(0|[1-9][0-9]*)$").hasMatch(value)) {
                      return 'Enter Valid Cellphone Number';
                    }

                    return null;
                  },
                  controller: _cellno,
                  decoration: InputDecoration(
                    hintText: "Cellphone Number",
                  ),
                ),
                TextFormField(
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Email is Required';
                    }

                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Enter Valid Email';
                    }

                    return null;
                  },
                  controller: _email,
                  decoration: InputDecoration(
                    hintText: "Email address",
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Password is Required';
                    }

                    if (!RegExp(r'(?=.*?[#?!@$%^&*-])').hasMatch(value)) {
                      return 'Enter Password with at lease one special character';
                    }

                    return null;
                  },
                  controller: _password,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                  ),
                ),

                FlatButton(
                  onPressed: () {
                    _submit();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginPage(key: null,
                                //key: key, auth: auth
                                //  auth: widget.auth,
                                )));
                  },
                  child: Text(
                    "Register",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.orange,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
