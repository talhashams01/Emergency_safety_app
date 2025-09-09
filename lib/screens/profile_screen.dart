// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   final _auth = FirebaseAuth.instance;
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     loadUserData();
//   }

//   Future<void> loadUserData() async {
//     final user = _auth.currentUser;
//     if (user != null) {
//       final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
//       final data = doc.data();
//       if (data != null) {
//         _nameController.text = data['name'] ?? '';
//         _emailController.text = data['email'] ?? '';
//       }
//     }
//     setState(() => isLoading = false);
//   }

//   Future<void> updateUserData() async {
//     final user = _auth.currentUser;
//     if (user != null) {
//       await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
//         'name': _nameController.text.trim(),
//         'email': _emailController.text.trim(),
//       });

//       // Also update Firebase Auth email if changed
//       if (_emailController.text.trim() != user.email) {
//         await user.updateEmail(_emailController.text.trim());
//       }

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Profile updated')),
//       );
//     }
//   }

//   void logout() async {
//     await _auth.signOut();
//     Navigator.of(context).popUntil((route) => route.isFirst);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.pink.shade50,
//       appBar: AppBar(
//         title: Text("Profile"),
//         backgroundColor: Colors.pinkAccent,
//         centerTitle: true,
//       ),
//       body: isLoading
//           ? Center(child: CircularProgressIndicator(color: Colors.pink))
//           : Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 children: [
//                   TextField(
//                     controller: _nameController,
//                     decoration: _inputDecoration("Full Name"),
//                   ),
//                   const SizedBox(height: 15),
//                   TextField(
//                     controller: _emailController,
//                     decoration: _inputDecoration("Email"),
//                     keyboardType: TextInputType.emailAddress,
//                   ),
//                   const SizedBox(height: 30),
//                   ElevatedButton(
//                     onPressed: updateUserData,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.pinkAccent,
//                       padding: EdgeInsets.symmetric(horizontal: 50, vertical: 14),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     child: Text("Save Changes", style: TextStyle(fontSize: 16)),
//                   ),
//                   const SizedBox(height: 20),
//                   OutlinedButton(
//                     onPressed: logout,
//                     style: OutlinedButton.styleFrom(
//                       side: BorderSide(color: Colors.pinkAccent),
//                       padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
//                     ),
//                     child: Text("Logout", style: TextStyle(color: Colors.pinkAccent)),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }

//   InputDecoration _inputDecoration(String label) {
//     return InputDecoration(
//       labelText: label,
//       filled: true,
//       fillColor: Colors.white,
//       border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide(color: Colors.pinkAccent),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safe_her_app/authentication/signin_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _auth = FirebaseAuth.instance;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final user = _auth.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      final data = doc.data();
      if (data != null) {
        _nameController.text = data['name'] ?? '';
        _emailController.text = data['email'] ?? '';
      }
    }
    setState(() => isLoading = false);
  }

  // Future<void> updateUserData() async {
  //   final user = _auth.currentUser;
  //   if (user != null) {
  //     await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
  //       'name': _nameController.text.trim(),
  //       'email': _emailController.text.trim(),
  //     });

  //     if (_emailController.text.trim() != user.email) {
  //       try {
  //         await user.updateEmail(_emailController.text.trim());
  //       } catch (e) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text("Email update failed: $e")),
  //         );
  //       }
  //     }

  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Profile updated')),
  //     );
  //   }
  // }
  Future<void> updateUserData() async {
  final user = _auth.currentUser;
  final newEmail = _emailController.text.trim();

  if (user != null) {
    try {
      // Update Firestore name and email fields
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'name': _nameController.text.trim(),
        'email': newEmail,
      });

      // If email is changed
      if (newEmail != user.email) {
        await user.verifyBeforeUpdateEmail(newEmail);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Verification email sent to $newEmail. Please verify it.")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Profile updated.")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }
}

  void logout() async {
    await _auth.signOut();
    Navigator.pushNamedAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>SigninScreen()) as String,(route)  => false);
  }

  void deleteAccountWithPassword() {
    final passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Confirm Account Deletion"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Please enter your password to delete your account."),
            const SizedBox(height: 10),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Enter Password",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
          ElevatedButton(
            onPressed: () async {
              final user = _auth.currentUser;
              final cred = EmailAuthProvider.credential(
                email: user!.email!,
                password: passwordController.text.trim(),
              );
              try {
                await user.reauthenticateWithCredential(cred);
                await FirebaseFirestore.instance.collection('users').doc(user.uid).delete();
                await user.delete();
                Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
              } catch (e) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Failed: ${e.toString()}")),
                );
              }
            },
            child: Text("Delete"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.pink))
          : Center(
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: _nameController,
                        decoration: _inputDecoration("Full Name"),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: _emailController,
                        decoration: _inputDecoration("Email"),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: updateUserData,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent,
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text("Save Changes", style: TextStyle(fontSize: 16)),
                      ),
                      const SizedBox(height: 20),
                      OutlinedButton(
                        onPressed: logout,
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.pinkAccent),
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                        ),
                        child: Text("Logout", style: TextStyle(color: Colors.pinkAccent)),
                      ),
                      const SizedBox(height: 15),
                      OutlinedButton(
                        onPressed: deleteAccountWithPassword,
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.red),
                          padding: EdgeInsets.symmetric(horizontal: 35, vertical: 14),
                        ),
                        child: Text("Delete Account Permanently", style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                ),
              ),
          ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.pinkAccent),
      ),
    );
  }
}

































// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../authentication/signin_screen.dart'; // make sure this import is correct

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   final _auth = FirebaseAuth.instance;
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     loadUserData();
//   }

//   Future<void> loadUserData() async {
//     final user = _auth.currentUser;
//     if (user != null) {
//       final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
//       final data = doc.data();
//       if (data != null) {
//         _nameController.text = data['name'] ?? '';
//         _emailController.text = data['email'] ?? '';
//       }
//     }
//     setState(() => isLoading = false);
//   }

//   Future<void> updateUserData() async {
//     final user = _auth.currentUser;
//     if (user != null) {
//       await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
//         'name': _nameController.text.trim(),
//         'email': _emailController.text.trim(),
//       });

//       // Also update Firebase Auth email if changed
//       if (_emailController.text.trim() != user.email) {
//         await user.updateEmail(_emailController.text.trim());
//       }

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Profile updated')),
//       );
//     }
//   }

//   Future<void> logout() async {
//     // 1. Sign out from Firebase
//     await _auth.signOut();

//     // 2. Clear local SharedPreferences (important for hybrid data)
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.clear();

//     // 3. Navigate to SigninScreen and remove all previous routes
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (_) => SigninScreen()),
//       (route) => false,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.pink.shade50,
//       appBar: AppBar(
//         title: Text("Profile"),
//         backgroundColor: Colors.pinkAccent,
//         centerTitle: true,
//       ),
//       body: isLoading
//           ? Center(child: CircularProgressIndicator(color: Colors.pink))
//           : Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 children: [
//                   TextField(
//                     controller: _nameController,
//                     decoration: _inputDecoration("Full Name"),
//                   ),
//                   const SizedBox(height: 15),
//                   TextField(
//                     controller: _emailController,
//                     decoration: _inputDecoration("Email"),
//                     keyboardType: TextInputType.emailAddress,
//                   ),
//                   const SizedBox(height: 30),
//                   ElevatedButton(
//                     onPressed: updateUserData,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.pinkAccent,
//                       padding: EdgeInsets.symmetric(horizontal: 50, vertical: 14),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     child: Text("Save Changes", style: TextStyle(fontSize: 16)),
//                   ),
//                   const SizedBox(height: 20),
//                   OutlinedButton(
//                     onPressed: logout,
//                     style: OutlinedButton.styleFrom(
//                       side: BorderSide(color: Colors.pinkAccent),
//                       padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
//                     ),
//                     child: Text("Logout", style: TextStyle(color: Colors.pinkAccent)),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }

//   InputDecoration _inputDecoration(String label) {
//     return InputDecoration(
//       labelText: label,
//       filled: true,
//       fillColor: Colors.white,
//       border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide(color: Colors.pinkAccent),
//       ),
//     );
//   }
// }