import 'package:flutter/material.dart';

class AppointmentDetails {
  final String patientName;
  final DateTime date;
  final TimeOfDay time;

  AppointmentDetails({
    required this.patientName,
    required this.date,
    required this.time,
  });
}

class AppointmentsPage extends StatefulWidget {
  const AppointmentsPage({super.key});

  @override
  _AppointmentsPageState createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  List<AppointmentDetails> appointments = [
    AppointmentDetails(
      patientName: 'مريض 1',
      date: DateTime(2024, 10, 25),
      time: const TimeOfDay(hour: 10, minute: 0),
    ),
    AppointmentDetails(
      patientName: 'مريض 2',
      date: DateTime(2024, 10, 26),
      time: const TimeOfDay(hour: 14, minute: 0),
    ),
    AppointmentDetails(
      patientName: 'مريض 3',
      date: DateTime(2024, 10, 27),
      time: const TimeOfDay(hour: 16, minute: 0),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Sort appointments based on the date
    appointments.sort((a, b) => a.date.compareTo(b.date));

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
            onDelete: () {
              _deleteAppointment(appointment);
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
              Text(
                  'التاريخ: ${appointment.date.day}-${appointment.date.month}-${appointment.date.year}'),
              const SizedBox(height: 8),
              Text('الوقت: ${appointment.time.format(context)}'),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                _deleteAppointment(appointment);
                Navigator.pop(context); // Close the dialog
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('تم الانتهاء'),
            ),
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
    DateTime selectedDate = DateTime.now(); // Default value
    TimeOfDay selectedTime = TimeOfDay.now(); // Default value
    String? patientName;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('إضافة موعد'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    decoration: const InputDecoration(labelText: 'اسم المريض'),
                    onChanged: (value) {
                      patientName = value;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    onTap: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null && pickedDate != selectedDate) {
                        setState(() {
                          selectedDate = pickedDate;
                        });
                      }
                    },
                    readOnly: true,
                    controller: TextEditingController(
                        text:
                            '${selectedDate.day}-${selectedDate.month}-${selectedDate.year}'),
                    decoration: const InputDecoration(
                      labelText: 'التاريخ',
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    onTap: () async {
                      final TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (pickedTime != null && pickedTime != selectedTime) {
                        setState(() {
                          selectedTime = pickedTime;
                        });
                      }
                    },
                    readOnly: true,
                    controller: TextEditingController(
                      text: selectedTime.format(context),
                    ),
                    decoration: const InputDecoration(
                      labelText: 'الوقت',
                    ),
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
                    if (patientName != null && patientName!.isNotEmpty) {
                      // Add appointment to the list
                      setState(() {
                        appointments.add(AppointmentDetails(
                          patientName: patientName!,
                          date: selectedDate,
                          time: selectedTime,
                        ));
                      });
                      Navigator.pop(context); // Close the dialog
                    } else {
                      // Show an error message if patient name is empty
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('يرجى إدخال اسم المريض'),
                        ),
                      );
                    }
                  },
                  child: const Text('إضافة'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _deleteAppointment(AppointmentDetails appointment) {
    setState(() {
      appointments.remove(appointment);
    });
  }
}

class AppointmentButton extends StatelessWidget {
  final AppointmentDetails appointment;
  final VoidCallback onPressed;
  final VoidCallback onDelete;

  const AppointmentButton({super.key, 
    required this.appointment,
    required this.onPressed,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(12), // Square border radius
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
                            'التاريخ: ${appointment.date.day}-${appointment.date.month}-${appointment.date.year}',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'الساعة: ${appointment.time.format(context)}',
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
          ),
        ],
      ),
    );
  }
}

class AddAppointmentButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddAppointmentButton({super.key, 
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
