import 'package:flutter/material.dart';

class SettingsList extends StatelessWidget {
  final dynamic page;
  final String title;

  const SettingsList({super.key, required this.page, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListTile(
        leading: const Icon(Icons.arrow_left),
        title: Text(title),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
      ),
    );
  }
}
