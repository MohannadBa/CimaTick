import 'package:cimatick_project/Drawer.dart';
import 'package:cimatick_project/firebaseDir/TicketsModel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../bottomNav.dart';

class PastOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(context),
      bottomNavigationBar: MyB(currentIndex: 1),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Color(0xFF3A7DCC),
        title: Text('Past Orders', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder(
        future: FirebaseDatabase.instance.ref().child("Tickets").get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          final data = (snapshot.data!.value as Map?) ?? {};
          final List<Tickets> tickets = data.entries.map<Tickets>((entry) {
            return Tickets.fromMap(Map<String, dynamic>.from(entry.value), entry.key);
          }).toList();

          if (tickets.isEmpty) {
            return Center(child: Text("No Tickets Found."));
          }

          return ListView.builder(
            itemCount: tickets.length,
            itemBuilder: (context, index) {
              final ticket = tickets[index];
              double tax = ticket.price * 0.16;
              double total = ticket.price + tax;

              String imageAsset = '';
              if (ticket.title == "The Surfer") {
                imageAsset = 'assets/images/TheSurfer.jpg';
              }
              else if (ticket.title == "Sinners") {
                imageAsset = 'assets/images/sinners.jpeg';
              }
              else if (ticket.title == "Thunderbolts") {
                imageAsset = 'assets/images/Thunderbolts.jpeg';
              }
              else if (ticket.title == "Siko") {
                imageAsset = 'assets/images/Siko.jpeg';
              }
              else if (ticket.title == "Mission Impossible") {
                imageAsset = 'assets/images/mission.jpeg';
              }
              else if (ticket.title == "Minecraft") {
                imageAsset = 'assets/images/Minecraft.jpg';
              }
              else
                imageAsset = '';


              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[800],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              imageAsset,
                              height: 100,
                              width: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Your Purchase", style: TextStyle(color: Colors.white70)),
                              Text("${ticket.price} JD",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(ticket.title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text("Cinema: ${ticket.branch}", style: TextStyle(color: Colors.white)),
                      Text("Date: ${ticket.date}", style: TextStyle(color: Colors.white)),
                      Text("Time: ${ticket.time}", style: TextStyle(color: Colors.white)),
                      Text("Seats: ${ticket.seats}", style: TextStyle(color: Colors.white)),
                      SizedBox(height: 8),
                      Divider(color: Colors.white),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("TAX", style: TextStyle(color: Colors.white)),
                          Text("${tax.toStringAsFixed(1)} JD", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Subtotal", style: TextStyle(color: Colors.white)),
                          Text("${ticket.price.toStringAsFixed(1)} JD", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      SizedBox(height: 8),
                      Divider(color: Colors.white),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                          Text("${total.toStringAsFixed(1)} JD",
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
