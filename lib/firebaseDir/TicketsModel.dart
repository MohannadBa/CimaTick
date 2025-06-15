class Tickets {
  String title;
  String time;
  String date;
  String branch;
  String seats;
  int price;
  String userid;

  Tickets({
    required this.title,
    required this.time,
    required this.date,
    required this.branch,
    required this.seats,
    required this.price,
    required this.userid,
  });

  factory Tickets.fromMap(Map<String, dynamic> map, String id) {
    return Tickets(
      title: map['title'] ?? '',
      time: map['time'] ?? '',
      date: map['date'] ?? '',
      branch: map['branch'] ?? '',
      seats: (map['seats'] is List)
          ? (map['seats'] as List).join(", ")
          : map['seats']?.toString() ?? "",
      price: map['price'] ?? 0,
      userid: map['userId'] ?? '',
    );
  }
}
