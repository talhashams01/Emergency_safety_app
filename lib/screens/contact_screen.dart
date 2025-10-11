

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

