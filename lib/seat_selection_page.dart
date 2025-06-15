import 'package:cimatick_project/Drawer.dart';
import 'package:cimatick_project/bottomNav.dart';
import 'package:flutter/material.dart';

class SeatSelectionPage extends StatefulWidget {
  const SeatSelectionPage({super.key});

  @override
  _SeatSelectionPageState createState() => _SeatSelectionPageState();
}

class _SeatSelectionPageState extends State<SeatSelectionPage> {
  final List<String> saverSeats = [
    '4A', '4B', '4C', '4D', '4E', '4F',
    '5A', '5B', '5C', '5D', '5E', '5F',
    '6A', '6B', '6C', '6D', '6E', '6F',
  ];

  final List<String> standardSeats = [
    '1A', '1B', '1C', '1D', '1E', '1F','1G', '1H','1I', '1J',
    '2A', '2B', '2C', '2D', '2E', '2F','2G', '2H',
    '3A', '3B', '3C', '3D', '3E', '3F','3G', '3H',
  ];

  final List<String> unavailableSeats = ['4C', '4D', '3A', '3B', '1E'];
  Set<String> selectedSeats = {};

  DateTime? selectedDate;
  String selectedBranch = '';
  String selectedTime = '';
  String? movieName;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args != null) {
      selectedDate = args['selectedDate'];
      selectedBranch = args['selectedBranch'];
      selectedTime = args['selectedTime'];
      movieName = args['movieName'];
    }
  }

  int getTotalPrice() {
    int total = 0;
    for (var seat in selectedSeats) {
      total += seat.startsWith('4') || seat.startsWith('5') || seat.startsWith('6') ? 3 : 5;
    }
    return total;
  }

  void toggleSeatSelection(String seat) {
    setState(() {
      if (selectedSeats.contains(seat)) {
        selectedSeats.remove(seat);
      } else {
        selectedSeats.add(seat);
      }
    });
  }

  Widget buildSeatRow(String rowLabel, List<String> seatsInRow) {
    List<Widget> rowChildren = [];
    rowChildren.add(
      Text(
        rowLabel,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );

    for (String seat in seatsInRow) {
      final isUnavailable = unavailableSeats.contains(seat);
      final isSelected = selectedSeats.contains(seat);
      rowChildren.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1),
          child: GestureDetector(
            onTap: isUnavailable ? null : () => toggleSeatSelection(seat),
            child: Icon(
              Icons.event_seat,
              color: isUnavailable
                  ? Colors.red
                  : isSelected
                  ? Colors.blue
                  : Colors.grey,
              size: 35,
            ),
          ),
        ),
      );
    }
    rowChildren.add(
      Text(
        rowLabel,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: rowChildren,
      ),
    );
  }




  Widget buildSeatSection(String label, List<String> seatList) {
    final rows = <Widget>[];
    final rowLabels = seatList.map((s) => s.substring(0, 1)).toSet().toList();
    rowLabels.sort((a, b) => int.parse(b).compareTo(int.parse(a)));

    for (var row in rowLabels) {
      final rowSeats = seatList.where((s) => s.startsWith(row)).toList();
      rows.add(buildSeatRow(row, rowSeats));
    }

    return Column(
      children: [
        SizedBox(height: 12),
        Text(label, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
        SizedBox(height: 6),
        ...rows,
      ],
    );
  }

  Widget buildLegend() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
        children: [
        Icon(Icons.event_seat, color: Colors.blue),
        SizedBox(width: 4),
        Text('Chosen', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          ],
        ),
        Row(
          children: [
            Icon(Icons.event_seat, color: Colors.grey),
            SizedBox(width: 4),
            Text('Available', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          ],
        ),
        Row(
          children: [
            Icon(Icons.event_seat, color: Colors.red),
            SizedBox(width: 4),
            Text('Not Available', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }

  Widget buildSummary() {
    final seatList = selectedSeats.toList()..sort();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Selected Seats: ${seatList.join(', ')}',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue)),
        SizedBox(height: 4),
        Text('Total Price: ${getTotalPrice()} JD',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(context),
      bottomNavigationBar: MyB(currentIndex: 0),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF3A7DCC),
        title: Text('CimaTick', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Center(
                child: Text('Screen',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue))),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Container(
                height: 70,
                width: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black54, width: 4),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 32),
            buildSeatSection('Saver - 3 JD', saverSeats),
            SizedBox(height: 16),
            buildSeatSection('Standard - 5 JD', standardSeats),
            SizedBox(height: 32),
            buildLegend(),
            SizedBox(height: 32),
            buildSummary(),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: selectedSeats.isNotEmpty
                  ? () {
                Navigator.pushNamed(
                  context,
                  '/pay',
                  arguments: {
                    'selectedDate': selectedDate,
                    'selectedBranch': selectedBranch,
                    'selectedTime': selectedTime,
                    'movieName': movieName,
                    'selectedSeats': selectedSeats.toList(),
                    'totalPrice': getTotalPrice(),
                  },
                );
              }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF3A7DCC),
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
              ),
              child: Text('CONTINUE TO CHECKOUT',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
