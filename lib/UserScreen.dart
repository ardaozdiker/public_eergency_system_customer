import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:public_eergency_system_customer/main.dart';
import 'package:public_eergency_system_customer/user%20screen%20contents/ReportsPage.dart';
import 'package:public_eergency_system_customer/user%20screen%20contents/homePage.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  String uid = "";
  int currentIndex = 0;
  final screens=[HomeScreen(),
  ReportsScreen()];

  @override
  void initState() {
    super.initState();
    uid = FirebaseAuth.instance.currentUser!.uid;
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
         
          body: IndexedStack(index:currentIndex,children: screens,),
          bottomNavigationBar: BottomNavigationBar(                       //bottom navigation bar that helps to change pages
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.orange[800],
            selectedItemColor: Colors.white,
            showUnselectedLabels: false,
              currentIndex: currentIndex,
              onTap: (index) => setState(()            
              =>currentIndex = index),
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                    backgroundColor: Colors.orange[800]),
                BottomNavigationBarItem(
                    icon: Icon(Icons.receipt),
                    label: 'Reports',
                    backgroundColor: Colors.orange[600]),
                BottomNavigationBarItem(
                    icon: Icon(Icons.question_answer),
                    label: 'Chat',
                    backgroundColor: Colors.orange[500]),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                    backgroundColor: Colors.orange[400]),
              ])),
    );
  }
}
