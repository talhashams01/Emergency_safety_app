// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class PanicJournalScreen extends StatefulWidget {
//   @override
//   _PanicJournalScreenState createState() => _PanicJournalScreenState();
// }

// class _PanicJournalScreenState extends State<PanicJournalScreen> {
//   final TextEditingController _controller = TextEditingController();
//   List<String> _entries = [];
//   String selectedMood = "😊"; // Default mood

//   final List<String> moods = ["😊", "😔", "😡", "😨", "😰"];

//   @override
//   void initState() {
//     super.initState();
//     loadEntries();
//   }

//   Future<void> loadEntries() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _entries = prefs.getStringList('panic_entries') ?? [];
//     });
//   }

//   Future<void> saveEntry() async {
//     final text = _controller.text.trim();
//     if (text.isNotEmpty) {
//       final timestamp =
//           DateTime.now().toLocal().toString().split('.')[0]; // clean time
//       final entry = "$timestamp|$selectedMood|$text";
//       setState(() {
//         _entries.insert(0, entry);
//         _controller.clear();
//         selectedMood = "😊"; // Reset mood
//       });
//       final prefs = await SharedPreferences.getInstance();
//       prefs.setStringList('panic_entries', _entries);
//     }
//   }

//   Future<void> deleteEntry(int index) async {
//     setState(() {
//       _entries.removeAt(index);
//     });
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setStringList('panic_entries', _entries);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.pink.shade50,
//       appBar: AppBar(
//         title: Text("Panic Diary"),
//         centerTitle: true,
//         backgroundColor: Colors.pinkAccent,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // Mood Heading
//             Text(
//               "Select your mood",
//               style: TextStyle(
//                 fontSize: 17,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.pink.shade700,
//               ),
//             ),
//             const SizedBox(height: 8),

//             // Emoji Picker
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: moods.map((mood) {
//                 final isSelected = mood == selectedMood;
//                 return GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       selectedMood = mood;
//                     });
//                   },
//                   child: Container(
//                     margin: EdgeInsets.symmetric(horizontal: 6),
//                     padding: EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: isSelected ? Colors.pinkAccent.shade100 : Colors.white,
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(
//                         color: isSelected ? Colors.pink : Colors.grey.shade300,
//                         width: 2,
//                       ),
//                     ),
//                     child: Text(
//                       mood,
//                       style: TextStyle(fontSize: 24),
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),

//             const SizedBox(height: 20),

//             // Text Heading
//             Text(
//               "Describe your emergency situation or feeling...",
//               style: TextStyle(
//                 fontSize: 17,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.pink.shade900,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 10),

//             // Input Field
//             TextField(
//               controller: _controller,
//               maxLines: 4,
//               decoration: InputDecoration(
//                 hintText: "Type here...",
//                 filled: true,
//                 fillColor: Colors.white,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(14),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//             ),

//             const SizedBox(height: 10),

//             // Save Button
//             ElevatedButton.icon(
//               onPressed: saveEntry,
//               icon: Icon(Icons.save_alt),
//               label: Text("Save Entry"),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.pinkAccent,
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 24,
//                   vertical: 14,
//                 ),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 25),

//             // History List
//             Expanded(
//               child: _entries.isEmpty
//                   ? Center(child: Text("No entries yet."))
//                   : ListView.builder(
//                       itemCount: _entries.length,
//                       itemBuilder: (context, index) {
//                         final parts = _entries[index].split('|');
//                         final timestamp = parts[0];
//                         final mood = parts[1];
//                         final content = parts.sublist(2).join('|');
//                         return Card(
//                           margin: const EdgeInsets.symmetric(vertical: 6),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           elevation: 2,
//                           child: ListTile(
//                             leading: Text(
//                               mood,
//                               style: TextStyle(fontSize: 28),
//                             ),
//                             title: Text(content),
//                             subtitle: Text(
//                               timestamp,
//                               style: TextStyle(fontSize: 12),
//                             ),
//                             trailing: IconButton(
//                               icon: Icon(Icons.delete, color: Colors.redAccent),
//                               onPressed: () => deleteEntry(index),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//}



// panic code full functional but without firebase 

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class PanicJournalScreen extends StatefulWidget {
//   @override
//   _PanicJournalScreenState createState() => _PanicJournalScreenState();
// }

// class _PanicJournalScreenState extends State<PanicJournalScreen> {
//   final TextEditingController _controller = TextEditingController();
//   List<String> _entries = [];
//   String selectedMood = "😊";
//   final List<String> moods = ["😊", "😔", "😡", "😨", "😰"];
//   final String pinKey = 'panic_pin';
//   final String pinChangedKey = 'pin_changed';
//   static bool _pinChecked = false; // Only checked once per session
//   bool _unlocked = false;

//   @override
//   void initState() {
//     super.initState();
//     checkPin();
//   }

//   Future<void> checkPin() async {
//     final prefs = await SharedPreferences.getInstance();
//     final pin = prefs.getString(pinKey);
//     final pinChanged = prefs.getBool(pinChangedKey) ?? false;

//     if (pin == null) {
//       setState(() {
//         _unlocked = true;
//         _pinChecked = true;
//       });
//       loadEntries();
//     } else if (!_pinChecked || pinChanged) {
//       _pinChecked = true;
//       prefs.setBool(pinChangedKey, false); // reset flag
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (_) {
//           final pinController = TextEditingController();
//           return AlertDialog(
//             title: Text("Enter PIN"),
//             content: TextField(
//               controller: pinController,
//               keyboardType: TextInputType.number,
//               obscureText: true,
//               maxLength: 6,
//               decoration: InputDecoration(
//                 hintText: "Enter your 4–6 digit PIN",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: Text("Cancel"),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   if (pinController.text == pin) {
//                     setState(() => _unlocked = true);
//                     Navigator.pop(context);
//                     loadEntries();
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text("Incorrect PIN")),
//                     );
//                   }
//                 },
//                 child: Text("Unlock"),
//               ),
//             ],
//           );
//         },
//       );
//     } else {
//       setState(() => _unlocked = true);
//       loadEntries();
//     }
//   }


//   Future<void> loadEntries() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _entries = prefs.getStringList('panic_entries') ?? [];
//     });
//   }

//   Future<void> saveEntry() async {
//     final text = _controller.text.trim();
//     if (text.isNotEmpty) {
//       final timestamp = DateTime.now().toLocal().toString().split('.')[0];
//       final entry = "$timestamp|$selectedMood|$text";
//       setState(() {
//         _entries.insert(0, entry);
//         _controller.clear();
//         selectedMood = "😊";
//       });
//       final prefs = await SharedPreferences.getInstance();
//       prefs.setStringList('panic_entries', _entries);
//     }
//   }

//   Future<void> deleteEntry(int index) async {
//     setState(() {
//       _entries.removeAt(index);
//     });
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setStringList('panic_entries', _entries);
//   }

//   void editEntry(int index, String oldText) {
//     final TextEditingController editController =
//         TextEditingController(text: oldText);
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: Text("Edit Entry"),
//         content: TextField(
//           controller: editController,
//           maxLines: 3,
//           decoration: InputDecoration(
//             border: OutlineInputBorder(),
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text("Cancel"),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               final newText = editController.text.trim();
//               if (newText.isNotEmpty) {
//                 final parts = _entries[index].split('|');
//                 final updated = "${parts[0]}|${parts[1]}|$newText";
//                 setState(() {
//                   _entries[index] = updated;
//                 });
//                 saveEntryList();
//                 Navigator.pop(context);
//               }
//             },
//             child: Text("Save"),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> saveEntryList() async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setStringList('panic_entries', _entries);
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (!_unlocked) {
//       return Scaffold(
//         backgroundColor: Colors.pink.shade50,
//         body: Center(
//           child: CircularProgressIndicator(color: Colors.pink),
//         ),
//       );
//     }

//     return Scaffold(
//       backgroundColor: Colors.pink.shade50,
//       appBar: AppBar(
//         title: Text("Panic Diary"),
//         centerTitle: true,
//         backgroundColor: Colors.pinkAccent,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             Text(
//               "Select your mood",
//               style: TextStyle(
//                 fontSize: 17,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.pink.shade700,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: moods.map((mood) {
//                 final isSelected = mood == selectedMood;
//                 return GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       selectedMood = mood;
//                     });
//                   },
//                   child: Container(
//                     margin: EdgeInsets.symmetric(horizontal: 6),
//                     padding: EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: isSelected
//                           ? Colors.pinkAccent.shade100
//                           : Colors.white,
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(
//                         color:
//                             isSelected ? Colors.pink : Colors.grey.shade300,
//                         width: 2,
//                       ),
//                     ),
//                     child: Text(
//                       mood,
//                       style: TextStyle(fontSize: 24),
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),
//             const SizedBox(height: 20),
//             Text(
//               "Speak through your words. This space listens.",
//               style: TextStyle(
//                 fontSize: 17,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.pink.shade900,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 10),
//             TextField(
//               controller: _controller,
//               maxLines: 4,
//               decoration: InputDecoration(
//                 hintText: "Describe your emergency situation or feeling...",
//                 filled: true,
//                 fillColor: Colors.white,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(14),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             ElevatedButton.icon(
//               onPressed: saveEntry,
//               icon: Icon(Icons.save_alt),
//               label: Text("Save Entry"),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.pinkAccent,
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 25),
//             _entries.isEmpty
//                 ? Text("No entries yet.")
//                 : ListView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     itemCount: _entries.length,
//                     itemBuilder: (context, index) {
//                       final parts = _entries[index].split('|');
//                       final timestamp = parts[0];
//                       final mood = parts[1];
//                       final content = parts.sublist(2).join('|');
//                       return Card(
//                         margin: const EdgeInsets.symmetric(vertical: 6),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         elevation: 2,
//                         child: ListTile(
//                           leading: Text(mood, style: TextStyle(fontSize: 28)),
//                           title: Text(content),
//                           subtitle: Text(timestamp,
//                               style: TextStyle(fontSize: 12)),
//                           trailing: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               IconButton(
//                                 icon:
//                                     Icon(Icons.edit, color: Colors.blueAccent),
//                                 onPressed: () => editEntry(index, content),
//                               ),
//                               IconButton(
//                                 icon: Icon(Icons.delete,
//                                     color: Colors.redAccent),
//                                 onPressed: () => deleteEntry(index),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// panic code full functional but with firebase

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class PanicJournalScreen extends StatefulWidget {
//   @override
//   _PanicJournalScreenState createState() => _PanicJournalScreenState();
// }

// class _PanicJournalScreenState extends State<PanicJournalScreen> {
//   final TextEditingController _controller = TextEditingController();
//   List<String> _entries = [];
//   String selectedMood = "😊";
//   final List<String> moods = ["😊", "😔", "😡", "😨", "😰"];
//   final String pinKey = 'panic_pin';
//   final String pinChangedKey = 'pin_changed';
//   static bool _pinChecked = false;
//   bool _unlocked = false;

//   @override
//   void initState() {
//     super.initState();
//     checkPin();
//   }

//   Future<void> checkPin() async {
//     final prefs = await SharedPreferences.getInstance();
//     final pin = prefs.getString(pinKey);
//     final pinChanged = prefs.getBool(pinChangedKey) ?? false;

//     if (pin == null) {
//       setState(() {
//         _unlocked = true;
//         _pinChecked = true;
//       });
//       loadEntries();
//     } else if (!_pinChecked || pinChanged) {
//       _pinChecked = true;
//       prefs.setBool(pinChangedKey, false);
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (_) {
//           final pinController = TextEditingController();
//           return AlertDialog(
//             title: Text("Enter PIN"),
//             content: TextField(
//               controller: pinController,
//               keyboardType: TextInputType.number,
//               obscureText: true,
//               maxLength: 6,
//               decoration: InputDecoration(
//                 hintText: "Enter your 4–6 digit PIN",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: Text("Cancel"),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   if (pinController.text == pin) {
//                     setState(() => _unlocked = true);
//                     Navigator.pop(context);
//                     loadEntries();
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text("Incorrect PIN")),
//                     );
//                   }
//                 },
//                 child: Text("Unlock"),
//               ),
//             ],
//           );
//         },
//       );
//     } else {
//       setState(() => _unlocked = true);
//       loadEntries();
//     }
//   }

//   Future<void> loadEntries() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _entries = prefs.getStringList('panic_entries') ?? [];
//     });
//   }

//   Future<void> saveEntry() async {
//     final text = _controller.text.trim();
//     if (text.isNotEmpty) {
//       final timestamp = DateTime.now().toLocal().toString().split('.')[0];
//       final entry = "$timestamp|$selectedMood|$text";

//       setState(() {
//         _entries.insert(0, entry);
//         _controller.clear();
//         selectedMood = "😊";
//       });

//       final prefs = await SharedPreferences.getInstance();
//       prefs.setStringList('panic_entries', _entries);

//       // 🔥 Save to Firestore
//       try {
//         final user = FirebaseAuth.instance.currentUser;
//         if (user != null) {
//           final firestore = FirebaseFirestore.instance;
//           await firestore
//               .collection('panic_entries')
//               .doc(user.uid)
//               .collection('entries')
//               .add({
//             'timestamp': timestamp,
//             'mood': selectedMood,
//             'content': text,
//           });
//         }
//       } catch (e) {
//         print("Firestore save failed: $e");
//       }
//     }
//   }

//   Future<void> deleteEntry(int index) async {
//     setState(() {
//       _entries.removeAt(index);
//     });
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setStringList('panic_entries', _entries);
//   }

//   void editEntry(int index, String oldText) {
//     final TextEditingController editController =
//         TextEditingController(text: oldText);
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: Text("Edit Entry"),
//         content: TextField(
//           controller: editController,
//           maxLines: 3,
//           decoration: InputDecoration(
//             border: OutlineInputBorder(),
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text("Cancel"),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               final newText = editController.text.trim();
//               if (newText.isNotEmpty) {
//                 final parts = _entries[index].split('|');
//                 final updated = "${parts[0]}|${parts[1]}|$newText";
//                 setState(() {
//                   _entries[index] = updated;
//                 });
//                 saveEntryList();
//                 Navigator.pop(context);
//               }
//             },
//             child: Text("Save"),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> saveEntryList() async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setStringList('panic_entries', _entries);
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (!_unlocked) {
//       return Scaffold(
//         backgroundColor: Colors.pink.shade50,
//         body: Center(
//           child: CircularProgressIndicator(color: Colors.pink),
//         ),
//       );
//     }

//     return Scaffold(
//       backgroundColor: Colors.pink.shade50,
//       appBar: AppBar(
//         title: Text("Panic Diary"),
//         centerTitle: true,
//         backgroundColor: Colors.pinkAccent,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             Text(
//               "Select your mood",
//               style: TextStyle(
//                 fontSize: 17,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.pink.shade700,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: moods.map((mood) {
//                 final isSelected = mood == selectedMood;
//                 return GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       selectedMood = mood;
//                     });
//                   },
//                   child: Container(
//                     margin: EdgeInsets.symmetric(horizontal: 6),
//                     padding: EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: isSelected
//                           ? Colors.pinkAccent.shade100
//                           : Colors.white,
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(
//                         color: isSelected
//                             ? Colors.pink
//                             : Colors.grey.shade300,
//                         width: 2,
//                       ),
//                     ),
//                     child: Text(
//                       mood,
//                       style: TextStyle(fontSize: 24),
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),
//             const SizedBox(height: 20),
//             Text(
//               "Speak through your words. This space listens.",
//               style: TextStyle(
//                 fontSize: 17,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.pink.shade900,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 10),
//             TextField(
//               controller: _controller,
//               maxLines: 4,
//               decoration: InputDecoration(
//                 hintText: "Describe your emergency situation or feeling...",
//                 filled: true,
//                 fillColor: Colors.white,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(14),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             ElevatedButton.icon(
//               onPressed: saveEntry,
//               icon: Icon(Icons.save_alt),
//               label: Text("Save Entry"),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.pinkAccent,
//                 padding: const EdgeInsets.symmetric(
//                     horizontal: 24, vertical: 14),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 25),
//             _entries.isEmpty
//                 ? Text("No entries yet.")
//                 : ListView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     itemCount: _entries.length,
//                     itemBuilder: (context, index) {
//                       final parts = _entries[index].split('|');
//                       final timestamp = parts[0];
//                       final mood = parts[1];
//                       final content = parts.sublist(2).join('|');
//                       return Card(
//                         margin: const EdgeInsets.symmetric(vertical: 6),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         elevation: 2,
//                         child: ListTile(
//                           leading:
//                               Text(mood, style: TextStyle(fontSize: 28)),
//                           title: Text(content),
//                           subtitle: Text(timestamp,
//                               style: TextStyle(fontSize: 12)),
//                           trailing: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               IconButton(
//                                 icon: Icon(Icons.edit,
//                                     color: Colors.blueAccent),
//                                 onPressed: () =>
//                                     editEntry(index, content),
//                               ),
//                               IconButton(
//                                 icon: Icon(Icons.delete,
//                                     color: Colors.redAccent),
//                                 onPressed: () => deleteEntry(index),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }




// this code is same as above but also includes feedback tab functionality to share private or public and include both firestore and shared preferences


// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class PanicJournalScreen extends StatefulWidget {
//   @override
//   _PanicJournalScreenState createState() => _PanicJournalScreenState();
// }

// class _PanicJournalScreenState extends State<PanicJournalScreen> {
//   final TextEditingController _controller = TextEditingController();
//   List<String> _entries = [];
//   String selectedMood = "😊";
//   final List<String> moods = ["😊", "😔", "😡", "😨", "😰"];
//   final String pinKey = 'panic_pin';
//   final String pinChangedKey = 'pin_changed';
//   static bool _pinChecked = false;
//   bool _unlocked = false;

//   @override
//   void initState() {
//     super.initState();
//     checkPin();
//   }

//   Future<void> checkPin() async {
//     final prefs = await SharedPreferences.getInstance();
//     final pin = prefs.getString(pinKey);
//     final pinChanged = prefs.getBool(pinChangedKey) ?? false;

//     if (pin == null) {
//       setState(() {
//         _unlocked = true;
//         _pinChecked = true;
//       });
//       loadEntries();
//     } else if (!_pinChecked || pinChanged) {
//       _pinChecked = true;
//       prefs.setBool(pinChangedKey, false);
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (_) {
//           final pinController = TextEditingController();
//           return AlertDialog(
//             title: Text("Enter PIN"),
//             content: TextField(
//               controller: pinController,
//               keyboardType: TextInputType.number,
//               obscureText: true,
//               maxLength: 6,
//               decoration: InputDecoration(
//                 hintText: "Enter your 4–6 digit PIN",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: Text("Cancel"),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   if (pinController.text == pin) {
//                     setState(() => _unlocked = true);
//                     Navigator.pop(context);
//                     loadEntries();
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text("Incorrect PIN")),
//                     );
//                   }
//                 },
//                 child: Text("Unlock"),
//               ),
//             ],
//           );
//         },
//       );
//     } else {
//       setState(() => _unlocked = true);
//       loadEntries();
//     }
//   }

//   Future<void> loadEntries() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _entries = prefs.getStringList('panic_entries') ?? [];
//     });
//   }

//   Future<void> saveEntry({required bool isPublic}) async {
//     final text = _controller.text.trim();
//     if (text.isEmpty) return;

//     final timestamp = DateTime.now().toLocal().toString().split('.')[0];
//     final entry = "$timestamp|$selectedMood|$text";

//     setState(() {
//       _entries.insert(0, entry);
//       _controller.clear();
//       selectedMood = "😊";
//     });

//     //final prefs = await SharedPreferences.getInstance();
//     //prefs.setStringList('panic_entries', _entries);

//     try {
//       final user = FirebaseAuth.instance.currentUser;
//       if (user != null) {
//         final firestore = FirebaseFirestore.instance;

//         // Save to private collection
//         await firestore
//             .collection('panic_entries')
//             .doc(user.uid)
//             .collection('entries')
//             .add({
//           'timestamp': timestamp,
//           'mood': selectedMood,
//           'content': text,
//         });

//         // Save to public feed
//         if (isPublic) {
//           final userDoc =
//               await firestore.collection('users').doc(user.uid).get();
//           final name = userDoc.exists ? userDoc['name'] ?? 'Anonymous' : 'Anonymous';

//           await firestore.collection('public_feed').add({
//             'timestamp': timestamp,
//             'mood': selectedMood,
//             'content': text,
//             'uid': user.uid,
//             'name': name,
//           });
//         }
//       }
//     } catch (e) {
//       print("Firestore save failed: $e");
//     }
//   }

//   Future<void> showSaveOptionsDialog() async {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: Text("Choose Visibility"),
//         content: Text("Do you want to keep this entry private or share it publicly?"),
//         actions: [
//           TextButton(
//             child: Text("Private"),
//             onPressed: () {
//               Navigator.pop(context);
//               saveEntry(isPublic: false);
//             },
//           ),
//           ElevatedButton(
//             child: Text("Public"),
//             onPressed: () {
//               Navigator.pop(context);
//               saveEntry(isPublic: true);
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> deleteEntry(int index) async {
//     setState(() {
//       _entries.removeAt(index);
//     });
//     //final prefs = await SharedPreferences.getInstance();
//     //prefs.setStringList('panic_entries', _entries);
//   }

//   void editEntry(int index, String oldText) {
//     final TextEditingController editController =
//         TextEditingController(text: oldText);
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: Text("Edit Entry"),
//         content: TextField(
//           controller: editController,
//           maxLines: 3,
//           decoration: InputDecoration(
//             border: OutlineInputBorder(),
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text("Cancel"),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               final newText = editController.text.trim();
//               if (newText.isNotEmpty) {
//                 final parts = _entries[index].split('|');
//                 final updated = "${parts[0]}|${parts[1]}|$newText";
//                 setState(() {
//                   _entries[index] = updated;
//                 });
//                 saveEntryList();
//                 Navigator.pop(context);
//               }
//             },
//             child: Text("Save"),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> saveEntryList() async {
//     //final prefs = await SharedPreferences.getInstance();
//     //prefs.setStringList('panic_entries', _entries);
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (!_unlocked) {
//       return Scaffold(
//         backgroundColor: Colors.pink.shade50,
//         body: Center(
//           child: CircularProgressIndicator(color: Colors.pink),
//         ),
//       );
//     }

//     return Scaffold(
//       backgroundColor: Colors.pink.shade50,
//       appBar: AppBar(
//         title: Text("Panic Diary"),
//         centerTitle: true,
//         backgroundColor: Colors.pinkAccent,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             Text(
//               "Select your mood",
//               style: TextStyle(
//                 fontSize: 17,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.pink.shade700,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: moods.map((mood) {
//                 final isSelected = mood == selectedMood;
//                 return GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       selectedMood = mood;
//                     });
//                   },
//                   child: Container(
//                     margin: EdgeInsets.symmetric(horizontal: 6),
//                     padding: EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: isSelected
//                           ? Colors.pinkAccent.shade100
//                           : Colors.white,
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(
//                         color: isSelected
//                             ? Colors.pink
//                             : Colors.grey.shade300,
//                         width: 2,
//                       ),
//                     ),
//                     child: Text(
//                       mood,
//                       style: TextStyle(fontSize: 24),
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),
//             const SizedBox(height: 20),
//             Text(
//               "Speak through your words. This space listens.",
//               style: TextStyle(
//                 fontSize: 17,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.pink.shade900,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 10),
//             TextField(
//               controller: _controller,
//               maxLines: 4,
//               decoration: InputDecoration(
//                 hintText: "Describe your emergency situation or feeling...",
//                 filled: true,
//                 fillColor: Colors.white,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(14),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             ElevatedButton.icon(
//               onPressed: showSaveOptionsDialog,
//               icon: Icon(Icons.save_alt),
//               label: Text("Save Entry"),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.pinkAccent,
//                 padding: const EdgeInsets.symmetric(
//                     horizontal: 24, vertical: 14),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 25),
//             _entries.isEmpty
//                 ? Text("No entries yet.")
//                 : ListView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     itemCount: _entries.length,
//                     itemBuilder: (context, index) {
//                       final parts = _entries[index].split('|');
//                       final timestamp = parts[0];
//                       final mood = parts[1];
//                       final content = parts.sublist(2).join('|');
//                       return Card(
//                         margin: const EdgeInsets.symmetric(vertical: 6),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         elevation: 2,
//                         child: ListTile(
//                           leading:
//                               Text(mood, style: TextStyle(fontSize: 28)),
//                           title: Text(content),
//                           subtitle: Text(timestamp,
//                               style: TextStyle(fontSize: 12)),
//                           trailing: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               IconButton(
//                                 icon: Icon(Icons.edit,
//                                     color: Colors.blueAccent),
//                                 onPressed: () =>
//                                     editEntry(index, content),
//                               ),
//                               IconButton(
//                                 icon: Icon(Icons.delete,
//                                     color: Colors.redAccent),
//                                 onPressed: () => deleteEntry(index),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }



// same functinality code as above but no shared preferences only firestore is used

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PanicJournalScreen extends StatefulWidget {
  @override
  _PanicJournalScreenState createState() => _PanicJournalScreenState();
}

class _PanicJournalScreenState extends State<PanicJournalScreen> {
  final TextEditingController _controller = TextEditingController();
  String selectedMood = "😊";
  final List<String> moods = ["😊", "😔", "😡", "😨", "😰"];
  final String pinKey = 'panic_pin';
  final String pinChangedKey = 'pin_changed';
  static bool _pinChecked = false;
  bool _unlocked = false;

  @override
  void initState() {
    super.initState();
    checkPin();
  }

  Future<void> checkPin() async {
    final prefs = await SharedPreferences.getInstance();
    final pin = prefs.getString(pinKey);
    final pinChanged = prefs.getBool(pinChangedKey) ?? false;

    if (pin == null) {
      setState(() {
        _unlocked = true;
        _pinChecked = true;
      });
    } else if (!_pinChecked || pinChanged) {
      _pinChecked = true;
      prefs.setBool(pinChangedKey, false);
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          final pinController = TextEditingController();
          return AlertDialog(
            title: Text("Enter PIN"),
            content: TextField(
              controller: pinController,
              keyboardType: TextInputType.number,
              obscureText: true,
              maxLength: 6,
              decoration: InputDecoration(
                hintText: "Enter your 4–6 digit PIN",
                border: OutlineInputBorder(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  if (pinController.text == pin) {
                    setState(() => _unlocked = true);
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Incorrect PIN")),
                    );
                  }
                },
                child: Text("Unlock"),
              ),
            ],
          );
        },
      );
    } else {
      setState(() => _unlocked = true);
    }
  }

  Future<void> saveEntry({required bool isPublic}) async {
  final text = _controller.text.trim();
  if (text.isEmpty) return;

  final timestamp = DateTime.now().toLocal().toString().split('.')[0];
  final moodToSave = selectedMood; // ✅ Save selectedMood before resetting

  _controller.clear();
  setState(() {
    selectedMood = "😊"; // ✅ Reset AFTER saving
  });

  try {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final firestore = FirebaseFirestore.instance;

      // Save to private collection
      await firestore
          .collection('panic_entries')
          .doc(user.uid)
          .collection('entries')
          .add({
        'timestamp': timestamp,
        'mood': moodToSave, // ✅ use saved mood
        'content': text,
      });

      // Save to public feed
      if (isPublic) {
        final userDoc =
            await firestore.collection('users').doc(user.uid).get();
        final name = userDoc.exists ? userDoc['name'] ?? 'Anonymous' : 'Anonymous';

        await firestore.collection('public_feed').add({
          'timestamp': timestamp,
          'mood': moodToSave, // ✅ use saved mood
          'content': text,
          'uid': user.uid,
          'name': name,
        });
      }
    }
  } catch (e) {
    print("Firestore save failed: $e");
  }
}

  Future<void> deleteEntry(String docId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    await FirebaseFirestore.instance
        .collection('panic_entries')
        .doc(user.uid)
        .collection('entries')
        .doc(docId)
        .delete();
  }

  Future<void> editEntry(String docId, String oldContent, String oldMood) async {
    final TextEditingController editController = TextEditingController(text: oldContent);
    String moodToEdit = oldMood;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Edit Entry"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: editController,
              maxLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: moods.map((m) {
                final selected = m == moodToEdit;
                return GestureDetector(
                  onTap: () => moodToEdit = m,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: selected ? Colors.pinkAccent : Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(m, style: TextStyle(fontSize: 20)),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
          ElevatedButton(
            onPressed: () async {
              final newText = editController.text.trim();
              if (newText.isNotEmpty) {
                final user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  await FirebaseFirestore.instance
                      .collection('panic_entries')
                      .doc(user.uid)
                      .collection('entries')
                      .doc(docId)
                      .update({
                    'content': newText,
                    'mood': moodToEdit,
                  });
                }
                Navigator.pop(context);
              }
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }

  Future<void> showSaveOptionsDialog() async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Choose Visibility"),
        content: Text("Do you want to keep this entry private or share it publicly?"),
        actions: [
          TextButton(
            child: Text("Private"),
            onPressed: () {
              Navigator.pop(context);
              saveEntry(isPublic: false);
            },
          ),
          ElevatedButton(
            child: Text("Public"),
            onPressed: () {
              Navigator.pop(context);
              saveEntry(isPublic: true);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_unlocked) {
      return Scaffold(
        backgroundColor: Colors.pink.shade50,
        body: Center(
          child: CircularProgressIndicator(color: Colors.pink),
        ),
      );
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Center(child: Text("Not logged in"));
    }

    final entriesStream = FirebaseFirestore.instance
        .collection('panic_entries')
        .doc(user.uid)
        .collection('entries')
        .orderBy('timestamp', descending: true)
        .snapshots();

    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        title: Text("Panic Diary"),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Select your mood", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row( 
                mainAxisAlignment: MainAxisAlignment.center,
                children: moods.map((mood) {
                  final isSelected = mood == selectedMood;
                  return GestureDetector(
                    onTap: () => setState(() => selectedMood = mood),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 6),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.pinkAccent.shade100 : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? Colors.pink : Colors.grey.shade300,
                          width: 2,
                        ),
                      ),
                      child: Text(mood, style: TextStyle(fontSize: 24)),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            Text("Speak through your words. This space listens.", style: TextStyle(fontSize: 17)),
            const SizedBox(height: 10),
            TextField(
              controller: _controller,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Describe your emergency situation or feeling...",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: showSaveOptionsDialog,
              icon: Icon(Icons.save_alt),
              label: Text("Save Entry"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 25),
            StreamBuilder<QuerySnapshot>(
              stream: entriesStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return CircularProgressIndicator();
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty)
                  return Text("No entries yet.");
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final doc = snapshot.data!.docs[index];
                    final data = doc.data() as Map<String, dynamic>;
                    final mood = data['mood'] ?? '😊';
                    final content = data['content'] ?? '';
                    final timestamp = data['timestamp'] ?? '';
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                      child: ListTile(
                        leading: Text(mood, style: TextStyle(fontSize: 28)),
                        title: Text(content),
                        subtitle: Text(timestamp),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => editEntry(doc.id, content, mood),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => deleteEntry(doc.id),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}