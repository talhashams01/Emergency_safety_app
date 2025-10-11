


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  void _confirmDelete(BuildContext context, String docId) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Delete Entry"),
        content: Text("Are you sure you want to delete this entry?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text("Delete"),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await FirebaseFirestore.instance
          .collection('public_feed')
          .doc(docId)
          .delete();
    }
  }

  Future<String> getUserName(String uid) async {
    try {
      final userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (userDoc.exists) {
        return userDoc.data()?['name'] ?? 'Anonymous';
      } else {
        return 'Anonymous';
      }
    } catch (e) {
      return 'Anonymous';
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        title: Text("Community Feed"),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('public_feed')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator(color: Colors.pink));

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty)
            return Center(child: Text("No public entries yet."));

          final entries = snapshot.data!.docs;

          return ListView.builder(
            itemCount: entries.length,
            itemBuilder: (context, index) {
              final entry = entries[index];
              final mood = entry['mood'] ?? "😊";
              final content = entry['content'] ?? "";
              final timestamp = entry['timestamp'] ?? "";
              final uid = entry['uid'] ?? "";
              final docId = entry.id;

              final isOwner = currentUser != null && currentUser.uid == uid;

              return FutureBuilder<String>(
                future: getUserName(uid),
                builder: (context, nameSnapshot) {
                  final name = nameSnapshot.data ?? 'Anonymous';

                  return Card(
                    margin: const EdgeInsets.all(8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    child: ListTile(
                      leading: Text(mood, style: TextStyle(fontSize: 28)),
                      title: Text(content),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 4),
                          Text("By: $name", style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(timestamp, style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      trailing: isOwner
                          ? IconButton(
                              icon: Icon(Icons.delete, color: Colors.redAccent),
                              onPressed: () => _confirmDelete(context, docId),
                            )
                          : null,
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}