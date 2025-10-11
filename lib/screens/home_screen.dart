



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