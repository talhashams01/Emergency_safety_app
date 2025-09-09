import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy Policy"),
        backgroundColor: Colors.pink,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Text('''
At Safe Zone App, your privacy and safety are our top priorities. This Privacy Policy outlines how we collect, use, and protect your information.

1. Information We Collect

We may collect and store the following information:

Personal Information: Name and email(when you provide it during profile setup).

Location Data: Only when sending SOS or Safe messages, to provide accurate location in emergencies.

Emergency Contacts: Stored locally using SharedPreferences for offline use. Not shared externally.

Journal Entries: Saved privately under your account(Works Offline). Public entries are only visible to others if you choose to share them(Works Online).

2. How We Use Your Information

To enable emergency SMS with real-time location.

To allow you to maintain a personal panic journal.

To display your name in public feed if you post a public entry.

To personalize your app experience (e.g., mood selection, feed visibility).

3. Data Storage and Security

Firebase is used for securely storing your journal entries and profile data.

Contacts are stored locally, not on any server, ensuring your data stays private.

All location access is triggered manually by you (via SOS button) and not tracked continuously.

4. Permissions Used

Location: Only to attach to SOS or Safe messages.

SMS: To open your SMS app and auto-fill emergency messages.

Shake Detection: For offline SOS triggering.

5. Your Control

You can edit or delete your data (journal entries, profile) anytime.

You choose whether to share your journal entry publicly or keep it private.

You can remove or edit your emergency contacts freely.

6. Third-Party Sharing

We do not share your data with any third parties. Your information stays between you and this app only.

7: 📍Important Notice:

This app is designed to work even without an internet connection(Home and contacts tab).
However, for accurate location sharing, please ensure:
Location services (GPS) are enabled.
Internet is available for better precision.

In some situations — such as being indoors, in low signal areas, or offline — the app may not fetch or attach the exact location in SOS messages.
          ''', style: TextStyle(fontSize: 16, height: 1.6)),
      ),
    );
  }
}
