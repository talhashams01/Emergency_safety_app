

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:safe_her_app/authentication/signin_screen.dart';
import 'package:safe_her_app/authentication/signup_screen.dart';
import 'package:safe_her_app/bottom_nav_bar.dart';
import 'package:safe_her_app/firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print("Firebase initialization error: $e");
  }
  await Firebase.initializeApp(); runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Safe Zone App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: Colors.pink.shade50,
      ),
      home: AuthWrapper(),
      routes: {
        '/signin': (_) => SigninScreen(),
        '/signup': (_) => SignupScreen(),
        '/bottomnavbar': (_) => Bottomnav(),
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return Bottomnav();
        } else {
          return SigninScreen();
        }
      },
    );
  }
}

