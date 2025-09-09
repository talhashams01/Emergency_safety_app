import 'package:flutter/material.dart';

class AboutAppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("About App"), backgroundColor: Colors.pink),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "SafeHer - Emergency & Panic Diary App",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink.shade700,
                ),
              ),
              SizedBox(height: 16),
              Text('''
          Safe Zone is a safety-focused mobile application designed to empower individuals in distress, especially women, by providing quick and effective tools during emergencies. Whether you're walking alone at night, facing harassment, or experiencing panic, Safe Zone ensures you're never truly alone.
          
🌟 Key Features:
        
🔹 Emergency SOS Messaging:
          Send instant SOS alerts with your real-time location to selected emergency contacts by tapping a button or even shaking your phone.
          
🔹 Safe Message Notification:
          Quickly inform your contacts that you're now safe after an emergency situation.
          
🔹 Offline Emergency Support:
          Both SOS and Safe messages work offline by using your device's SMS feature — no internet needed during critical times.
          
🔹 Contact Management:
          Add emergency contacts and prioritize some for faster alerting. Contacts appear on your home screen for quick access.
          
🔹 Shake to Alert:
          Simply shake your phone to trigger an automatic SOS alert with your location.
          
🔹 Panic Journal:
          Log your emotional states, panic episodes, or distressing events. You can choose to keep entries private or share them publicly with others for support.
          
🔹 Public Feed:
          See journal entries shared by others. Gain strength by knowing you're not alone.
          
🔹 Location Sharing:
          Every emergency message includes a Google Maps link to your current location so your loved ones can find you quickly.
          
🔹 Customizable Settings:
          Change your emergency message, manage PIN protection, and adjust app preferences from the Settings screen.
          
🔹 Profile Management:
          Update your name or email, log out, or permanently delete your account securely.
          
🔹 Privacy & Control:
          You decide what to share. Journals can stay private or go to a public feed. Contacts are stored securely using local storage.
          
          
       🛡 Why Safe Her?
          
          Safe Her was developed with a mission to provide confidence, safety, and instant support. Whether you're walking home late, commuting, or feeling anxious — help is just a tap (or shake) away.
          
                                        Your privacy is our top priority.
                ''', style: TextStyle(fontSize: 16, height: 1.6)),
              SizedBox(height: 20),
              Text(
                "Version: 1.0.0",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10,),
              Text(
                "Developed by: Talha Shams",
                style: TextStyle(color: Colors.grey[600]),
              ),
              SizedBox(height: 5,),
              Text(
                "Developed with ❤ in Flutter",
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
