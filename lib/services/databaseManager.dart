import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;

  DatabaseService({
    this.uid
  });

  // Collection reference
  final CollectionReference Users = FirebaseFirestore.instance.collection('Users');
  final CollectionReference Customers = FirebaseFirestore.instance.collection('Customers');


  Future updateUserData(String email, String fullName, String phoneNo, String role) async {

    return await Users.doc(uid).set({
      'Email': email,
      'Full name': fullName,
      'Phone number': phoneNo,
      'Role': role,
    });
  }

  Future updateCustomerData(String email, String customerName, String description, String phoneNo, String address) async {

    return await Customers.doc(uid).set({
      'Email': email,
      'Customer name': customerName,
      'Description': description,
      'Phone number': phoneNo,
      'Address': address,
    });
  }

}