// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   List<String> emergencyContacts = [];
//   String emergencyMessage =
//       "This is an emergency! I need help. Please call me ASAP!";
//   String safeMessage = "Hey, I'm safe now. No need to worry 😊";

//   @override
//   void initState() {
//     super.initState();
//     loadData();
//   }

//   Future<void> loadData() async {
//     final prefs = await SharedPreferences.getInstance();

//     final savedContacts = prefs.getStringList('emergencyContacts');
//     if (savedContacts != null) {
//       setState(() {
//         emergencyContacts =
//             savedContacts.map((item) => item.split('|')[1]).toList();
//       });
//     }

//     final msg = prefs.getString('emergencyMessage');
//     if (msg != null) {
//       setState(() {
//         emergencyMessage = msg;
//       });
//     }
//   }

//   void sendEmergencySMS() async {
//     if (emergencyContacts.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("No emergency contacts available")),
//       );
//       return;
//     }

//     final allNumbers = emergencyContacts.join(';');
//     final Uri uri = Uri.parse(
//         'sms:$allNumbers?body=${Uri.encodeComponent(emergencyMessage)}');

//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Could not open SMS app")),
//       );
//     }
//   }

//   void sendSafeSMS() async {
//     if (emergencyContacts.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("No emergency contacts available")),
//       );
//       return;
//     }

//     final allNumbers = emergencyContacts.join(';');
//     final Uri uri =
//         Uri.parse('sms:$allNumbers?body=${Uri.encodeComponent(safeMessage)}');

//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Could not open SMS app")),
//       );
//     }
//   }

//   void showCountdownDialog(BuildContext context) {
//     int countdown = 3;
//     bool cancelled = false;

//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) {
//         return StatefulBuilder(builder: (context, setState) {
//           Future.delayed(const Duration(seconds: 1), () {
//             if (!cancelled) {
//               if (countdown == 1) {
//                 Navigator.of(context).pop();
//                 sendEmergencySMS();
//               } else {
//                 setState(() {
//                   countdown--;
//                 });
//               }
//             }
//           });

//           return AlertDialog(
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//             title: Text("Confirm SOS"),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text("Sending SOS in $countdown seconds..."),
//                 const SizedBox(height: 10),
//                 LinearProgressIndicator(
//                   value: (4 - countdown) / 3,
//                   color: Colors.pink,
//                   backgroundColor: Colors.pink.shade100,
//                 ),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   cancelled = true;
//                   Navigator.of(context).pop();
//                 },
//                 child: Text("Cancel"),
//               ),
//             ],
//           );
//         });
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Colors.pink.shade100, Colors.purple.shade100],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 "You are not alone",
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 40),

//               // SOS Button
//               ElevatedButton(
//                 onPressed: () => showCountdownDialog(context),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.pink,
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 50, vertical: 20),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   elevation: 10,
//                 ),
//                 child: const Text(
//                   "SEND SOS",
//                   style: TextStyle(fontSize: 22, color: Colors.white),
//                 ),
//               ),

//               const SizedBox(height: 20),

//               // I’m Safe Button
//               ElevatedButton.icon(
//                 onPressed: sendSafeSMS,
//                 icon: Icon(Icons.check_circle_outline),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.green.shade400,
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 30, vertical: 15),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(25),
//                   ),
//                   elevation: 6,
//                 ),
//                 label: Text(
//                   "I'M SAFE",
//                   style: TextStyle(fontSize: 18, color: Colors.white),
//                 ),
//               ),

//               const SizedBox(height: 40),
//               Icon(Icons.shield, size: 100, color: Colors.pink.shade300),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }




//WITHOUT LOCATION INTEGRATION

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   List<Map<String, dynamic>> contactData = [];
//   String emergencyMessage =
//       "This is an emergency! I need help. Please call me ASAP!";
//   String safeMessage = "Hey, I'm safe now. No need to worry 😊";

//   @override
//   void initState() {
//     super.initState();
//     loadData();
//   }

//   Future<void> loadData() async {
//     final prefs = await SharedPreferences.getInstance();
//     final savedContacts = prefs.getStringList('emergencyContacts');
//     if (savedContacts != null) {
//       setState(() {
//         contactData = savedContacts.map((item) {
//           final parts = item.split('|');
//           return {
//             'name': parts[0],
//             'number': parts[1],
//             'priority': parts.length > 2 ? parts[2] == 'true' : false,
//           };
//         }).toList();
//       });
//     }

//     final msg = prefs.getString('emergencyMessage');
//     if (msg != null) {
//       setState(() {
//         emergencyMessage = msg;
//       });
//     }
//   }

//   void sendSMS(String number, String message) async {
//     final uri = Uri.parse('sms:$number?body=${Uri.encodeComponent(message)}');
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Could not open SMS app")),
//       );
//     }
//   }

//   void sendToAll(String message) async {
//     final allNumbers = contactData.map((e) => e['number']).join(';');
//     final uri = Uri.parse(
//       'sms:$allNumbers?body=${Uri.encodeComponent(message)}',
//     );
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Could not open SMS app")),
//       );
//     }
//   }

//   void sendToPriority(String message) async {
//     final priorityNumbers = contactData
//         .where((c) => c['priority'] == true)
//         .map((e) => e['number'])
//         .join(';');

//     if (priorityNumbers.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("No priority contacts found")),
//       );
//       return;
//     }

//     final uri = Uri.parse(
//       'sms:$priorityNumbers?body=${Uri.encodeComponent(message)}',
//     );
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Could not open SMS app")),
//       );
//     }
//   }

//   void showContactMessageOptions(String name, String number) {
//     showModalBottomSheet(
//       context: context,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
//       ),
//       builder: (_) => Padding(
//         padding: const EdgeInsets.all(20),
//         child: Wrap(
//           children: [
//             Center(
//               child: Text(
//                 "Send to $name",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ),
//             const SizedBox(height: 15),
//             ListTile(
//               leading: Icon(Icons.warning_amber, color: Colors.red),
//               title: Text("Send SOS"),
//               onTap: () {
//                 Navigator.pop(context);
//                 sendSMS(number, emergencyMessage);
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.check_circle, color: Colors.green),
//               title: Text("Send I'm Safe"),
//               onTap: () {
//                 Navigator.pop(context);
//                 sendSMS(number, safeMessage);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void showSOSChoiceDialog() {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: Text("Send SOS To"),
//         content: Text("Choose who you want to send SOS to:"),
//         actions: [
//           TextButton(
//             child: Text("Priority Contacts"),
//             onPressed: () {
//               Navigator.pop(context);
//               showCountdownDialog(priorityOnly: true);
//             },
//           ),
//           TextButton(
//             child: Text("All Contacts"),
//             onPressed: () {
//               Navigator.pop(context);
//               showCountdownDialog(priorityOnly: false);
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   void showCountdownDialog({required bool priorityOnly}) {
//     int countdown = 3;
//     bool cancelled = false;

//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => StatefulBuilder(
//         builder: (context, setState) {
//           Future.delayed(const Duration(seconds: 1), () {
//             if (!cancelled) {
//               if (countdown == 1) {
//                 Navigator.of(context).pop();
//                 if (priorityOnly) {
//                   sendToPriority(emergencyMessage);
//                 } else {
//                   sendToAll(emergencyMessage);
//                 }
//               } else {
//                 setState(() {
//                   countdown--;
//                 });
//               }
//             }
//           });

//           return AlertDialog(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(15),
//             ),
//             title: Text("Confirm SOS"),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text("Sending SOS in $countdown seconds..."),
//                 const SizedBox(height: 10),
//                 LinearProgressIndicator(
//                   value: (4 - countdown) / 3,
//                   color: Colors.pink,
//                   backgroundColor: Colors.pink.shade100,
//                 ),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   cancelled = true;
//                   Navigator.of(context).pop();
//                 },
//                 child: Text("Cancel"),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Colors.pink.shade100, Colors.purple.shade100],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         appBar: AppBar(
//           title: Text("SafeZone"),
//           backgroundColor: Colors.pinkAccent,
//           elevation: 5,
//           centerTitle: true,
//         ),
//         body: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               if (contactData.isNotEmpty) ...[
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 12,
//                     vertical: 10,
//                   ),
//                   margin: const EdgeInsets.only(bottom: 20),
//                   decoration: BoxDecoration(
//                     color: const Color.fromARGB(255, 236, 229, 229).withOpacity(0.9),
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black26,
//                         blurRadius: 6,
//                         offset: Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: SizedBox(
//                     height: 90,
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: contactData.length,
//                       itemBuilder: (context, index) {
//                         final contact = contactData[index];
//                         return GestureDetector(
//                           onTap: () => showContactMessageOptions(
//                             contact['name'],
//                             contact['number'],
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 10),
//                             child: Column(
//                               children: [
//                                 CircleAvatar(
//                                   radius: 28,
//                                   backgroundColor: Colors.pink.shade300,
//                                   child: Icon(
//                                     Icons.person,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 5),
//                                 Text(
//                                   contact['name'],
//                                   style: TextStyle(fontWeight: FontWeight.w500),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ],

//               const SizedBox(height: 40),
//               Center(
//                 child: Text(
//                   "You are not alone",
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               const SizedBox(height: 30),

//               Center(
//                 child: ElevatedButton(
//                   onPressed: showSOSChoiceDialog,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.pink,
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 50,
//                       vertical: 20,
//                     ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     elevation: 10,
//                   ),
//                   child: const Text(
//                     "SEND SOS",
//                     style: TextStyle(fontSize: 22, color: Colors.white),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 20),

//               Center(
//                 child: ElevatedButton.icon(
//                   onPressed: () => sendToAll(safeMessage),
//                   icon: Icon(Icons.check_circle_outline),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green.shade400,
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 30,
//                       vertical: 15,
//                     ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                     elevation: 6,
//                   ),
//                   label: Text(
//                     "I'M SAFE",
//                     style: TextStyle(fontSize: 18, color: Colors.white),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 30),
//               Center(
//                 child: Icon(
//                   Icons.shield,
//                   size: 100,
//                   color: Colors.pink.shade300,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }




//WITH LOCATION INTEGRATION
// This code integrates location services to send the user's current location along with the emergency message.
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:geolocator/geolocator.dart';

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   List<Map<String, dynamic>> contactData = [];
//   String emergencyMessage =
//       "This is an emergency! I need help. Please call me ASAP!";
//   String safeMessage = "Hey, I'm safe now. No need to worry 😊";

//   @override
//   void initState() {
//     super.initState();
//     loadData();
//   }

//   Future<void> loadData() async {
//     final prefs = await SharedPreferences.getInstance();
//     final savedContacts = prefs.getStringList('emergencyContacts');
//     if (savedContacts != null) {
//       setState(() {
//         contactData = savedContacts.map((item) {
//           final parts = item.split('|');
//           return {
//             'name': parts[0],
//             'number': parts[1],
//             'priority': parts.length > 2 ? parts[2] == 'true' : false,
//           };
//         }).toList();
//       });
//     }

//     final msg = prefs.getString('emergencyMessage');
//     if (msg != null) {
//       setState(() {
//         emergencyMessage = msg;
//       });
//     }
//   }

//   Future<String> getCurrentLocationLink() async {
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) return "";

//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.deniedForever ||
//           permission == LocationPermission.denied) {
//         return "";
//       }
//     }

//     Position position = await Geolocator.getCurrentPosition();
//     return "https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}";
//   }



//   void sendSMS(String number, String message) async {
//     final uri = Uri.parse('sms:$number?body=${Uri.encodeComponent(message)}');
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     } else {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text("Could not open SMS app")));
//     }
//   }

//   void sendToAll(String message) async {
//     final locationLink = await getCurrentLocationLink();
//     final finalMessage = "$message\n\nMy Location: $locationLink";

//     final allNumbers = contactData.map((e) => e['number']).join(';');
//     final uri = Uri.parse(
//       'sms:$allNumbers?body=${Uri.encodeComponent(finalMessage)}',
//     );
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     } else {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text("Could not open SMS app")));
//     }
//   }

//   void sendToPriority(String message) async {
//     final locationLink = await getCurrentLocationLink();
//     final finalMessage = "$message\n\nMy Location: $locationLink";

//     final priorityNumbers = contactData
//         .where((c) => c['priority'] == true)
//         .map((e) => e['number'])
//         .join(';');

//     if (priorityNumbers.isEmpty) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text("No priority contacts found")));
//       return;
//     }

//     final uri = Uri.parse(
//       'sms:$priorityNumbers?body=${Uri.encodeComponent(finalMessage)}',
//     );
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     } else {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text("Could not open SMS app")));
//     }
//   }

//   void showContactMessageOptions(String name, String number) {
//     showModalBottomSheet(
//       context: context,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
//       ),
//       builder: (_) => Padding(
//         padding: const EdgeInsets.all(20),
//         child: Wrap(
//           children: [
//             Center(
//               child: Text(
//                 "Send to $name",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ),
//             const SizedBox(height: 15),
//             ListTile(
//               leading: Icon(Icons.warning_amber, color: Colors.red),
//               title: Text("Send SOS"),
//               onTap: () {
//                 Navigator.pop(context);
//                 sendSMS(number, emergencyMessage);
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.check_circle, color: Colors.green),
//               title: Text("Send I'm Safe"),
//               onTap: () {
//                 Navigator.pop(context);
//                 sendSMS(number, safeMessage);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void showSOSChoiceDialog() {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: Text("Send SOS To"),
//         content: Text("Choose who you want to send SOS to:"),
//         actions: [
//           TextButton(
//             child: Text("Priority Contacts"),
//             onPressed: () {
//               Navigator.pop(context);
//               showCountdownDialog(priorityOnly: true);
//             },
//           ),
//           TextButton(
//             child: Text("All Contacts"),
//             onPressed: () {
//               Navigator.pop(context);
//               showCountdownDialog(priorityOnly: false);
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   void showCountdownDialog({required bool priorityOnly}) {
//     int countdown = 3;
//     bool cancelled = false;

//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => StatefulBuilder(
//         builder: (context, setState) {
//           Future.delayed(const Duration(seconds: 1), () {
//             if (!cancelled) {
//               if (countdown == 1) {
//                 Navigator.of(context).pop();
//                 if (priorityOnly) {
//                   sendToPriority(emergencyMessage);
//                 } else {
//                   sendToAll(emergencyMessage);
//                 }
//               } else {
//                 setState(() {
//                   countdown--;
//                 });
//               }
//             }
//           });

//           return AlertDialog(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(15),
//             ),
//             title: Text("Confirm SOS"),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text("Sending SOS in $countdown seconds..."),
//                 const SizedBox(height: 10),
//                 LinearProgressIndicator(
//                   value: (4 - countdown) / 3,
//                   color: Colors.pink,
//                   backgroundColor: Colors.pink.shade100,
//                 ),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   cancelled = true;
//                   Navigator.of(context).pop();
//                 },
//                 child: Text("Cancel"),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Colors.pink.shade100, Colors.purple.shade100],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         appBar: AppBar(
//           title: Text("SafeZone"),
//           backgroundColor: Colors.pinkAccent,
//           elevation: 5,
//           centerTitle: true,
//         ),
//         body: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               if (contactData.isNotEmpty) ...[
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 12,
//                     vertical: 10,
//                   ),
//                   margin: const EdgeInsets.only(bottom: 20),
//                   decoration: BoxDecoration(
//                     color: const Color.fromARGB(
//                       255,
//                       236,
//                       229,
//                       229,
//                     ).withOpacity(0.9),
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black26,
//                         blurRadius: 6,
//                         offset: Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: SizedBox(
//                     height: 90,
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: contactData.length,
//                       itemBuilder: (context, index) {
//                         final contact = contactData[index];
//                         return GestureDetector(
//                           onTap: () => showContactMessageOptions(
//                             contact['name'],
//                             contact['number'],
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 10),
//                             child: Column(
//                               children: [
//                                 CircleAvatar(
//                                   radius: 28,
//                                   backgroundColor: Colors.pink.shade300,
//                                   child: Icon(
//                                     Icons.person,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 5),
//                                 Text(
//                                   contact['name'],
//                                   style: TextStyle(fontWeight: FontWeight.w500),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ],

//               const SizedBox(height: 40),
//               Center(
//                 child: Text(
//                   "You are not alone",
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               const SizedBox(height: 30),

//               Center(
//                 child: ElevatedButton(
//                   onPressed: showSOSChoiceDialog,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.pink,
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 50,
//                       vertical: 20,
//                     ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     elevation: 10,
//                   ),
//                   child: const Text(
//                     "SEND SOS",
//                     style: TextStyle(fontSize: 22, color: Colors.white),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 20),

//               Center(
//                 child: ElevatedButton.icon(
//                   onPressed: () => sendToAll(safeMessage),
//                   icon: Icon(Icons.check_circle_outline),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green.shade400,
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 30,
//                       vertical: 15,
//                     ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                     elevation: 6,
//                   ),
//                   label: Text(
//                     "I'M SAFE",
//                     style: TextStyle(fontSize: 18, color: Colors.white),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 30),
//               Center(
//                 child: Icon(
//                   Icons.shield,
//                   size: 100,
//                   color: Colors.pink.shade300,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }





//ADDED SHAKE DETECTION ALSO WITH LOCATION INTEGRATION
// This code integrates location services and shake detection to send the user's current location along with the emergency
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:shake/shake.dart'; // ✅ NEW IMPORT

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   List<Map<String, dynamic>> contactData = [];
//   String emergencyMessage =
//       "This is an emergency! I need help. Please call me ASAP!";
//   String safeMessage = "Hey, I'm safe now. No need to worry 😊";
//   ShakeDetector? _shakeDetector; // ✅ NEW VARIABLE

//   @override
//   void initState() {
//     super.initState();
//      // ✅ Request SMS permission
//     loadData();

//     //✅ ShakeDetector setup
//     _shakeDetector = ShakeDetector.autoStart(
//       shakeThresholdGravity: 2.7,
//       onPhoneShake: (count) {
//         showCountdownDialog(priorityOnly: false);
//        // sendSmsInBackground; // silent sos send with location
//       },
//       );
// //     _shakeDetector = ShakeDetector.autoStart(
// //   shakeThresholdGravity: 2.7,
// //   onPhoneShake: (count) async {
// //     print("Phone shaken $count times");
// //     final locationLink = await getCurrentLocationLink();
// //     final finalMessage =
// //         "$emergencyMessage\n\nMy Location: $locationLink";

// //     // Send to all contacts silently
// //     for (var contact in contactData) {
// //       await sendSmsInBackground(contact['number'], finalMessage);
// //     }
// //   },
// // );
//   }

//   @override
//   void dispose() {// ✅ Request SMS permission
//     _shakeDetector?.stopListening(); // ✅ Dispose listener
//     super.dispose();
//   }

//   Future<void> loadData() async {
//     final prefs = await SharedPreferences.getInstance();
//     final savedContacts = prefs.getStringList('emergencyContacts');
//     if (savedContacts != null) {
//       setState(() {
//         contactData = savedContacts.map((item) {
//           final parts = item.split('|');
//           return {
//             'name': parts[0],
//             'number': parts[1],
//             'priority': parts.length > 2 ? parts[2] == 'true' : false,
//           };
//         }).toList();
//       });
//     }

//     final msg = prefs.getString('emergencyMessage');
//     if (msg != null) {
//       setState(() {
//         emergencyMessage = msg;
//       });
//     }
//   }

//   Future<String> getCurrentLocationLink() async {
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) return "";

//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.deniedForever || permission == LocationPermission.denied) {
//         return "";
//       }
//     }

//     Position position = await Geolocator.getCurrentPosition();
//     return "https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}";
//   }

//   //for silently send sms in backgroud
// //    Future<void> sendSmsInBackground(String number, String message) async {
// //   const platform = MethodChannel('com.safe_her_app.sms/send');

// //   try {
// //     final result = await platform.invokeMethod('sendSmsInBackground', {
// //       'number': number,
// //       'message': message,
// //     });
// //     print("SMS Result: $result");
// //   } on PlatformException catch (e) {
// //     print("Failed to send SMS: ${e.message}");
// //   }
// // }


// // Future<void> sendSmsInBackground(String number, String message) async {
// //   const platform = MethodChannel('com.safe_her_app/sms'); // ✅ Match this exactly

// //   try {
// //     final result = await platform.invokeMethod('sendSMSInBackground', {
// //       'phoneNumbers': number, // ✅ Key must match Kotlin side ("phoneNumbers")
// //       'message': message,
// //     });
// //     print("SMS Result: $result");
// //   } on PlatformException catch (e) {
// //     print("Failed to send SMS: ${e.message}");
// //   }
// // }


//    void sendSMS(String number, String message) async {
//     final uri = Uri.parse('sms:$number?body=${Uri.encodeComponent(message)}');
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     } else {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text("Could not open SMS app")));
//     }
//   }

//   void sendToAll(String message) async {
//     final locationLink = await getCurrentLocationLink();
//     final finalMessage = "$message\n\nMy Location: $locationLink";

//     final allNumbers = contactData.map((e) => e['number']).join(';');
//     final uri = Uri.parse(
//       'sms:$allNumbers?body=${Uri.encodeComponent(finalMessage)}',
//     );
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     } else {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text("Could not open SMS app")));
//     }
//   }

//   void sendToPriority(String message) async {
//     final locationLink = await getCurrentLocationLink();
//     final finalMessage = "$message\n\nMy Location: $locationLink";

//     final priorityNumbers = contactData
//         .where((c) => c['priority'] == true)
//         .map((e) => e['number'])
//         .join(';');

//     if (priorityNumbers.isEmpty) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text("No priority contacts found")));
//       return;
//     }

//     final uri = Uri.parse(
//       'sms:$priorityNumbers?body=${Uri.encodeComponent(finalMessage)}',
//     );
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     } else {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text("Could not open SMS app")));
//     }
//   }

//   void showContactMessageOptions(String name, String number) {
//     showModalBottomSheet(
//       context: context,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
//       ),
//       builder: (_) => Padding(
//         padding: const EdgeInsets.all(20),
//         child: Wrap(
//           children: [
//             Center(
//               child: Text(
//                 "Send to $name",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ),
//             const SizedBox(height: 15),
//             ListTile(
//               leading: Icon(Icons.warning_amber, color: Colors.red),
//               title: Text("Send SOS"),
//               onTap: () {
//                 Navigator.pop(context);
//                 sendSMS(number, emergencyMessage);
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.check_circle, color: Colors.green),
//               title: Text("Send I'm Safe"),
//               onTap: () {
//                 Navigator.pop(context);
//                 sendSMS(number, safeMessage);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void showSOSChoiceDialog() {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: Text("Send SOS To"),
//         content: Text("Choose who you want to send SOS to:"),
//         actions: [
//           TextButton(
//             child: Text("Priority Contacts"),
//             onPressed: () {
//               Navigator.pop(context);
//               showCountdownDialog(priorityOnly: true);
//             },
//           ),
//           TextButton(
//             child: Text("All Contacts"),
//             onPressed: () {
//               Navigator.pop(context);
//               showCountdownDialog(priorityOnly: false);
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   void showCountdownDialog({required bool priorityOnly}) {
//     int countdown = 3;
//     bool cancelled = false;

//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => StatefulBuilder(
//         builder: (context, setState) {
//           Future.delayed(const Duration(seconds: 1), () {
//             if (!cancelled) {
//               if (countdown == 1) {
//                 Navigator.of(context).pop();
//                 if (priorityOnly) {
//                   sendToPriority(emergencyMessage);
//                 } else {
//                   sendToAll(emergencyMessage);
//                 }
//               } else {
//                 setState(() {
//                   countdown--;
//                 });
//               }
//             }
//           });

//           return AlertDialog(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(15),
//             ),
//             title: Text("Confirm SOS"),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text("Sending SOS in $countdown seconds..."),
//                 const SizedBox(height: 10),
//                 LinearProgressIndicator(
//                   value: (4 - countdown) / 3,
//                   color: Colors.pink,
//                   backgroundColor: Colors.pink.shade100,
//                 ),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   cancelled = true;
//                   Navigator.of(context).pop();
//                 },
//                 child: Text("Cancel"),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Colors.pink.shade100, Colors.purple.shade100],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         appBar: AppBar(
//           title: Text("SafeZone"),
//           backgroundColor: Colors.pinkAccent,
//           elevation: 5,
//           centerTitle: true,
//         ),
//         body: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               if (contactData.isNotEmpty) ...[
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 12,
//                     vertical: 10,
//                   ),
//                   margin: const EdgeInsets.only(bottom: 20),
//                   decoration: BoxDecoration(
//                     color: const Color.fromARGB(
//                       255,
//                       236,
//                       229,
//                       229,
//                     ).withOpacity(0.9),
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black26,
//                         blurRadius: 6,
//                         offset: Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: SizedBox(
//                     height: 90,
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: contactData.length,
//                       itemBuilder: (context, index) {
//                         final contact = contactData[index];
//                         return GestureDetector(
//                           onTap: () => showContactMessageOptions(
//                             contact['name'],
//                             contact['number'],
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 10),
//                             child: Column(
//                               children: [
//                                 CircleAvatar(
//                                   radius: 28,
//                                   backgroundColor: Colors.pink.shade300,
//                                   child: Icon(
//                                     Icons.person,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 5),
//                                 Text(
//                                   contact['name'],
//                                   style: TextStyle(fontWeight: FontWeight.w500),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ],

//               const SizedBox(height: 40),
//               Center(
//                 child: Text(
//                   "You are not alone",
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               const SizedBox(height: 30),

//               Center(
//                 child: ElevatedButton(
//                   onPressed: showSOSChoiceDialog,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.pink,
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 50,
//                       vertical: 20,
//                     ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     elevation: 10,
//                   ),
//                   child: const Text(
//                     "SEND SOS",
//                     style: TextStyle(fontSize: 22, color: Colors.white),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 20),

//               Center(
//                 child: ElevatedButton.icon(
//                   onPressed: () => sendToAll(safeMessage),
//                   icon: Icon(Icons.check_circle_outline),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green.shade400,
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 30,
//                       vertical: 15,
//                     ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                     elevation: 6,
//                   ),
//                   label: Text(
//                     "I'M SAFE",
//                     style: TextStyle(fontSize: 18, color: Colors.white),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 30),
//               Center(
//                 child: Icon(
//                   Icons.shield,
//                   size: 100,
//                   color: Colors.pink.shade300,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }




//this and above last commented code is same  

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:safe_her_app/screens/otherscreens/contact_dev.dart';
// import 'package:safe_her_app/screens/profile_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:shake/shake.dart'; // ✅ NEW IMPORT

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   List<Map<String, dynamic>> contactData = [];
//   String emergencyMessage =
//       "This is an emergency! I need help. Please call me ASAP!";
//   String safeMessage = "Hey, I'm safe now. No need to worry 😊";
//   ShakeDetector? _shakeDetector; // ✅ NEW VARIABLE

//   @override
//   void initState() {
//     super.initState();
//     // ✅ Request SMS permission
//     loadData();

//     //✅ ShakeDetector setup
//     _shakeDetector = ShakeDetector.autoStart(
//       shakeThresholdGravity: 2.7,
//       onPhoneShake: (count) {
//         showCountdownDialog(priorityOnly: false);
//         // sendSmsInBackground; // silent sos send with location
//       },
//     );
//   }

//   @override
//   void dispose() {
//     // ✅ Request SMS permission
//     _shakeDetector?.stopListening(); // ✅ Dispose listener
//     super.dispose();
//   }

//   Future<void> loadData() async {
//     final prefs = await SharedPreferences.getInstance();
//     final savedContacts = prefs.getStringList('emergencyContacts');
//     if (savedContacts != null) {
//       setState(() {
//         contactData = savedContacts.map((item) {
//           final parts = item.split('|');
//           return {
//             'name': parts[0],
//             'number': parts[1],
//             'priority': parts.length > 2 ? parts[2] == 'true' : false,
//           };
//         }).toList();
//       });
//     }

//     final msg = prefs.getString('emergencyMessage');
//     if (msg != null) {
//       setState(() {
//         emergencyMessage = msg;
//       });
//     }
//   }

//   // ✅ UPDATED to place a marker in Google Maps
//   Future<String> getCurrentLocationLink() async {
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) return "";

//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.deniedForever ||
//           permission == LocationPermission.denied) {
//         return "";
//       }
//     }

//     Position position = await Geolocator.getCurrentPosition();
//     return 
//     //"https://www.google.com/maps?q=33.123456,73.987654";
//     "https://www.google.com/maps?q=${position.latitude},${position.longitude}";
//   }

//   // for silently send sms in background
//   // Future<void> sendSmsInBackground(String number, String message) async {
//   // const platform = MethodChannel('com.safe_her_app.sms/send');
//   // try {
//   //   final result = await platform.invokeMethod('sendSmsInBackground', {
//   //     'number': number,
//   //     'message': message,
//   //   });
//   //   print("SMS Result: $result");
//   // } on PlatformException catch (e) {
//   //   print("Failed to send SMS: ${e.message}");
//   // }
//   // }

//   // Future<void> sendSmsInBackground(String number, String message) async {
//   // const platform = MethodChannel('com.safe_her_app/sms');
//   // try {
//   //   final result = await platform.invokeMethod('sendSMSInBackground', {
//   //     'phoneNumbers': number,
//   //     'message': message,
//   //   });
//   //   print("SMS Result: $result");
//   // } on PlatformException catch (e) {
//   //   print("Failed to send SMS: ${e.message}");
//   // }
//   // }

//   void sendSMS(String number, String message) async {
//     final uri = Uri.parse('sms:$number?body=${Uri.encodeComponent(message)}');
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     } else {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text("Could not open SMS app")));
//     }
//   }

//   void sendToAll(String message) async {
//     final locationLink = await getCurrentLocationLink();
//     final finalMessage = "$message\n\nMy Location: $locationLink";

//     final allNumbers = contactData.map((e) => e['number']).join(';');
//     final uri = Uri.parse(
//       'sms:$allNumbers?body=${Uri.encodeComponent(finalMessage)}',
//     );
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     } else {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text("Could not open SMS app")));
//     }
//   }

//   void sendToPriority(String message) async {
//     final locationLink = await getCurrentLocationLink();
//     final finalMessage = "$message\n\nMy Location: $locationLink";

//     final priorityNumbers = contactData
//         .where((c) => c['priority'] == true)
//         .map((e) => e['number'])
//         .join(';');

//     if (priorityNumbers.isEmpty) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text("No priority contacts found")));
//       return;
//     }

//     final uri = Uri.parse(
//       'sms:$priorityNumbers?body=${Uri.encodeComponent(finalMessage)}',
//     );
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     } else {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text("Could not open SMS app")));
//     }
//   }

//   void showContactMessageOptions(String name, String number) {
//   showModalBottomSheet(
//     context: context,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
//     ),
//     builder: (_) => Padding(
//       padding: const EdgeInsets.all(20),
//       child: Wrap(
//         children: [
//           Center(
//             child: Text(
//               "Send to $name",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//           ),
//           const SizedBox(height: 15),
//           ListTile(
//             leading: Icon(Icons.warning_amber, color: Colors.red),
//             title: Text("Send SOS"),
//             onTap: () async {
//               Navigator.pop(context);
//               final locationLink = await getCurrentLocationLink();
//               final fullMessage = "$emergencyMessage\n\nMy Location: $locationLink";
//               sendSMS(number, fullMessage);
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.check_circle, color: Colors.green),
//             title: Text("Send I'm Safe"),
//             onTap: () async {
//               Navigator.pop(context);
//               final locationLink = await getCurrentLocationLink();
//               final fullMessage = "$safeMessage\n\nMy Location: $locationLink";
//               sendSMS(number, fullMessage);
//             },
//           ),
//         ],
//       ),
//     ),
//   );
// }

//   void showSOSChoiceDialog() {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: Text("Send SOS To"),
//         content: Text("Choose who you want to send SOS to:"),
//         actions: [
//           TextButton(
//             child: Text("Priority Contacts"),
//             onPressed: () {
//               Navigator.pop(context);
//               showCountdownDialog(priorityOnly: true);
//             },
//           ),
//           TextButton(
//             child: Text("All Contacts"),
//             onPressed: () {
//               Navigator.pop(context);
//               showCountdownDialog(priorityOnly: false);
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   void showCountdownDialog({required bool priorityOnly}) {
//     int countdown = 3;
//     bool cancelled = false;

//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => StatefulBuilder(
//         builder: (context, setState) {
//           Future.delayed(const Duration(seconds: 1), () {
//             if (!cancelled) {
//               if (countdown == 1) {
//                 Navigator.of(context).pop();
//                 if (priorityOnly) {
//                   sendToPriority(emergencyMessage);
//                 } else {
//                   sendToAll(emergencyMessage);
//                 }
//               } else {
//                 setState(() {
//                   countdown--;
//                 });
//               }
//             }
//           });

//           return AlertDialog(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(15),
//             ),
//             title: Text("Confirm SOS"),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text("Sending SOS in $countdown seconds..."),
//                 const SizedBox(height: 10),
//                 LinearProgressIndicator(
//                   value: (4 - countdown) / 3,
//                   color: Colors.pink,
//                   backgroundColor: Colors.pink.shade100,
//                 ),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   cancelled = true;
//                   Navigator.of(context).pop();
//                 },
//                 child: Text("Cancel"),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Colors.pink.shade100, Colors.purple.shade100],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         appBar: AppBar(
//           title: Text("SafeZone"),
//           backgroundColor: Colors.pinkAccent,
//           elevation: 5,
//           centerTitle: true,
//           actions: [
//             Row(
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.contact_support),
//                   onPressed: () {
//                     Navigator.push(context, MaterialPageRoute(
//                       builder: (context) => ContactDeveloperScreen(),
//                     ));
//                   },
//                 ),SizedBox(width: 5),
//                 IconButton(
//                   icon: Icon(Icons.person),
//                   onPressed: () {
//                     Navigator.push(context, MaterialPageRoute(
//                       builder: (context) => ProfileScreen(),
//                     ));
//                   },
//                 ),
                
//               ],
//             ),
//           ],
//         ),
//         body: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               if (contactData.isNotEmpty) ...[
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 12,
//                     vertical: 10,
//                   ),
//                   margin: const EdgeInsets.only(bottom: 20),
//                   decoration: BoxDecoration(
//                     color: const Color.fromARGB(
//                       255,
//                       236,
//                       229,
//                       229,
//                     ).withOpacity(0.9),
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black26,
//                         blurRadius: 6,
//                         offset: Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: SizedBox(
//                     height: 90,
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: contactData.length,
//                       itemBuilder: (context, index) {
//                         final contact = contactData[index];
//                         return GestureDetector(
//                           onTap: () => showContactMessageOptions(
//                             contact['name'],
//                             contact['number'],
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 10),
//                             child: Column(
//                               children: [
//                                 CircleAvatar(
//                                   radius: 28,
//                                   backgroundColor: Colors.pink.shade300,
//                                   child: Icon(
//                                     Icons.person,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 5),
//                                 Text(
//                                   contact['name'],
//                                   style: TextStyle(fontWeight: FontWeight.w500),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ],

//               const SizedBox(height: 40),
//               Center(
//                 child: Text(
//                   "You are not alone",
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               const SizedBox(height: 30),

//               Center(
//                 child: ElevatedButton(
//                   onPressed: showSOSChoiceDialog,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.pink,
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 50,
//                       vertical: 20,
//                     ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     elevation: 10,
//                   ),
//                   child: const Text(
//                     "SEND SOS",
//                     style: TextStyle(fontSize: 22, color: Colors.white),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 20),

//               Center(
//                 child: ElevatedButton.icon(
//                   onPressed: () => sendToAll(safeMessage),
//                   icon: Icon(Icons.check_circle_outline),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green.shade400,
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 30,
//                       vertical: 15,
//                     ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                     elevation: 6,
//                   ),
//                   label: Text(
//                     "I'M SAFE",
//                     style: TextStyle(fontSize: 18, color: Colors.white),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 30),
//               Center(
//                 child: Icon(
//                   Icons.shield,
//                   size: 100,
//                   color: Colors.pink.shade300,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shake/shake.dart';
import 'package:safe_her_app/screens/otherscreens/contact_dev.dart';
import 'package:safe_her_app/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> contactData = [];
  String emergencyMessage = "This is an emergency! I need help. Please call me ASAP!";
  String safeMessage = "Hey, I'm safe now. No need to worry 😊";
  ShakeDetector? _shakeDetector;
  // bool _dialogShown = false;

  @override
  void initState() {
    super.initState();
    loadData();
    // showHelperDialog();

    _shakeDetector = ShakeDetector.autoStart(
      shakeThresholdGravity: 2.7,
      onPhoneShake: (count) {
        showCountdownDialog(priorityOnly: false);
      },
    );
  }

  @override
  void dispose() {
    _shakeDetector?.stopListening();
    super.dispose();
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final savedContacts = prefs.getStringList('emergencyContacts');
    if (savedContacts != null) {
      setState(() {
        contactData = savedContacts.map((item) {
          final parts = item.split('|');
          return {
            'name': parts[0],
            'number': parts[1],
            'priority': parts.length > 2 ? parts[2] == 'true' : false,
          };
        }).toList();
      });
    }

    final msg = prefs.getString('emergencyMessage');
    if (msg != null) emergencyMessage = msg;
  }

  // Future<void> showHelperDialog() async {
  //   if (_dialogShown) return;
  //   _dialogShown = true;
  //   await Future.delayed(Duration(milliseconds: 300));

  //   if(!mounted) return;

  //   showDialog(
  //     context: context,
  //     builder: (_) => AlertDialog(
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  //       title: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Text("Helpful Tip"),
  //           IconButton(
  //             icon: Icon(Icons.close),
  //             onPressed: () => Navigator.pop(context),
  //           ),
  //         ],
  //       ),
  //       content: Text("\n⚠ On some devices, if the SMS app doesn’t open:\n\n• Make sure a default SMS app is set in your phone settings.\n• Grant SMS permissions from setting.\n• If the issue continues, try installing Google Messages from Play Store."),
  //     ),
  //   );
  // }

  Future<String> getCurrentLocationLink() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return "";

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        return "";
      }
    }

    final pos = await Geolocator.getCurrentPosition();
    return "https://www.google.com/maps?q=${pos.latitude},${pos.longitude}";
  }

  void sendSMS(String number, String message) async {
    final uri = Uri.parse('sms:$number?body=${Uri.encodeComponent(message)}');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Could not open SMS app")),
      );
    }
  }

  void sendToAll(String message) async {
    final locationLink = await getCurrentLocationLink();
    final finalMessage = "$message\n\nMy Location: $locationLink";
    final numbers = contactData.map((e) => e['number']).join(';');

    final uri = Uri.parse('sms:$numbers?body=${Uri.encodeComponent(finalMessage)}');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Could not open SMS app")),
      );
    }
  }

  void sendToPriority(String message) async {
    final locationLink = await getCurrentLocationLink();
    final finalMessage = "$message\n\nMy Location: $locationLink";
    final numbers = contactData.where((e) => e['priority'] == true).map((e) => e['number']).join(';');

    if (numbers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No priority contacts found")),
      );
      return;
    }

    final uri = Uri.parse('sms:$numbers?body=${Uri.encodeComponent(finalMessage)}');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Could not open SMS app")),
      );
    }
  }

  void showContactMessageOptions(String name, String number) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(18))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Wrap(
          children: [
            Center(
              child: Text("Send to $name", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            ListTile(
              leading: Icon(Icons.warning_amber, color: Colors.red),
              title: Text("Send SOS"),
              onTap: () async {
                Navigator.pop(context);
                final link = await getCurrentLocationLink();
                final msg = "$emergencyMessage\n\nMy Location: $link";
                sendSMS(number, msg);
              },
            ),
            ListTile(
              leading: Icon(Icons.check_circle, color: Colors.green),
              title: Text("Send I'm Safe"),
              onTap: () async {
                Navigator.pop(context);
                final link = await getCurrentLocationLink();
                final msg = "$safeMessage\n\nMy Location: $link";
                sendSMS(number, msg);
              },
            ),
          ],
        ),
      ),
    );
  }

  void showCountdownDialog({required bool priorityOnly}) {
    int countdown = 3;
    bool cancelled = false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => StatefulBuilder(
        builder: (context, setState) {
          Future.delayed(Duration(seconds: 1), () {
            if (!cancelled) {
              if (countdown == 1) {
                Navigator.of(context).pop();
                priorityOnly ? sendToPriority(emergencyMessage) : sendToAll(emergencyMessage);
              } else {
                setState(() => countdown--);
              }
            }
          });

          return AlertDialog(
            title: Text("Confirm SOS"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Sending SOS in $countdown seconds..."),
                SizedBox(height: 10),
                LinearProgressIndicator(
                  value: (4 - countdown) / 3,
                  color: Colors.pink,
                  backgroundColor: Colors.pink.shade100,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  cancelled = true;
                  Navigator.of(context).pop();
                },
                child: Text("Cancel"),
              ),
            ],
          );
        },
      ),
    );
  }

  void showSOSChoiceDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Send SOS To"),
        content: Text("Choose who you want to send SOS to:"),
        actions: [
          TextButton(
            child: Text("Priority Contacts"),
            onPressed: () {
              Navigator.pop(context);
              showCountdownDialog(priorityOnly: true);
            },
          ),
          TextButton(
            child: Text("All Contacts"),
            onPressed: () {
              Navigator.pop(context);
              showCountdownDialog(priorityOnly: false);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.pink.shade100, Colors.purple.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("SafeZone"),
          backgroundColor: Colors.pinkAccent,
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.contact_support),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ContactDeveloperScreen())),
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileScreen())),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              if (contactData.isNotEmpty)
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)],
                  ),
                  child: SizedBox(
                    height: 90,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: contactData.length,
                      itemBuilder: (_, i) {
                        final contact = contactData[i];
                        return GestureDetector(
                          onTap: () => showContactMessageOptions(contact['name'], contact['number']),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                CircleAvatar(radius: 28, backgroundColor: Colors.pink.shade300, child: Icon(Icons.person, color: Colors.white)),
                                SizedBox(height: 5),
                                Text(contact['name'], style: TextStyle(fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              SizedBox(height: 40),
              Center(child: Text("You are not alone", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: showSOSChoiceDialog,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: Text("SEND SOS", style: TextStyle(fontSize: 22, color: Colors.white)),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () => sendToAll(safeMessage),
                icon: Icon(Icons.check_circle_outline),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade400,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                ),
                label: Text("I'M SAFE", style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
              SizedBox(height: 30),
              Icon(Icons.shield, size: 100, color: Colors.pink.shade300),
            ],
          ),
        ),
      ),
    );
  }
}