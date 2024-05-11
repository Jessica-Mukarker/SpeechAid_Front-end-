import 'package:flutter/material.dart';

class TherapistNotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Assume you have a list of notifications for the therapist
    List<String> therapistNotifications = [
      "Patient John sent a message: 'I have a question about my exercise routine'",
      "Patient Lisa submitted a video assignment"
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Therapist Notifications'),
      ),
      body: ListView.builder(
        itemCount: therapistNotifications.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(therapistNotifications[index]),
            // You can add onTap functionality if needed
          );
        },
      ),
    );
  }
}

