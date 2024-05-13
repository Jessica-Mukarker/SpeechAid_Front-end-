import 'package:flutter/material.dart';

class TherapistNotificationPage extends StatefulWidget {
  @override
  _TherapistNotificationPageState createState() =>
      _TherapistNotificationPageState();
}

class _TherapistNotificationPageState extends State<TherapistNotificationPage> {
  // Define a list of NotificationItem objects representing notifications received by the therapist
  final List<NotificationItem> notifications = [
    NotificationItem(
      patientName: 'جون',
      patientAge: 30,
      message: 'قام المريض جون بتقديم مهمة فيديو',
      date: '21 مايو 2024',
      appointment: '21 مايو 2024 - 10:00 صباحًا',
      isRead: false,
    ),
    NotificationItem(
      patientName: 'ليزا',
      patientAge: 25,
      message: 'قام المريض ليزا بتقديم مهمة فيديو',
      date: '20 مايو 2024',
      appointment: null,
      isRead: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إشعارات الأخصائي'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever, color: Colors.red),
            onPressed: () {
              _showClearNotificationsDialog(context);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'المريض: ${notification.patientName}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'العمر: ${notification.patientAge}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'الإشعار: ${notification.message}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'التاريخ: ${notification.date}',
                    style: TextStyle(fontSize: 16),
                  ),
                  if (notification.appointment != null) ...[
                    Text(
                      'الموعد: ${notification.appointment}',
                      style: TextStyle(fontSize: 16, color: Colors.green),
                    ),
                  ],
                  SizedBox(height: 16),
                ],
              ),
              onTap: () {
                _showNotificationDetails(context, notification);
              },
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  _showDeleteNotificationDialog(context, index);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  void _showNotificationDetails(
      BuildContext context, NotificationItem notification) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('تفاصيل الإشعار'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('التاريخ: ${notification.date}'),
              SizedBox(height: 8),
              Text('الإشعار: ${notification.message}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('إغلاق'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteNotificationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('حذف الإشعار'),
          content: Text('هل أنت متأكد أنك تريد حذف هذا الإشعار؟'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  notifications.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: Text('نعم'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('إلغاء'),
            ),
          ],
        );
      },
    );
  }

  void _showClearNotificationsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('حذف كل الإشعارات'),
          content: Text('هل أنت متأكد أنك تريد حذف جميع الإشعارات؟'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  notifications.clear();
                });
                Navigator.of(context).pop();
              },
              child: Text('نعم'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('إلغاء'),
            ),
          ],
        );
      },
    );
  }
}

class NotificationItem {
  final String patientName;
  final int patientAge;
  final String message;
  final String date;
  final String? appointment;
  final bool isRead;

  NotificationItem({
    required this.patientName,
    required this.patientAge,
    required this.message,
    required this.date,
    this.appointment,
    required this.isRead,
  });
}
