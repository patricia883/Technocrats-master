import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/services/auth2.dart';
import 'package:flutter_projects/screens/login.dart';
import 'package:flutter_projects/services/databaseManager.dart';
import 'package:toast/toast.dart';

class Customer_Dashboard extends StatefulWidget {
  static const routename = '/customerdashboard';

  @override
  State<StatefulWidget> createState() => customerState();
}

class customerState extends State<Customer_Dashboard>{
  final AuthService _auth = AuthService();
  final items = List.generate(2000, (counter) => 'Item: $counter');
  int _currentIndex = 0;

  final tabs = [
    Center(child: Text('Home')),
    Center(child: Text('Search')),
    Center(child: Text('Callout History')),
    Center(child: Text('Review & Rate')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' Welcome Faithful Customer',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),


      body: buildListViews(),
      backgroundColor: Colors.orangeAccent[100],

      //code the bottom navigation
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.orangeAccent,
        currentIndex: _currentIndex,
        iconSize: 30,
        selectedFontSize: 15,
        unselectedFontSize: 10,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), title: Text('Home'),
              backgroundColor: Colors.pinkAccent

          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search), title: Text('Search'),
              backgroundColor: Colors.red
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.work_outlined), title: Text(' Callout History'),
              backgroundColor: Colors.orangeAccent
             /* onPressed: () async{
                DocumentSnapshot variable = await FirebaseFirestore.instance.collection('Initial Callout').doc('33oKiPBTrZDWAle8ob1p'z).get();
                print(variable['Customer']);
           },*/
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.rate_review), title: Text('Review and Rate'),
              backgroundColor: Colors.deepOrange
          )
        ],

        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),


      //code for the side navigation
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: new Text("User",
                  style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0)
              ),
              accountEmail: new Text(""),
            ),

            ListTile(
              leading: Icon(Icons.person),
              title: Text("Profile"),
              onTap: () async {
                dynamic result = await _auth.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
                Toast.show("Logged out Successfully", context,
                    duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () async {
                dynamic result = await _auth.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
                Toast.show("Logged out Successfully", context,
                    duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
              },
            ),
            ListTile(
              leading: Icon(Icons.work_outline_sharp),
              title: Text("Previous Callouts"),
              onTap: () async {
                dynamic result = await _auth.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
                Toast.show("Logged out Successfully", context,
                    duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () async {
                dynamic result = await _auth.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
                Toast.show("Logged out Successfully", context,
                    duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
              },
            ),
          ],
        ),
      ),

    );
  }
  Future <void> _signOut() async{
    await FirebaseAuth.instance.signOut();
    User user = await FirebaseAuth.instance.currentUser;
  }

  Widget buildListViews() {
    if(_currentIndex == 0){
      return buildHomeListView();
    }
    else if(_currentIndex == 1){
      return buildSearchListView();
    }
    else if(_currentIndex == 2){
      return buildCalloutHistory();
    }else{
      return buildRateReview();
    }
  }

  Widget buildCalloutHistory() => ListView.separated(
    separatorBuilder: (context, index) => Divider(color: Colors.black),
    itemCount: items.length,
    itemBuilder: (context, index) {
      final item = items[index];

      return ListTile(
        title: Text(item),
      );
    },

  );

  Widget buildSearchListView() => ListView.separated(
    separatorBuilder: (context, index) => Divider(color: Colors.black),
    itemCount: items.length,
    itemBuilder: (context, index) {
      final item = items[index];

      return ListTile(
        title: Text(item),
      );
    },
  );

  Widget buildRateReview() => ListView.separated(
    separatorBuilder: (context, index) => Divider(color: Colors.black),
    itemCount: items.length,
    itemBuilder: (context, index) {
      final item = items[index];

      return ListTile(
        title: Text(item),
      );
    },
  );

  Widget buildHomeListView() => Container(
    height: 100,
    child: ListView.separated(
      padding: EdgeInsets.all(16),
      scrollDirection: Axis.horizontal,
      separatorBuilder: (context, index) => Divider(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: 16),
          child: Text(item, style: TextStyle(fontSize: 24)),
        );
      },
    ),
  );
}
