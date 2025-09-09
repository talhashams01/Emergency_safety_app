import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Terms & Conditions"),
        backgroundColor: Colors.pink,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Text('''
By using the Safe Zone App, you agree to the following terms and conditions:

1. Purpose of the App

This app is designed as a personal safety tool, allowing users to:

Send SOS and Safe messages to selected contacts.

Maintain a private or public panic journal.

Share emergency location in real-time during distress.

2. User Responsibilities

You are responsible for entering correct contact numbers and keeping your profile updated.

You must use the app respectfully and avoid sharing false or misleading public entries.

The app should not be misused for spam or pranks.

3. Location Accuracy

While we strive for accuracy, we do not guarantee perfect location results at all times. Location is subject to device permissions and GPS availability(Use internet for accuracy and faster response).

4. Emergency Use Disclaimer

The app is a tool to assist in emergencies but does not replace law enforcement or medical services. We are not liable for delays or issues in SMS delivery.

5. Public Journal Entries

When you choose to post a journal entry as “public,” you grant the app permission to show your content in the public feed visible to other users. Your name is hidden.

6. Account and Data Deletion

You may request complete data deletion by contacting us at [Contact Developer]. You can also delete your account or specific entries manually within the app.

7. Updates

We may update these terms and the app functionality from time to time. Continued use after changes means you accept the revised terms.

For any queries, use the Feedback option in Settings.

Thank you for your understanding and cooperation in making Safe Zone App a safe and supportive community.
          ''', style: TextStyle(fontSize: 16, height: 1.6)),
      ),
    );
  }
}
