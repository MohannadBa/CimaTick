import 'package:cimatick_project/Drawer.dart';
import 'package:flutter/material.dart';
import '../bottomNav.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(context),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text("Movies", style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF3A7DCC),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      bottomNavigationBar: MyB(currentIndex: 0),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          "assets/images/TheSurfer.jpg",
                          width: 200,
                          height: 185,
                        ),
                        Text(
                          "The Surfer",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue[800],
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 7),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/TheSurfer');
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                            backgroundColor: Colors.blue[800],
                            fixedSize: Size(145, 10),
                          ),
                          child: Text(
                            "Book Now",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(height: 20),
                        //second movie
                        Image.asset(
                          "assets/images/Minecraft.jpg",
                          width: 200,
                          height: 185,
                        ),
                        Text(
                          "Minecraft",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue[800],
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 7),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/Minecraft');
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                            backgroundColor: Colors.blue[800],
                            fixedSize: Size(145, 10),
                          ),
                          child: Text(
                            "Book Now",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(height: 20),
                        //third movie
                        Image.asset(
                          "assets/images/mission.jpeg",
                          width: 200,
                          height: 185,
                        ),
                        Text(
                          "Mission: Impossible",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue[800],
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 7),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/mission');
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                            backgroundColor: Colors.blue[800],
                            fixedSize: Size(145, 10),
                          ),
                          child: Text(
                            "Book Now",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/images/Siko.jpeg",
                          width: 200,
                          height: 185,
                        ),
                        Text(
                          "SIKO سيكو",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue[800],
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 7),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/siko');

                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                            backgroundColor: Colors.blue[800],
                            fixedSize: Size(145, 10),
                          ),
                          child: Text(
                            "Book Now",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(height: 20),
                        //second movie
                        Image.asset(
                          "assets/images/sinners.jpeg",
                          width: 200,
                          height: 185,
                        ),
                        Text(
                          "Sinners",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue[800],
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 7),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/sinners');
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                            backgroundColor: Colors.blue[800],
                            fixedSize: Size(145, 10),
                          ),
                          child: Text(
                            "Book Now",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(height: 20),
                        //third movie

                        Image.asset(
                          "assets/images/Thunderbolts.jpeg",
                          width: 200,
                          height: 185,
                        ),
                        Text(
                          "Thunderbolts",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue[800],
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 7),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/thunderbolts');

                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                            backgroundColor: Colors.blue[800],
                            fixedSize: Size(145, 10),
                          ),
                          child: Text(
                            "Book Now",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
    );
  }
}
