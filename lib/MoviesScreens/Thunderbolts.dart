import 'package:cimatick_project/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import '../bottomNav.dart';

class TunderboltsPage extends StatefulWidget {
  const TunderboltsPage({super.key});

  @override
  _TunderboltsPageState createState() => _TunderboltsPageState();
}

class _TunderboltsPageState extends State<TunderboltsPage> {
  late VideoPlayerController _videoController;
  DateTime selectedDate = DateTime.now();
  String selectedBranch = 'Amman (Taj Mall)';
  String selectedTime = '1:00 AM';
  final double s = 24;
  final branches = ['Amman (Taj Mall)', 'Amman (Abdali)', 'Irbid', 'Zarqa'];
  final times = ['1:00 AM', '3:30 PM', '8:30 PM', '11:45 PM'];

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset('assets/videos/Thunderbolts.mp4')
      ..initialize().then((_) {
        setState(() {});
        _videoController.setLooping(true);
        _videoController.play();
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 30)),
      locale: const Locale("en", "US"),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat.yMMMMEEEEd('en_US').format(selectedDate);

    return Scaffold(
      drawer: MyDrawer(context),
      bottomNavigationBar: MyB(currentIndex: 0),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          _videoController.value.isInitialized
              ? Stack(
            alignment: Alignment.center,
            children: [
              AspectRatio(
                aspectRatio: _videoController.value.aspectRatio,
                child: VideoPlayer(_videoController),
              ),
              IconButton(
                iconSize: 64,
                color: Colors.white,
                icon: Icon(
                  _videoController.value.isPlaying
                      ? Icons.pause_circle_outline
                      : Icons.play_circle_outline,
                ),
                onPressed: () {
                  setState(() {
                    _videoController.value.isPlaying
                        ? _videoController.pause()
                        : _videoController.play();
                  });
                },
              ),
            ],
          )
              : Container(
            height: 200,
            color: Colors.black,
            child: Center(child: CircularProgressIndicator()),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Thunderbolts',
                      style: TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('Story',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: s, color: Colors.blue)),
                  const SizedBox(height: 4),
                  Text(
                    'Ensnared in a death trap, an unconventional team of antiheroes Yelena Belova, Bucky Barnes, Red Guardian, Ghost, Taskmaster and John Walker embarks on a dangerous mission that forces them to confront the darkest corners of their pasts.',
                    style: TextStyle(fontSize: s-8),
                  ),
                  const SizedBox(height: 16),
                  Text('Eligable Age: +18',
                      style:
                      TextStyle(fontSize: s-4, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/IMDB.svg.png',
                        width: 40,
                        height: 20,
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.star_border),
                      Text('7.6/10',
                          style: TextStyle(
                              fontSize: s-4,
                              fontWeight: FontWeight.w500)
                      ),
                    ],
                  ),
                  SizedBox(height: s),
                  Text('Pick Show Day',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: s, color: Colors.blue)),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () => _pickDate(context),
                    child: Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(formattedDate,
                          style:
                          TextStyle(fontSize: 16)),
                    ),
                  ),
                  SizedBox(height: s),
                  Text('Select Branch',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: s, color: Colors.blue)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: branches.map((branch) {
                      final isSelected = branch == selectedBranch;
                      return GestureDetector(
                        onTap: () => setState(() => selectedBranch = branch),
                        child: Text(
                          branch,
                          style: TextStyle(
                            fontSize: s-8,
                            color:
                            isSelected ? Colors.blue : Theme.of(context).textTheme.bodyMedium?.color,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: s),
                  Text('Select Show time',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: s, color: Colors.blue)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: times.map((time) {
                      final isSelected = time == selectedTime;
                      return GestureDetector(
                        onTap: () => setState(() => selectedTime = time),
                        child: Text(
                          time,
                          style: TextStyle(
                            fontSize: s-8,
                            color:
                            isSelected ? Colors.blue : Theme.of(context).textTheme.bodyMedium?.color,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: s + 4),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        _videoController.pause();
                        Navigator.pushNamed(
                          context,
                          '/seatSelection',
                          arguments: {
                            'selectedDate': selectedDate,
                            'selectedBranch': selectedBranch,
                            'selectedTime': selectedTime,
                            'movieName': 'Thunderbolts',
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF3A7DCC),
                        padding: EdgeInsets.all(14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text('SELECT SEATS',
                          style:
                          TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
