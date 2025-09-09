// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ContactsScreen extends StatefulWidget {
//   @override
//   _ContactsScreenState createState() => _ContactsScreenState();
// }

// class _ContactsScreenState extends State<ContactsScreen> {
//   List<Map<String, String>> contacts = [];

//   @override
//   void initState() {
//     super.initState();
//     loadContacts();
//   }

//   Future<void> loadContacts() async {
//     final prefs = await SharedPreferences.getInstance();
//     final List<String>? stored = prefs.getStringList('emergencyContacts');
//     if (stored != null) {
//       setState(() {
//         contacts = stored
//             .map((e) => {
//                   'name': e.split('|')[0],
//                   'number': e.split('|')[1],
//                 })
//             .toList();
//       });
//     }
//   }

//   Future<void> saveContacts() async {
//     final prefs = await SharedPreferences.getInstance();
//     List<String> formatted =
//         contacts.map((e) => '${e['name']}|${e['number']}').toList();
//     await prefs.setStringList('emergencyContacts', formatted);
//   }

//   void showAddOrEditDialog({int? index}) {
//     String name = index != null ? contacts[index]['name'] ?? '' : '';
//     String number = index != null ? contacts[index]['number'] ?? '' : '';
//     String nameError = '';
//     String numberError = '';

//     showDialog(
//       context: context,
//       builder: (_) => StatefulBuilder(
//         builder: (context, setStateDialog) {
//           return AlertDialog(
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//             title: Text(index == null ? "Add Emergency Contact" : "Edit Contact"),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextField(
//                   decoration: InputDecoration(
//                     labelText: "Name",
//                     errorText: nameError.isNotEmpty ? nameError : null,
//                   ),
//                   onChanged: (val) {
//                     name = val;
//                     setStateDialog(() => nameError = '');
//                   },
//                   controller: TextEditingController(text: name),
//                 ),
//                 TextField(
//                   decoration: InputDecoration(
//                     labelText: "Phone Number",
//                     errorText: numberError.isNotEmpty ? numberError : null,
//                   ),
//                   keyboardType: TextInputType.phone,
//                   onChanged: (val) {
//                     number = val;
//                     setStateDialog(() => numberError = '');
//                   },
//                   controller: TextEditingController(text: number),
//                 ),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 child: Text("Cancel"),
//                 onPressed: () => Navigator.pop(context),
//               ),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.pinkAccent),
//                 child: Text("Save"),
//                 onPressed: () {
//                   bool isValid = true;
//                   if (name.trim().isEmpty) {
//                     nameError = "Enter name";
//                     isValid = false;
//                   }
//                   if (number.trim().isEmpty) {
//                     numberError = "Enter number";
//                     isValid = false;
//                   }
//                   setStateDialog(() {});

//                   if (isValid) {
//                     setState(() {
//                       if (index == null) {
//                         contacts.add({'name': name, 'number': number});
//                       } else {
//                         contacts[index] = {'name': name, 'number': number};
//                       }
//                     });
//                     saveContacts();
//                     Navigator.pop(context);
//                   }
//                 },
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   void removeContact(int index) {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: Text("Remove Contact"),
//         content: Text("Are you sure you want to delete this contact?"),
//         actions: [
//           TextButton(
//             child: Text("Cancel"),
//             onPressed: () => Navigator.pop(context),
//           ),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
//             child: Text("Delete"),
//             onPressed: () {
//               setState(() => contacts.removeAt(index));
//               saveContacts();
//               Navigator.pop(context);
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.pink.shade50,
//       appBar: AppBar(
//         title: Text("My Emergency Contacts"),
//         backgroundColor: Colors.pinkAccent,
//         centerTitle: true,
//         elevation: 4,
//       ),
//       body: contacts.isEmpty
//           ? Center(
//               child: Text(
//                 "No contacts added yet.",
//                 style: TextStyle(fontSize: 16),
//               ),
//             )
//           : ListView.builder(
//               itemCount: contacts.length,
//               padding: const EdgeInsets.all(12),
//               itemBuilder: (_, index) {
//                 final contact = contacts[index];
//                 return Card(
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16)),
//                   elevation: 3,
//                   margin: const EdgeInsets.symmetric(vertical: 8),
//                   child: ListTile(
//                     leading: CircleAvatar(
//                       backgroundColor: Colors.pink.shade300,
//                       child: Icon(Icons.person, color: Colors.white),
//                     ),
//                     title: Text(
//                       contact['name'] ?? '',
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     subtitle: Text(contact['number'] ?? ''),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(
//                           icon: Icon(Icons.edit, color: Colors.blueAccent),
//                           onPressed: () => showAddOrEditDialog(index: index),
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.delete, color: Colors.redAccent),
//                           onPressed: () => removeContact(index),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.pinkAccent,
//         child: Icon(Icons.add),
//         onPressed: () => showAddOrEditDialog(),
//       ),
//     );
//   }
// }

// contacts screen with shared preferences storage

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactsScreen extends StatefulWidget {
  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  List<Map<String, Object>> contacts = [];

  @override
  void initState() {
    super.initState();
    loadContacts();
  }

  Future<void> loadContacts() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? stored = prefs.getStringList('emergencyContacts');
    if (stored != null) {
      setState(() {
        contacts = stored.map((e) {
          final parts = e.split('|');
          return {
            'name': parts[0],
            'number': parts[1],
            'priority': parts.length > 2 ? parts[2] == 'true' : false,
          };
        }).toList();
      });
    }
  }

  Future<void> saveContacts() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> formatted = contacts
        .map((e) => '${e['name']}|${e['number']}|${e['priority']}')
        .toList();
    await prefs.setStringList('emergencyContacts', formatted);
  }

  // void showAddOrEditDialog({int? index}) {
  //   final nameController = TextEditingController(
  //     text: index != null ? contacts[index]['name'] ?? '' : '',
  //   );
  //   final numberController = TextEditingController(
  //     text: index != null ? contacts[index]['number'] ?? '' : '',
  //   );
  //   String nameError = '';
  //   String numberError = '';

  //   showDialog(
  //     context: context,
  //     builder: (_) => StatefulBuilder(
  //       builder: (context, setStateDialog) {
  //         return AlertDialog(
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(16),
  //           ),
  //           title: Text(index == null ? "Add Emergency Contact" : "Edit Contact"),
  //           content: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               TextField(
  //                 controller: nameController,
  //                 decoration: InputDecoration(
  //                   labelText: "Name",
  //                   errorText: nameError.isNotEmpty ? nameError : null,
  //                 ),
  //                 onChanged: (_) {
  //                   if (nameError.isNotEmpty) {
  //                     setStateDialog(() => nameError = '');
  //                   }
  //                 },
  //               ),
  //               TextField(
  //                 controller: numberController,
  //                 decoration: InputDecoration(
  //                   labelText: "Phone Number",
  //                   errorText: numberError.isNotEmpty ? numberError : null,
  //                 ),
  //                 keyboardType: TextInputType.phone,
  //                 onChanged: (_) {
  //                   if (numberError.isNotEmpty) {
  //                     setStateDialog(() => numberError = '');
  //                   }
  //                 },
  //               ),
  //             ],
  //           ),
  //           actions: [
  //             TextButton(
  //               child: Text("Cancel"),
  //               onPressed: () => Navigator.pop(context),
  //             ),
  //             ElevatedButton(
  //               style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
  //               child: Text("Save"),
  //               onPressed: () {
  //                 bool isValid = true;
  //                 if (nameController.text.trim().isEmpty) {
  //                   nameError = "Enter name";
  //                   isValid = false;
  //                 }
  //                 if (numberController.text.trim().isEmpty) {
  //                   numberError = "Enter number";
  //                   isValid = false;
  //                 }
  //                 setStateDialog(() {});

  //                 if (isValid) {
  //                   setState(() {
  //                     if (index == null) {
  //                       contacts.add({
  //                         'name': nameController.text.trim(),
  //                         'number': numberController.text.trim(),
  //                         'priority': false,
  //                       });
  //                     } else {
  //                       contacts[index]['name'] = nameController.text.trim();
  //                       contacts[index]['number'] = numberController.text.trim();
  //                     }
  //                   });
  //                   saveContacts();
  //                   Navigator.pop(context);
  //                 }
  //               },
  //             ),
  //           ],
  //         );
  //       },
  //     ),
  //   );
  // }

  void showAddOrEditDialog({int? index}) {
  // Move these controllers outside the dialog builder
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  // Assign initial values
  if (index != null) {
    nameController.text = contacts[index]['name'] as String? ?? '';
    numberController.text = contacts[index]['number'] as String? ?? '';
  }

  String? nameError;
  String? numberError;

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setStateDialog) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: Text(index == null ? "Add Emergency Contact" : "Edit Contact"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Name",
                    errorText: nameError,
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: numberController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Phone Number",
                    errorText: numberError,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("Cancel"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
                onPressed: () {
                  String name = nameController.text.trim();
                  String number = numberController.text.trim();
                  bool valid = true;

                  if (name.isEmpty) {
                    nameError = "Please enter name";
                    valid = false;
                  }
                  if (number.isEmpty) {
                    numberError = "Please enter number";
                    valid = false;
                  }

                  if (!valid) {
                    setStateDialog(() {}); // update UI for errors
                    return;
                  }

                  setState(() {
                    if (index == null) {
                      contacts.add({
                        'name': name,
                        'number': number,
                        'priority': false,
                      });
                    } else {
                      contacts[index]['name'] = name;
                      contacts[index]['number'] = number;
                    }
                  });
                  saveContacts();
                  Navigator.of(context).pop();
                },
                child: Text("Save"),
              ),
            ],
          );
        },
      );
    },
  );
}

  void removeContact(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Remove Contact"),
        content: Text("Are you sure you want to delete this contact?"),
        actions: [
          TextButton(
            child: Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            child: Text("Delete"),
            onPressed: () {
              setState(() => contacts.removeAt(index));
              saveContacts();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void togglePriority(int index) {
    setState(() {
      contacts[index]['priority'] = !(contacts[index]['priority'] as bool ?? false);
    });
    saveContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        title: Text("Emergency Contacts"),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
      ),
      body: contacts.isEmpty
          ? Center(child: Text("No contacts added yet."))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: contacts.length,
              itemBuilder: (_, index) {
                final contact = contacts[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.pink.shade300,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    title: Text(
                      contact['name']as String? ?? '',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(contact['number']as String? ?? ''),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            contact['priority'] == true
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber,
                          ),
                          onPressed: () => togglePriority(index),
                        ),
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blueAccent),
                          onPressed: () => showAddOrEditDialog(index: index),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () => removeContact(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pinkAccent,
        child: Icon(Icons.add),
        onPressed: () => showAddOrEditDialog(),
      ),
    );
  }
}




// contact screen with firebase not shared preferences

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class ContactsScreen extends StatefulWidget {
//   @override
//   _ContactsScreenState createState() => _ContactsScreenState();
// }

// class _ContactsScreenState extends State<ContactsScreen> {
//   List<DocumentSnapshot> contacts = [];
//   late CollectionReference userContactsRef;

//   @override
//   void initState() {
//     super.initState();
//     final user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       userContactsRef = FirebaseFirestore.instance
//           .collection('contacts_collection') // <-- change collection name if needed
//           .doc(user.uid)
//           .collection('user_contacts');
//       fetchContacts();
//     }
//   }

//   Future<void> fetchContacts() async {
//     final snapshot = await userContactsRef.get();
//     setState(() {
//       contacts = snapshot.docs;
//     });
//     print("Contacts fetched: ${contacts.length}");
//   }

//   void showAddOrEditDialog({DocumentSnapshot? doc}) {
//     final nameController = TextEditingController(
//         text: doc != null ? doc['name'] ?? '' : '');
//     final numberController = TextEditingController(
//         text: doc != null ? doc['number'] ?? '' : '');

//     String? nameError;
//     String? numberError;

//     showDialog(
//       context: context,
//       builder: (_) => StatefulBuilder(
//         builder: (context, setStateDialog) {
//           return AlertDialog(
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//             title: Text(doc == null ? "Add Emergency Contact" : "Edit Contact"),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextField(
//                   controller: nameController,
//                   decoration: InputDecoration(
//                     labelText: "Name",
//                     errorText: nameError,
//                   ),
//                 ),
//                 SizedBox(height: 12),
//                 TextField(
//                   controller: numberController,
//                   keyboardType: TextInputType.phone,
//                   decoration: InputDecoration(
//                     labelText: "Phone Number",
//                     errorText: numberError,
//                   ),
//                 ),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: Text("Cancel"),
//               ),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
//                 onPressed: () async {
//                   final name = nameController.text.trim();
//                   final number = numberController.text.trim();

//                   if (name.isEmpty || number.isEmpty) {
//                     setStateDialog(() {
//                       if (name.isEmpty) nameError = "Enter name";
//                       if (number.isEmpty) numberError = "Enter number";
//                     });
//                     return;
//                   }

//                   final data = {
//                     'name': name,
//                     'number': number,
//                     'priority': doc?['priority'] ?? false,
//                   };

//                   try {
//                     if (doc == null) {
//                       await userContactsRef.add(data);
//                       print("New contact added to Firestore");
//                     } else {
//                       await userContactsRef.doc(doc.id).update(data);
//                       print("Contact updated in Firestore");
//                     }
//                     Navigator.pop(context);
//                     fetchContacts();
//                   } catch (e) {
//                     print("Error saving contact: $e");
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text("Failed to save contact")),
//                     );
//                   }
//                 },
//                 child: Text("Save"),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   void removeContact(DocumentSnapshot doc) {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: Text("Remove Contact"),
//         content: Text("Are you sure you want to delete this contact?"),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text("Cancel"),
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               await userContactsRef.doc(doc.id).delete();
//               print("Contact deleted");
//               Navigator.pop(context);
//               fetchContacts();
//             },
//             style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
//             child: Text("Delete"),
//           ),
//         ],
//       ),
//     );
//   }

//   void togglePriority(DocumentSnapshot doc) async {
//     final current = doc['priority'] ?? false;
//     await userContactsRef.doc(doc.id).update({'priority': !current});
//     print("Priority updated to: ${!current}");
//     fetchContacts();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.pink.shade50,
//       appBar: AppBar(
//         title: Text("My Emergency Contacts"),
//         centerTitle: true,
//         backgroundColor: Colors.pinkAccent,
//       ),
//       body: contacts.isEmpty
//           ? Center(child: Text("No contacts added yet."))
//           : ListView.builder(
//               padding: EdgeInsets.all(12),
//               itemCount: contacts.length,
//               itemBuilder: (context, index) {
//                 final doc = contacts[index];
//                 return Card(
//                   margin: EdgeInsets.symmetric(vertical: 8),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//                   elevation: 2,
//                   child: ListTile(
//                     leading: CircleAvatar(
//                       backgroundColor: Colors.pink,
//                       child: Icon(Icons.person, color: Colors.white),
//                     ),
//                     title: Text(doc['name']),
//                     subtitle: Text(doc['number']),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(
//                           icon: Icon(
//                             doc['priority'] == true
//                                 ? Icons.star
//                                 : Icons.star_border,
//                             color: Colors.amber,
//                           ),
//                           onPressed: () => togglePriority(doc),
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.edit, color: Colors.blueAccent),
//                           onPressed: () => showAddOrEditDialog(doc: doc),
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.delete, color: Colors.redAccent),
//                           onPressed: () => removeContact(doc),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.pinkAccent,
//         child: Icon(Icons.add),
//         onPressed: () => showAddOrEditDialog(),
//       ),
//     );
//   }
// }