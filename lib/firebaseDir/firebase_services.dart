import 'package:cimatick_project/firebaseDir/TicketsModel.dart';
import 'package:cimatick_project/firebaseDir/auth.dart';
import 'package:cimatick_project/firebaseDir/user_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class FirebaseServices {
  User? user = Auth().auth.currentUser;
  DatabaseReference userRef = FirebaseDatabase.instance.ref().child("Users");

  Future<List<Tickets>> getTicketDetails() async {
    DatabaseReference ticketRef = FirebaseDatabase.instance.ref().child("Tickets");
    try {
      DatabaseEvent event = await ticketRef.once();
      if (event.snapshot.value != null) {
        List<Tickets> ticketList = [];
        Map<dynamic, dynamic> snapshotData =
        event.snapshot.value as Map<dynamic, dynamic>;
        snapshotData.forEach((key, value) {
          if (value['userId'] == user?.uid) {
            ticketList.add(Tickets.fromMap(Map<String, dynamic>.from(value), key));
          }
        });
        return ticketList;
      }
    } catch (e) {
      print('Cannot get Ticket details: $e');
    }
    return [];
  }

  Future<UserDetails?> getUserFromDatabase() async {
    try {
      if (user != null) {
        DatabaseEvent event = await userRef.child(user!.uid).once();
        if (event.snapshot.value != null) {
          Map<dynamic, dynamic> snapMap = event.snapshot.value as dynamic;
          return UserDetails.fromMap(snapMap);
        } else {
          if (kDebugMode) {
            print('User Details are null');
          }
          return null;
        }
      } else {
        if (kDebugMode) {
          print('The current user is null');
        }
        return null;
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print('$e');
      }
      return null;
    }
  }
}
