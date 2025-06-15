import 'package:cimatick_project/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import '../bottomNav.dart';

class MinecraftPage extends StatefulWidget {
  const MinecraftPage({super.key});

  @override
  _MinecraftPageState createState() => _MinecraftPageState();
}

class _MinecraftPageState extends State<MinecraftPage> {
  late VideoPlayerController _videoController;
  DateTime selectedDate = DateTime.now();
  String selectedBranch = 'Amman (Taj Mall)';
  String selectedTime = '12:10 AM';
  final double s = 24;
  final branches = ['Amman (Taj Mall)', 'Amman (Abdali)', 'Irbid', 'Zarqa'];
  final times = ['12:10 AM', '12:30 PM', '4:30 PM', '11:10 PM'];

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset('assets/videos/Minecraft.mp4')
      ..initialize().then((_) {
        setState(() {});
        _videoController.setLooping(false);
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
                  Text('Minecraft',
                      style: TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('Story',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: s, color: Colors.blue)),
                  const SizedBox(height: 4),
                  Text(
                    "A mysterious portal pulls four misfits into the Overworld, a bizarre, cubic wonderland that thrives on imagination. To get back home, they'll have to master the terrain while embarking on a magical quest with an unexpected crafter named Steve.",
                    style: TextStyle(fontSize: s-8),
                  ),
                  const SizedBox(height: 16),
                  Text('Eligable Age: +12',
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
                      Text('5.7/10',
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
                  SizedBox(height: 10),
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
                    children:
                    times.map((time) {
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
                            'movieName': 'Minecraft',
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
