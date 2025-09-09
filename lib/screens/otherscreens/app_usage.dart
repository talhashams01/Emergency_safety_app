import 'package:flutter/material.dart';

class HowToUseApp extends StatelessWidget {
  final List<Map<String, String>> steps = [
    {
      'title': '➕ Add Emergency Contacts',
      'desc':
          'In the Contacts tab, tap the + button to add people you trust. You can also mark them as "Priority" for emergencies.',
    },
    {
      'title': '📞 Contacts on Home Screen',
      'desc':
          'Your added contacts will appear on the Home screen in a horizontal scroll. Tap any contact to send SOS or "I\'m Safe" message directly to them.',
    }, 
    {
      'title': '⭐ Priority Contacts',
      'desc':
          'Mark contacts as Priority to quickly send SOS messages only to them during emergencies.',
    },
    {
      'title': '📍 Location Required for SOS',
      'desc':
          'Before sending an SOS or "I\'m Safe" message, your current location is attached to help others locate you. Please allow location access.',
    },
    {
      'title': '📱 Sending SOS',
      'desc':
          'On the Home screen, tap "SEND SOS" or shake your phone to trigger the alert. A message with your location will be sent to your contacts(Allow SMS permission from setting).',
    },
    {
      'title': '✅ I\'m Safe Button',
      'desc':
          'After an emergency ends, tap "I\'M SAFE" to let your contacts know you are now safe. A message is sent to all saved contacts.',
    },
    {
      'title': '📓 Panic Diary (Journal)',
      'desc':
          'Go to the Panic tab to write your feelings or record an event. Choose:\n\n• "Private": Only you can see it(Works Offine).\n• "Public": Shared anonymously in the Feed tab for others to learn and support(Works Online).',
    },
    {
      'title': '🌍 Feed Tab',
      'desc':
          'The Feed tab shows public entries shared by users. This helps others feel supported and learn from real experiences.',
    },
    {
      'title': '🛡 Profile Screen',
      'desc':
          'Tap the person icon on the top right of Home screen to open your profile. Here you can:\n- Update your name or email\n- Logout from the app securely\n- Delete your account permanently.',
    },
    {
      'title': '⚙ Settings & Customization',
      'desc':
          'In Settings, you can:\n- Change your SOS and Safe messages\n- Set a PIN for your Panic Diary\n- Reset all settings so the app behaves like a new install.',
    },
    {
      'title': '🧑‍💻 Contact Developer',
      'desc':
          'Have a suggestion or need help? Tap the "?" icon on the top right of Home screen to reach out directly.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("How to Use"),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: steps.length,
        itemBuilder: (_, index) {
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    steps[index]['title']!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.pinkAccent,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    steps[index]['desc']!,
                    style: TextStyle(fontSize: 15, height: 1.4),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}