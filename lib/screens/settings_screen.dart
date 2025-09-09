// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SettingsScreen extends StatefulWidget {
//   @override
//   _SettingsScreenState createState() => _SettingsScreenState();
// }

// class _SettingsScreenState extends State<SettingsScreen> {
//   final TextEditingController _emergencyController = TextEditingController();
//   final TextEditingController _safeController = TextEditingController();
//   final String emergencyKey = 'emergencyMessage';
//   final String safeKey = 'safeMessage';
//   final String pinKey = 'panic_pin';

//   @override
//   void initState() {
//     super.initState();
//     loadSettings();
//   }

//   Future<void> loadSettings() async {
//     final prefs = await SharedPreferences.getInstance();
//     _emergencyController.text = prefs.getString(emergencyKey) ??
//         "This is an emergency! I need help. Please call me ASAP!";
//     _safeController.text =
//         prefs.getString(safeKey) ?? "Hey, I'm safe now. No need to worry 😊";
//     setState(() {});
//   }

//   Future<void> saveEmergencyMessage() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(emergencyKey, _emergencyController.text);
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("Emergency message saved")),
//     );
//   }

//   Future<void> saveSafeMessage() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(safeKey, _safeController.text);
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("I'm Safe message saved")),
//     );
//   }

//   Future<void> handlePinAction() async {
//     final prefs = await SharedPreferences.getInstance();
//     final hasPin = prefs.containsKey(pinKey);

//     if (!hasPin) {
//       // SET PIN
//       showPinDialog("Set PIN", onSave: (pin) {
//         prefs.setString(pinKey, pin);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("PIN set successfully")),
//         );
//       });
//     } else {
//       // OPTIONS: Change or Disable
//       showModalBottomSheet(
//         context: context,
//         builder: (_) => Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ListTile(
//               leading: Icon(Icons.lock_reset),
//               title: Text("Change PIN"),
//               onTap: () {
//                 Navigator.pop(context);
//                 showPinDialog("Change PIN", onSave: (pin) {
//                   prefs.setString(pinKey, pin);
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text("PIN changed")),
//                   );
//                 });
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.lock_open),
//               title: Text("Disable PIN"),
//               onTap: () {
//                 Navigator.pop(context);
//                 prefs.remove(pinKey);
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text("PIN disabled")),
//                 );
//               },
//             ),
//           ],
//         ),
//       );
//     }
//   }

//   void showPinDialog(String title, {required Function(String) onSave}) {
//     final TextEditingController _pinController = TextEditingController();

//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: Text(title),
//         content: TextField(
//           controller: _pinController,
//           keyboardType: TextInputType.number,
//           maxLength: 6,
//           decoration: InputDecoration(
//             labelText: "Enter PIN",
//             border: OutlineInputBorder(),
//           ),
//           obscureText: true,
//         ),
//         actions: [
//           TextButton(
//             child: Text("Cancel"),
//             onPressed: () => Navigator.pop(context),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               if (_pinController.text.trim().length >= 4) {
//                 onSave(_pinController.text.trim());
//                 Navigator.pop(context);
//               } else {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text("PIN must be at least 4 digits")),
//                 );
//               }
//             },
//             child: Text("Save"),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Settings"),
//         backgroundColor: Colors.pink,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Preferences Section
//             Text(
//               "Preferences",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             Text("Emergency Message:"),
//             const SizedBox(height: 6),
//             TextField(
//               controller: _emergencyController,
//               maxLines: 3,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: "Enter your emergency message",
//               ),
//             ),
//             const SizedBox(height: 10),
//             ElevatedButton.icon(
//               onPressed: saveEmergencyMessage,
//               icon: Icon(Icons.save),
//               label: Text("Save SOS Message"),
//               style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
//             ),
//             const SizedBox(height: 20),
//             Text("I'm Safe Message:"),
//             const SizedBox(height: 6),
//             TextField(
//               controller: _safeController,
//               maxLines: 2,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: "Enter your 'I'm safe' message",
//               ),
//             ),
//             const SizedBox(height: 10),
//             ElevatedButton.icon(
//               onPressed: saveSafeMessage,
//               icon: Icon(Icons.save_alt),
//               label: Text("Save Safe Message"),
//               style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
//             ),

//             const SizedBox(height: 30),
//             Divider(thickness: 1.5),
//             const SizedBox(height: 10),

//             // General Settings Section
//             Text(
//               "General Settings",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 16),
//             ListTile(
//               leading: Icon(Icons.lock),
//               title: Text("Manage PIN for Panic Diary"),
//               onTap: handlePinAction,
//               trailing: Icon(Icons.arrow_forward_ios, size: 18),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SettingsScreen extends StatefulWidget {
//   @override
//   _SettingsScreenState createState() => _SettingsScreenState();
// }

// class _SettingsScreenState extends State<SettingsScreen> {
//   final TextEditingController _emergencyController = TextEditingController();
//   final TextEditingController _safeController = TextEditingController();
//   final String emergencyKey = 'emergencyMessage';
//   final String safeKey = 'safeMessage';
//   final String pinKey = 'panic_pin';
//   final String pinChangedKey = 'panic_pin_changed';

//   @override
//   void initState() {
//     super.initState();
//     loadSettings();
//   }

//   Future<void> loadSettings() async {
//     final prefs = await SharedPreferences.getInstance();
//     _emergencyController.text = prefs.getString(emergencyKey) ??
//         "This is an emergency! I need help. Please call me ASAP!";
//     _safeController.text =
//         prefs.getString(safeKey) ?? "Hey, I'm safe now. No need to worry 😊";
//     setState(() {});
//   }

//   Future<void> saveEmergencyMessage() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(emergencyKey, _emergencyController.text);
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("Emergency message saved")),
//     );
//   }

//   Future<void> saveSafeMessage() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(safeKey, _safeController.text);
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("I'm Safe message saved")),
//     );
//   }

//   Future<void> handlePinAction() async {
//     final prefs = await SharedPreferences.getInstance();
//     final hasPin = prefs.containsKey(pinKey);

//     if (!hasPin) {
//       // SET PIN
//       showPinDialog("Set PIN", onSave: (pin) async {
//         await prefs.setString(pinKey, pin);
//         await prefs.setBool(pinChangedKey, true);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("PIN set successfully")),
//         );
//       });
//     } else {
//       // OPTIONS: Change or Disable
//       showModalBottomSheet(
//         context: context,
//         builder: (_) => Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ListTile(
//               leading: Icon(Icons.lock_reset),
//               title: Text("Change PIN"),
//               onTap: () async {
//                 Navigator.pop(context);
//                 showPinDialog("Change PIN", onSave: (pin) async {
//                   await prefs.setString(pinKey, pin);
//                   await prefs.setBool(pinChangedKey, true);
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text("PIN changed")),
//                   );
//                 });
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.lock_open),
//               title: Text("Disable PIN"),
//               onTap: () async {
//                 Navigator.pop(context);
//                 await prefs.remove(pinKey);
//                 await prefs.setBool(pinChangedKey, true);
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text("PIN disabled")),
//                 );
//               },
//             ),
//           ],
//         ),
//       );
//     }
//   }

//   void showPinDialog(String title, {required Function(String) onSave}) {
//     final TextEditingController _pinController = TextEditingController();

//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: Text(title),
//         content: TextField(
//           controller: _pinController,
//           keyboardType: TextInputType.number,
//           maxLength: 6,
//           decoration: InputDecoration(
//             labelText: "Enter PIN",
//             border: OutlineInputBorder(),
//           ),
//           obscureText: true,
//         ),
//         actions: [
//           TextButton(
//             child: Text("Cancel"),
//             onPressed: () => Navigator.pop(context),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               if (_pinController.text.trim().length >= 4) {
//                 onSave(_pinController.text.trim());
//                 Navigator.pop(context);
//               } else {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text("PIN must be at least 4 digits")),
//                 );
//               }
//             },
//             child: Text("Save"),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Settings"),
//         backgroundColor: Colors.pink,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Preferences Section
//             Text(
//               "Preferences",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             Text("Emergency Message:"),
//             const SizedBox(height: 6),
//             TextField(
//               controller: _emergencyController,
//               maxLines: 3,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: "Enter your emergency message",
//               ),
//             ),
//             const SizedBox(height: 10),
//             ElevatedButton.icon(
//               onPressed: saveEmergencyMessage,
//               icon: Icon(Icons.save),
//               label: Text("Save SOS Message"),
//               style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
//             ),
//             const SizedBox(height: 20),
//             Text("I'm Safe Message:"),
//             const SizedBox(height: 6),
//             TextField(
//               controller: _safeController,
//               maxLines: 2,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: "Enter your 'I'm safe' message",
//               ),
//             ),
//             const SizedBox(height: 10),
//             ElevatedButton.icon(
//               onPressed: saveSafeMessage,
//               icon: Icon(Icons.save_alt),
//               label: Text("Save Safe Message"),
//               style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
//             ),
//             const SizedBox(height: 30),
//             Divider(thickness: 1.5),
//             const SizedBox(height: 10),

//             // General Settings Section
//             Text(
//               "General Settings",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 16),
//             ListTile(
//               leading: Icon(Icons.lock),
//               title: Text("Manage PIN for Panic Diary"),
//               onTap: handlePinAction,
//               trailing: Icon(Icons.arrow_forward_ios, size: 18),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:safe_her_app/screens/otherscreens/Terms_screen.dart';
// import 'package:safe_her_app/screens/otherscreens/about_app.dart';
// import 'package:safe_her_app/screens/otherscreens/privacy_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:share_plus/share_plus.dart';

// class SettingsScreen extends StatefulWidget {
//   @override
//   _SettingsScreenState createState() => _SettingsScreenState();
// }

// class _SettingsScreenState extends State<SettingsScreen> {
//   final TextEditingController _emergencyController = TextEditingController();
//   final TextEditingController _safeController = TextEditingController();
//   final String emergencyKey = 'emergencyMessage';
//   final String safeKey = 'safeMessage';
//   final String pinKey = 'panic_pin';
//   bool _obscurePin = true;

//   @override
//   void initState() {
//     super.initState();
//     loadSettings();
//   }

//   Future<void> loadSettings() async {
//     final prefs = await SharedPreferences.getInstance();
//     _emergencyController.text = prefs.getString(emergencyKey) ??
//         "This is an emergency! I need help. Please call me ASAP!";
//     _safeController.text =
//         prefs.getString(safeKey) ?? "Hey, I'm safe now. No need to worry 😊";
//     setState(() {});
//   }

//   Future<void> saveEmergencyMessage() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(emergencyKey, _emergencyController.text);
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("Emergency message saved")),
//     );
//   }

//   Future<void> saveSafeMessage() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(safeKey, _safeController.text);
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("I'm Safe message saved")),
//     );
//   }

//   Future<void> handlePinAction() async {
//     final prefs = await SharedPreferences.getInstance();
//     final hasPin = prefs.containsKey(pinKey);

//     if (!hasPin) {
//       showPinDialog("Set PIN", onSave: (pin) {
//         prefs.setString(pinKey, pin);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("PIN set successfully")),
//         );
//       });
//     } else {
//       showModalBottomSheet(
//         context: context,
//         builder: (_) => Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ListTile(
//               leading: Icon(Icons.lock_reset),
//               title: Text("Change PIN"),
//               onTap: () {
//                 Navigator.pop(context);
//                 verifyCurrentPin(
//                   onVerified: () {
//                     showPinDialog("Enter New PIN", onSave: (newPin) {
//                       prefs.setString(pinKey, newPin);
//                       prefs.setBool('panic_pin_changed', true);
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text("PIN changed")),
//                       );
//                     });
//                   },
//                 );
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.lock_open),
//               title: Text("Disable PIN"),
//               onTap: () {
//                 Navigator.pop(context);
//                 verifyCurrentPin(
//                   onVerified: () {
//                     prefs.remove(pinKey);
//                     prefs.setBool('panic_pin_changed', true);
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text("PIN disabled")),
//                     );
//                   },
//                 );
//               },
//             ),
//           ],
//         ),
//       );
//     }
//   }

//   void verifyCurrentPin({required VoidCallback onVerified}) async {
//     final prefs = await SharedPreferences.getInstance();
//     final savedPin = prefs.getString(pinKey) ?? '';
//     final TextEditingController _pinController = TextEditingController();

//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: Text("Enter Current PIN"),
//         content: StatefulBuilder(
//           builder: (context, setState) => TextField(
//             controller: _pinController,
//             keyboardType: TextInputType.number,
//             obscureText: _obscurePin,
//             maxLength: 6,
//             decoration: InputDecoration(
//               hintText: "Enter your current PIN",
//               border: OutlineInputBorder(),
//               suffixIcon: IconButton(
//                 icon: Icon(
//                     _obscurePin ? Icons.visibility : Icons.visibility_off),
//                 onPressed: () => setState(() {
//                   _obscurePin = !_obscurePin;
//                 }),
//               ),
//             ),
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text("Cancel"),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               if (_pinController.text == savedPin) {
//                 Navigator.pop(context);
//                 onVerified();
//               } else {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text("Incorrect PIN")),
//                 );
//               }
//             },
//             child: Text("Verify"),
//           ),
//         ],
//       ),
//     );
//   }

//   void showPinDialog(String title, {required Function(String) onSave}) {
//     final TextEditingController _pinController = TextEditingController();

//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: Text(title),
//         content: StatefulBuilder(
//           builder: (context, setState) => TextField(
//             controller: _pinController,
//             keyboardType: TextInputType.number,
//             obscureText: _obscurePin,
//             maxLength: 6,
//             decoration: InputDecoration(
//               labelText: "Enter PIN",
//               border: OutlineInputBorder(),
//               suffixIcon: IconButton(
//                 icon: Icon(
//                     _obscurePin ? Icons.visibility : Icons.visibility_off),
//                 onPressed: () => setState(() {
//                   _obscurePin = !_obscurePin;
//                 }),
//               ),
//             ),
//           ),
//         ),
//         actions: [
//           TextButton(
//             child: Text("Cancel"),
//             onPressed: () => Navigator.pop(context),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               if (_pinController.text.trim().length >= 4) {
//                 onSave(_pinController.text.trim());
//                 Navigator.pop(context);
//               } else {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text("PIN must be at least 4 digits")),
//                 );
//               }
//             },
//             child: Text("Save"),
//           ),
//         ],
//       ),
//     );
//   }

//   void _shareApp() {
//     Share.share(
//         "Check out this amazing safety app! Download now from the Play Store.");
//   }

//   void _sendFeedback() async {
//     final Uri email = Uri(
//       scheme: 'mailto',
//       path: 'talhashamsdev101@gmail.com',
//       query: 'subject=App Feedback&body=Your feedback here...',
//     );
//     if (await canLaunchUrl(email)) {
//       await launchUrl(email);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Could not open email app.")),
//       );
//     }
//   }

//   // void _openPage(String title) {
//   //   // You can navigate to your custom page here using:
//   //   // Navigator.push(context, MaterialPageRoute(builder: (_) => YourPage()));
//   //   ScaffoldMessenger.of(context).showSnackBar(
//   //     SnackBar(content: Text("$title screen not implemented")),
//   //   );
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Settings"),
//         backgroundColor: Colors.pink,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Preferences
//             Text("Preferences",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 10),
//             Text("Emergency Message:"),
//             const SizedBox(height: 6),
//             TextField(
//               controller: _emergencyController,
//               maxLines: 3,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: "Enter your emergency message",
//               ),
//             ),
//             const SizedBox(height: 10),
//             ElevatedButton.icon(
//               onPressed: saveEmergencyMessage,
//               icon: Icon(Icons.save),
//               label: Text("Save SOS Message"),
//               style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
//             ),
//             const SizedBox(height: 20),
//             Text("I'm Safe Message:"),
//             const SizedBox(height: 6),
//             TextField(
//               controller: _safeController,
//               maxLines: 2,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: "Enter your 'I'm safe' message",
//               ),
//             ),
//             const SizedBox(height: 10),
//             ElevatedButton.icon(
//               onPressed: saveSafeMessage,
//               icon: Icon(Icons.save_alt),
//               label: Text("Save Safe Message"),
//               style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
//             ),

//             const SizedBox(height: 30),
//             Divider(thickness: 1.5),

//             // General Settings
//             const SizedBox(height: 10),
//             Text("General Settings",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 16),
//             ListTile(
//               leading: Icon(Icons.lock),
//               title: Text("Manage PIN for Panic Diary"),
//               onTap: handlePinAction,
//               trailing: Icon(Icons.arrow_forward_ios, size: 18),
//             ),

//             const SizedBox(height: 30),
//             Divider(thickness: 1.5),

//             // App Info Section
//             const SizedBox(height: 10),
//             Text("App Info",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 16),
//             Card(
//               child: Column(
//                 children: [
//                   ListTile(
//                     leading: Icon(Icons.privacy_tip),
//                     title: Text("Privacy Policy"),
//                     onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> PrivacyPolicyScreen())),
//                   ),
//                   Divider(height: 1),
//                   ListTile(
//                     leading: Icon(Icons.rule),
//                     title: Text("Terms and Conditions"),
//                     onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> TermsAndConditionsScreen())),
//                   ),
//                   Divider(height: 1),
//                   ListTile(
//                     leading: Icon(Icons.share),
//                     title: Text("Share App"),
//                     onTap: _shareApp,
//                   ),
//                   Divider(height: 1),
//                   ListTile(
//                     leading: Icon(Icons.feedback),
//                     title: Text("App Feedback"),
//                     onTap: _sendFeedback,
//                   ),
//                   Divider(height: 1),
//                   ListTile(
//                     leading: Icon(Icons.info_outline),
//                     title: Text("About App"),
//                     onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> AboutAppScreen())),
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safe_her_app/authentication/signin_screen.dart';
import 'package:safe_her_app/screens/otherscreens/Terms_screen.dart';
import 'package:safe_her_app/screens/otherscreens/about_app.dart';
import 'package:safe_her_app/screens/otherscreens/app_usage.dart';
//import 'package:safe_her_app/screens/otherscreens/contact_dev.dart';
import 'package:safe_her_app/screens/otherscreens/privacy_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _emergencyController = TextEditingController();
  final TextEditingController _safeController = TextEditingController();
  final String emergencyKey = 'emergencyMessage';
  final String safeKey = 'safeMessage';
  final String pinKey = 'panic_pin';
  bool _obscurePin = true;

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _emergencyController.text =
        prefs.getString(emergencyKey) ??
        "This is an emergency! I need help. Please call me ASAP!";
    _safeController.text =
        prefs.getString(safeKey) ?? "Hey, I'm safe now. No need to worry 😊";
    setState(() {});
  }

  Future<void> saveEmergencyMessage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(emergencyKey, _emergencyController.text);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Emergency message saved")));
  }

  Future<void> saveSafeMessage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(safeKey, _safeController.text);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("I'm Safe message saved")));
  }

  Future<void> handlePinAction() async {
    final prefs = await SharedPreferences.getInstance();
    final hasPin = prefs.containsKey(pinKey);

    if (!hasPin) {
      showPinDialog(
        "Set PIN",
        onSave: (pin) {
          prefs.setString(pinKey, pin);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("PIN set successfully")));
        },
      );
    } else {
      showModalBottomSheet(
        context: context,
        builder: (_) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.lock_reset),
              title: Text("Change PIN"),
              onTap: () {
                Navigator.pop(context);
                verifyCurrentPin(
                  onVerified: () {
                    showPinDialog(
                      "Enter New PIN",
                      onSave: (newPin) {
                        prefs.setString(pinKey, newPin);
                        prefs.setBool('panic_pin_changed', true);
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text("PIN changed")));
                      },
                    );
                  },
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.lock_open),
              title: Text("Disable PIN"),
              onTap: () {
                Navigator.pop(context);
                verifyCurrentPin(
                  onVerified: () {
                    prefs.remove(pinKey);
                    prefs.setBool('panic_pin_changed', true);
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("PIN disabled")));
                  },
                );
              },
            ),
          ],
        ),
      );
    }
  }

  void verifyCurrentPin({required VoidCallback onVerified}) async {
    final prefs = await SharedPreferences.getInstance();
    final savedPin = prefs.getString(pinKey) ?? '';
    final TextEditingController _pinController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Enter Current PIN"),
        content: StatefulBuilder(
          builder: (context, setState) => TextField(
            controller: _pinController,
            keyboardType: TextInputType.number,
            obscureText: _obscurePin,
            maxLength: 6,
            decoration: InputDecoration(
              hintText: "Enter your current PIN",
              border: OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePin ?  Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () => setState(() {
                  _obscurePin = !_obscurePin;
                }),
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (_pinController.text == savedPin) {
                Navigator.pop(context);
                onVerified();
              } else {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("Incorrect PIN")));
              }
            },
            child: Text("Verify"),
          ),
        ],
      ),
    );
  }

  void showPinDialog(String title, {required Function(String) onSave}) {
    final TextEditingController _pinController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: StatefulBuilder(
          builder: (context, setState) => TextField(
            controller: _pinController,
            keyboardType: TextInputType.number,
            obscureText: _obscurePin,
            maxLength: 6,
            decoration: InputDecoration(
              labelText: "Enter PIN",
              border: OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePin ?  Icons.visibility_off : Icons.visibility ,
                ),
                onPressed: () => setState(() {
                  _obscurePin = !_obscurePin;
                }),
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            child: Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            onPressed: () {
              if (_pinController.text.trim().length >= 4) {
                onSave(_pinController.text.trim());
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("PIN must be at least 4 digits")),
                );
              }
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }

  void _shareApp() {
    Share.share(
      "Check out this amazing safety app! Download now from the Play Store.",
    );
  }

  void _sendFeedback() async {
    final Uri email = Uri(
      scheme: 'mailto',
      path: 'talhashamsdev101@gmail.com',
      query: 'subject=App Feedback&body=Your feedback here...',
    );
    if (await canLaunchUrl(email)) {
      await launchUrl(email);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Could not open email app.")));
    }
  }

  Future<void> resetAppSettings() async {
    final confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Reset App Settings"),
        content: Text(
          "Are you sure you want to reset all app settings? This cannot be undone.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text("Reset"),
          ),
        ],
      ),
    );
    if (confirm == true) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => SettingsScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings"), backgroundColor: Colors.pink,
      actions: [
        IconButton(
          icon: Icon(Icons.logout, color: Colors.white),
          onPressed: () async{
            await
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SigninScreen()));
          },
        ),
      ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Preferences",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text("Emergency Message:"),
            const SizedBox(height: 6),
            TextField(
              controller: _emergencyController,
              maxLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter your emergency message",
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton.icon(
                onPressed: saveEmergencyMessage,
                icon: Icon(Icons.save),
                label: Text("Save SOS Message"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
              ),
            ),
            const SizedBox(height: 20),
            Text("I'm Safe Message:"),
            const SizedBox(height: 6),
            TextField(
              controller: _safeController,
              maxLines: 2,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter your 'I'm safe' message",
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton.icon(
                onPressed: saveSafeMessage,
                icon: Icon(Icons.save_alt),
                label: Text("Save Safe Message"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: resetAppSettings,
                icon: Icon(Icons.refresh),
                label: Text("Reset App Settings"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Divider(thickness: 1.5),
            const SizedBox(height: 10),
            Text(
              "Security",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: ListTile(
                leading: Icon(Icons.lock, color: Colors.pink),
                title: Text("Manage PIN for Panic Diary"),
                trailing: Icon(Icons.arrow_forward_ios, size: 18),
                onTap: handlePinAction,
              ),
            ),
            const SizedBox(height: 30),
            Divider(thickness: 1.5),
            const SizedBox(height: 10),
            Text(
              "Legal & Sharing",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: ListTile(
                leading: Icon(Icons.privacy_tip, color: Colors.indigo),
                title: Text("Privacy Policy"),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PrivacyPolicyScreen(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: ListTile(
                leading: Icon(Icons.rule, color: Colors.deepPurple),
                title: Text("Terms and Conditions"),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TermsAndConditionsScreen(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: ListTile(
                leading: Icon(Icons.share, color: Colors.teal),
                title: Text("Share App"),
                onTap: _shareApp,
              ),
            ),
            const SizedBox(height: 30),
            Divider(thickness: 1.5),
            const SizedBox(height: 10),
            Text(
              "App info",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: ListTile(
                leading: Icon(Icons.feedback, color: Colors.teal),
                title: Text("App Feedback"),
                onTap: _sendFeedback,
              ),
            ),
            SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: ListTile(
                leading: Icon(Icons.data_usage, color: Colors.blueGrey),
                title: Text("How to use App"),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HowToUseApp(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: ListTile(
                leading: Icon(Icons.info_outline, color: Colors.blueGrey),
                title: Text("About App"),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutAppScreen()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
