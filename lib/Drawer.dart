import 'package:cimatick_project/firebaseDir/auth.dart';
import 'package:cimatick_project/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Drawer MyDrawer(BuildContext context) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;
  return Drawer(
   // backgroundColor: Colors.white,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Color(0xFF3A7DCC),
          ),
          child: Text(
            'CimaTick Menu',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.home,),
          title: Text('Home', style: TextStyle(fontSize: 16)),
          onTap: () {
          Navigator.pushNamed(context, '/HomePage');
          },
        ),
        ListTile(
          leading: Icon(Icons.person,),
          title: Text('Profile', style: TextStyle(fontSize: 16)),
          onTap: () {
            Navigator.pushNamed(context, '/profile');
            },
        ),
        ListTile(
          leading: Icon(Icons.logout,),
          title: Text('Logout', style: TextStyle(fontSize: 16)),
          onTap: () {
            _handleSignOut(context);
          },
        ),
        Divider(),
        SwitchListTile(
          title: Text("Dark Mode"),
          value: isDarkMode,
          activeColor: Colors.white,
          inactiveThumbColor: Colors.black,
          onChanged: (value) {
            CimaTickApp.of(context)?.toggleTheme(value);
          },
          secondary: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
        ),
      ],
    ),
  );
}
void _handleSignOut(context) {
  Auth().signOut();
  Navigator.pushNamed(context, '/signIn');
}
