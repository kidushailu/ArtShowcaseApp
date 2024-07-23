import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Help & Support',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              Text(
                'If you need any help or support with ArtConnect, you\'re in the right place! Below, you\'ll find various ways to get the assistance you need.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16.0),
              Text(
                'Frequently Asked Questions',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                'Q: How do I upload my artwork?\n'
                'A: To upload your artwork, go to the Home page and click on the "Upload Picture" button. Select the image from your gallery and add a title and description.\n',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Q: How do I edit my profile?\n'
                'A: To edit your profile, go to the Profile page and click on the edit icon. You can change your name, email, contact number, and profile picture.\n',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16.0),
              Text(
                'Contact Us',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                'If you have any questions, issues, or need further assistance, feel free to reach out to us:\n\n'
                'Email: support@artconnectapp.com\n'
                'Phone: +1 234 567 890\n'
                'Address: 123 ArtConnect St, Creativity City, Artland 45678',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16.0),
              Text(
                'Feedback',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                'We value your feedback and suggestions. Please let us know how we can improve ArtConnect to better serve you.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
