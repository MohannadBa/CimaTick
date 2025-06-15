import 'dart:io';
import 'package:cimatick_project/Drawer.dart';
import 'package:cimatick_project/firebaseDir/auth.dart';
import 'package:cimatick_project/firebaseDir/firebase_services.dart';
import 'package:cimatick_project/firebaseDir/user_details.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../bottomNav.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseServices firebaseServices = FirebaseServices();
  UserDetails? userDetails;

  @override
  void initState() {
    super.initState();

    if (Auth().auth.currentUser != null) {
      if (kDebugMode) {
        print('User is not null --------->>> ${Auth().auth.currentUser!.uid}');
      }
      fatchUserData();
    }

  }

  Future<void> fatchUserData() async {
    try {
      UserDetails? userDetailsTemp =
          await firebaseServices.getUserFromDatabase();

      if (userDetailsTemp != null) {
        setState(() {
          userDetails = userDetailsTemp;
        });
      } else {
        if (kDebugMode) {
          print('User not found');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("$e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (userDetails == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      bottomNavigationBar: MyB(currentIndex: 2),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text("Profile", style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF3A7DCC),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: MyDrawer(context),
      body: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: ListView(
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    'Profile',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                  ),
                  SizedBox(height: 48),
                  Text(
                    userDetails!.fullName,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                  Text(
                    userDetails!.email,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 32),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 2),
                    child: Text(
                      "Account",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 32,
                      bottom: 32,
                      left: 20,
                      right: 20,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.black12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              userDetails!.fullName,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.only(
                      top: 32,
                      bottom: 32,
                      left: 20,
                      right: 20,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.black12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Email",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              userDetails!.email,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.only(
                      top: 32,
                      bottom: 32,
                      left: 20,
                      right: 20,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.black12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Phone Number",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              userDetails!.phone,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


}
