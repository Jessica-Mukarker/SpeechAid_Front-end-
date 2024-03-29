import 'package:flutter/material.dart';

class AppointmentDetails {
  final String patientName;
  final String date;
  final String time;

  AppointmentDetails({
    required this.patientName,
    required this.date,
    required this.time,
  });
}

class AppointmentsPage extends StatefulWidget {
  @override
  _AppointmentsPageState createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  List<AppointmentDetails> appointments = [
    AppointmentDetails(
        patientName: 'مريض 1', date: '25 أكتوبر 2024', time: '10:00 ص'),
    AppointmentDetails(
        patientName: 'مريض 2', date: '26 أكتوبر 2024', time: '2:00 م'),
    AppointmentDetails(
        patientName: 'مريض 3', date: '27 أكتوبر 2024', time: '4:00 م'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المواعيد'),
      ),
      body: ListView.builder(
        itemCount: appointments.length + 1,
        itemBuilder: (context, index) {
          if (index == appointments.length) {
            return AddAppointmentButton(
              onPressed: _addAppointment,
            );
          }
          final appointment = appointments[index];
          return AppointmentButton(
            appointment: appointment,
            onPressed: () {
              _showAppointmentDetails(context, appointment);
            },
          );
        },
      ),
    );
  }

  void _showAppointmentDetails(
      BuildContext context, AppointmentDetails appointment) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('تفاصيل الموعد'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('اسم المريض: ${appointment.patientName}'),
              const SizedBox(height: 8),
              Text('التاريخ: ${appointment.date}'),
              const SizedBox(height: 8),
              Text('الوقت: ${appointment.time}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('إغلاق'),
            ),
          ],
        );
      },
    );
  }

  void _addAppointment() {
    showDialog(
      context: context,
      builder: (context) {
        String selectedDate = '25 أكتوبر 2024'; // Default value
        String selectedTime = '10:00 ص'; // Default value
        return AlertDialog(
          title: const Text('إضافة موعد'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextField(
                decoration: InputDecoration(labelText: 'اسم المريض'),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: selectedDate,
                onChanged: (value) {
                  setState(() {
                    selectedDate = value!;
                  });
                },
                items: [
                  '25 أكتوبر 2024',
                  '26 أكتوبر 2024',
                  '27 أكتوبر 2024',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: const InputDecoration(labelText: 'التاريخ'),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: selectedTime,
                onChanged: (value) {
                  setState(() {
                    selectedTime = value!;
                  });
                },
                items: [
                  '10:00 ص',
                  '2:00 م',
                  '4:00 م',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: const InputDecoration(labelText: 'الوقت'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () {
                // Add appointment logic
                Navigator.pop(context);
              },
              child: const Text('إضافة'),
            ),
          ],
        );
      },
    );
  }
}

class AppointmentButton extends StatelessWidget {
  final AppointmentDetails appointment;
  final VoidCallback onPressed;

  AppointmentButton({
    required this.appointment,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Square border radius
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'اسم المريض: ${appointment.patientName}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'التاريخ: ${appointment.date}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'الساعة: ${appointment.time}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              const Icon(
                Icons.keyboard_arrow_left,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddAppointmentButton extends StatelessWidget {
  final VoidCallback onPressed;

  AddAppointmentButton({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.add),
        label: const Text('إضافة موعد جديد'),
        style: ElevatedButton.styleFrom(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50), // Make it circular
          ),
        ),
      ),
    );
  }
}
