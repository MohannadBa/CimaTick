import 'package:cimatick_project/firebaseDir/auth.dart';
import 'package:cimatick_project/firebaseDir/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../Drawer.dart';
import '../bottomNav.dart';
import '../firebaseDir/TicketsModel.dart';

final _formKey = GlobalKey<FormState>();

class PayTicket extends StatefulWidget {
  @override
  State<PayTicket> createState() => _PayTicketState();
}

class _PayTicketState extends State<PayTicket> {
  TextEditingController CreditCon = TextEditingController();
  String address = "";
  int price = 0;
  String date = "";
  String time = "";
  List<String> seats = [];
  String movieName = "";
  String ticketId = "";
  String? userId = Auth().auth.currentUser?.uid;
  List<Tickets> tickets = [];

  @override
  void initState() {
    super.initState();
    fetchTicketDetails();
  }

  Future<void> fetchTicketDetails() async {
    try {
      List<Tickets> ps = await FirebaseServices().getTicketDetails();
      setState(() {
        tickets = ps;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void _addTicket() async {
    if (userId == null)
      return;

    if (movieName.isNotEmpty &&
        time.isNotEmpty &&
        date.isNotEmpty &&
        address.isNotEmpty &&
        seats.isNotEmpty &&
        price > 0) {
      try {
        DatabaseReference newTicketRef =
        FirebaseDatabase.instance.ref().child("Tickets").push();
        ticketId = newTicketRef.key ?? "";

        await newTicketRef.set({
          'title': movieName,
          'time': time,
          'date': date,
          'branch': address,
          'seats': seats,
          'price': price,
          'userId': userId,
        });

        setState(() {
          tickets.add(
            Tickets(
              title: movieName,
              time: time,
              date: date,
              branch: address,
              seats: seats.join(", "),
              price: price,
              userid: userId!,
            ),
          );
          CreditCon.clear();
        });

        Navigator.pushNamed(context, "/pastorder");
      } catch (e) {
        print("Error saving ticket: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to save ticket")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    if (args != null) {
      date = args['selectedDate'] is DateTime
          ? (args['selectedDate'] as DateTime).toIso8601String().split('T').first
          : args['selectedDate'] ?? "";
      address = args['selectedBranch'] ?? "N/A";
      time = args['selectedTime'] ?? "N/A";
      seats = List<String>.from(args['selectedSeats'] ?? []);
      price = args['totalPrice'] ?? 0;
      movieName = args['movieName'] ?? 'Unknown';
    }
    double tax =  price * 0.16;
    double total = price + tax;

    return Scaffold(
      bottomNavigationBar: MyB(currentIndex: 0),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: MyDrawer(context),
      appBar: AppBar(
        backgroundColor: Color(0xFF3A7DCC),
        title: Text('Payment', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _ticketSummary(tax, total),
            SizedBox(height: 20),
            _paymentForm(),
          ],
        ),
      ),
    );
  }

  Widget _ticketSummary(double tax, double total) {
    return Card(
      color: Color(0xFF3A7DCC),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Your Ticket", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
            SizedBox(height: 12),
            _buildDetailRow("Movie:", movieName),
            _buildDetailRow("Cinema:", address),
            _buildDetailRow("Date:", date),
            _buildDetailRow("Time:", time),
            _buildDetailRow("Seats:", seats.join(', ')),
            SizedBox(height: 12),
            _buildDetailRow("Price:", "$price JD"),
            _buildDetailRow("Tax:", "${tax.toStringAsFixed(2)} JD"),
            Divider(color: Colors.white),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                Text("${total.toStringAsFixed(2)} JD", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _paymentForm() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Your Purchase Email:", style: TextStyle(fontWeight: FontWeight.w600)),
              Text("${Auth().currentUser!.email}", style: TextStyle(color: Colors.grey[700])),
              SizedBox(height: 12),
              Text("Credit or Debit Card Number"),
              TextFormField(
                controller: CreditCon,
                decoration: InputDecoration(
                  hintText: "1234567890123456",
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Enter card number";
                  if (value.length != 16) return "Card number must be 16 digits";
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Thank you for using CimaTick")),
                    );
                    _addTicket();
                  }
                },
                icon: Icon(Icons.credit_card, color: Colors.white),
                label: Text("PAY NOW", style: TextStyle(color:Colors.white,fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF3A7DCC),
                  minimumSize: Size(double.infinity, 48),
                ),
              ),
              SizedBox(height: 10),
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: Text("CANCEL", style: TextStyle(color: Colors.grey)),
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(double.infinity, 48),
                  side: BorderSide(color: Colors.grey),
                ),
              ),
              SizedBox(height: 8),
              Center(
                child: Text("All purchases are final and non-refundable.",
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    textAlign: TextAlign.center),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
          SizedBox(width: 5,),
          Text(value, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
