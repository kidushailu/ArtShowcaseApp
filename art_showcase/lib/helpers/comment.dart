import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  final String text;
  final String user;
  final Timestamp time;
  const Comment({
    super.key,
    required this.text,
    required this.user,
    required this.time,
  });

  String formatDate(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();

    String year = dateTime.year.toString();

    String month = dateTime.month.toString();

    String day = dateTime.day.toString();

    String formattedDate = '$month/$day/$year';

    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(4)),
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // comment
          Text(text),
          const SizedBox(
            height: 5,
          ),
          //user, time
          Text(
            "$user • ${formatDate(time)}",
            style: TextStyle(color: Colors.grey[400]),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
