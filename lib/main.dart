import 'package:cimatick_project/MoviesScreens/Minecraft.dart';
import 'package:cimatick_project/MoviesScreens/Mission.dart';
import 'package:cimatick_project/MoviesScreens/SIKO.dart';
import 'package:cimatick_project/MoviesScreens/Sinners.dart';
import 'package:cimatick_project/MoviesScreens/Thunderbolts.dart';
import 'package:cimatick_project/Screens/HomePage.dart';
import 'package:cimatick_project/Screens/PastOrders.dart';
import 'package:cimatick_project/Screens/PayTicketsPage.dart';
import 'package:cimatick_project/Screens/profile_screen.dart';
import 'package:cimatick_project/Screens/sign_in_screen.dart';
import 'package:cimatick_project/Screens/signup_screen.dart';
import 'package:cimatick_project/firebaseDir/auth.dart';
import 'package:cimatick_project/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'MoviesScreens/theSurfer.dart';
import 'seat_selection_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ar_SA', null);
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e, s) {
    if (kDebugMode) {
      print('Firebase initialization failed: $e\n$s');
    }
  }
  runApp(CimaTickApp());
}

class CimaTickApp extends StatefulWidget {
   CimaTickApp({super.key});
   static _CimaTickAppState? of(BuildContext context) => context.findAncestorStateOfType<_CimaTickAppState>();

  @override
  State<CimaTickApp> createState() => _CimaTickAppState();
}

class _CimaTickAppState extends State<CimaTickApp> {
  ThemeMode _themeMode = ThemeMode.light;
  void toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CimaTick',
      theme: ThemeData.light().copyWith(
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.blue[700],
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[800],
          foregroundColor: Colors.white,
        ),
      ),
      textTheme: ThemeData.light().textTheme.copyWith(
        bodyMedium: TextStyle(color: Colors.black),
        bodyLarge: TextStyle(color: Colors.black),
      ),
    ),

      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,

      initialRoute: '/',
      routes: {
        '/': (context) => SignedUser(),
        "/pay": (context) => PayTicket(),
        "/TheSurfer": (context) => TheSurferPage(),
        "/pastorder": (context) => PastOrders(),
        '/signIn': (context) => SignInScreen(),
        '/signup': (context) =>  SignUpScreen(),
        '/profile': (context) => ProfileScreen(),
        '/HomePage': (context) => HomePage(),
        '/theSurfer': (context) => TheSurferPage(),
        '/thunderbolts': (context) => TunderboltsPage(),
        '/siko': (context) => SikoPage(),
        '/sinners': (context) => SinnersPage(),
        '/mission': (context) => MissionPage(),
        '/Minecraft': (context) => MinecraftPage(),
        '/seatSelection': (context) => SeatSelectionPage(),
      },

    );
  }
}
class SignedUser extends StatefulWidget {
  const SignedUser({super.key});
  @override
  State<SignedUser> createState() => _SignedUserState();
}

class _SignedUserState extends State<SignedUser> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomePage();
        } else {
          return SignUpScreen();
        }
      },
    );
  }
}