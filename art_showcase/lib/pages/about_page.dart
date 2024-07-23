import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'About ArtConnect',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              Text(
                'ArtConnect is a community-driven platform designed to connect artists and art enthusiasts from around the world. Our mission is to provide a space where creativity thrives, and artists can showcase their work, connect with other artists, and find inspiration.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16.0),
              Text(
                'Key Features',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                '• Showcase your artwork: Upload and share your art with the community.\n'
                '• Discover new artists: Explore artwork from artists around the globe.\n'
                '• Connect with others: Follow your favorite artists and interact with their work.\n'
                '• Personalized feed: Get updates and recommendations based on your interests.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16.0),
              Text(
                'Contact Us',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                'If you have any questions, feedback, or need assistance, feel free to reach out to us:\n\n'
                'Email: support@artconnectapp.com\n'
                'Phone: +1 234 567 890\n'
                'Address: 123 ArtConnect St, Creativity City, Artland 45678',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
