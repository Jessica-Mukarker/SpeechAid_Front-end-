import 'package:flutter/material.dart';

class PatientNotificationPage extends StatefulWidget {
  @override
  _PatientNotificationPageState createState() =>
      _PatientNotificationPageState();
}

class _PatientNotificationPageState extends State<PatientNotificationPage> {
  List<NotificationItem> notifications = [
    NotificationItem(
      message: "لقد قام الاخصائي بارسال فيديو جديد",
      date: "11 مايو 2024",
      isRead: false,
    ),
    NotificationItem(
      message: "تذكير بالموعد الطبي ليوم غد",
      date: "10 مايو 2024",
      isRead: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'الإشعارات للمريض',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.delete_forever,
              color: Colors.red, // Change trash can color to red
            ),
            onPressed: () {
              _showClearNotificationsDialog(context);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return _buildNotificationItem(context, notifications[index]);
        },
      ),
    );
  }

  Widget _buildNotificationItem(BuildContext context, NotificationItem item) {
    return Card(
      elevation: 4, // Add elevation for a shadow effect
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: item.isRead ? Colors.white : Colors.grey[200],
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.date,
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                item.message,
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          _showNotificationDetails(context, item);
        },
        trailing: IconButton(
          icon: const Icon(Icons.delete,
              color: Colors.red), // Change trash can color to red
          onPressed: () {
            _showDeleteNotificationDialog(context, item);
          },
        ),
      ),
    );
  }

  void _showNotificationDetails(BuildContext context, NotificationItem item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('تفاصيل الإشعار'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('التاريخ: ${item.date}'),
                const SizedBox(height: 8),
                Text('الرسالة: ${item.message}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('إغلاق'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteNotificationDialog(
      BuildContext context, NotificationItem item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('حذف الإشعار'),
          content: const Text('هل أنت متأكد أنك تريد حذف هذا الإشعار؟'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  notifications.remove(item);
                });
                Navigator.of(context).pop();
              },
              child: const Text('نعم'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('إلغاء'),
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
          title: const Text('حذف كل الإشعارات'),
          content: const Text('هل أنت متأكد أنك تريد حذف جميع الإشعارات؟'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  notifications.clear();
                });
                Navigator.of(context).pop();
              },
              child: const Text('نعم'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('إلغاء'),
            ),
          ],
        );
      },
    );
  }
}

class NotificationItem {
  final String message;
  final String date;
  final bool isRead;

  NotificationItem({
    required this.message,
    required this.date,
    required this.isRead,
  });
}
