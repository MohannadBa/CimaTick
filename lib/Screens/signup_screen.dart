import 'package:cimatick_project/firebaseDir/auth.dart';
import 'package:cimatick_project/firebaseDir/user_details.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _ageCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.all(32),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 0,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sign Up",
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Color(0xFF577dc6)),
              ),
              SizedBox(height: 50),
              TextFormField(
                controller: _nameCtrl,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  icon: Icon(Icons.person),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return 'Full name is required';
                  }
                  final parts =
                      v
                          .trim()
                          .split(RegExp(r'\s+'))
                          .where((part) => part.isNotEmpty)
                          .toList();
                  if (parts.length != 2) {
                    return 'Enter first, and last name';
                  }
                  for (final name in parts) {
                    if (name.length < 3) {
                      return 'Each name must be at least 3 characters';
                    }
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _emailCtrl,
                decoration: InputDecoration(
                  labelText: 'Email',
                  icon: Icon(Icons.mail),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'Email is required';
                  }
                  final emailRegex = RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  );
                  if (!emailRegex.hasMatch(v)) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _passCtrl,
                decoration: InputDecoration(
                  labelText: 'Password',
                  icon: Icon(Icons.lock),
                ),
                obscureText: true,
                validator: (v) {
                  if (v == null || v.length < 8) {
                    return 'Min 8 characters';
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                controller: _ageCtrl,
                decoration: InputDecoration(
                  labelText: 'Date of Birth',
                  icon: Icon(Icons.cake),
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime(2000),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    _ageCtrl.text = "${picked.toLocal()}".split(' ')[0];
                  }
                },
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'Date of birth is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _phoneCtrl,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  icon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return 'Phone number is required';
                  }
                  final phoneRegex = RegExp(r'^\+?\d{10,15}$');
                  if (!phoneRegex.hasMatch(v)) {
                    return 'Enter a valid phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _handleSignUp();
                    }
                  },
                  style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Color(0xFF577DC6))),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Text('Sign Up', style: TextStyle(color: Colors.white, fontSize: 24),),
                  ),
                ),
              ),
              SizedBox(height: 30),
              RichText(
                text: TextSpan(
                  text: 'ALREADY HAVE AN ACCOUNT?',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w700,
                    fontSize: 18
                  ),
                  recognizer:
                      TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushReplacementNamed(context, '/signIn');
                        },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final DatabaseReference userRef = FirebaseDatabase.instance.ref().child(
    "Users",
  );

  void _handleSignUp() {
    Auth()
        .createUserWithEmailAndPassword(
          email: _emailCtrl.text,
          password: _passCtrl.text,
        )
        .whenComplete(() {
          if (kDebugMode) {
            print("User Created Successfully");
          }
          Auth().auth.authStateChanges().first;
          Future.delayed(Duration(seconds: 2)).then((value) {
            try {
              UserDetails userInput = UserDetails(
                fullName: _nameCtrl.text,
                email: _emailCtrl.text,
                dateOfBirth: _ageCtrl.text,
                phone: _phoneCtrl.text
              );
              if (Auth().auth.currentUser != null) {
                userRef
                    .child(Auth().auth.currentUser!.uid)
                    .set(userInput.toMap())
                    .then((value) {
                      if (kDebugMode) {
                        print("User Added Successfully To Realtime Database");
                      }
                      Navigator.pushNamed(context, '/HomePage');
                    })
                    .catchError((error) {
                      if (kDebugMode) {
                        print(
                          "Failed to add user to realtime database\n$error\n------------------------------------------",
                        );
                      }
                    });
              } else {
                if (kDebugMode) {
                  print("The user uid is still null");
                }
              }
            } on FirebaseException catch (e) {
              if (kDebugMode) {
                print("Error occurred..................................\n$e");
              }
            }
          });
        });
  }
}
