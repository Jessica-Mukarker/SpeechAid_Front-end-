import 'package:flutter/material.dart';

class PatientDetail extends StatefulWidget {
  const PatientDetail({Key? key}) : super(key: key);

  @override
  _PatientDetailState createState() => _PatientDetailState();
}

class _PatientDetailState extends State<PatientDetail> {
  List<Map<String, dynamic>> patients = [
    {'id': '001', 'firstName': 'جون', 'lastName': 'دو', 'age': 10},
    {'id': '002', 'firstName': 'أليس', 'lastName': 'سميث', 'age': 7},
    {'id': '003', 'firstName': 'بوب', 'lastName': 'جونسون', 'age': 3},
    // Add more patients as needed
  ];

  String searchQuery = '';
  TextEditingController _controller = TextEditingController();

  void _showPatientDetails(Map<String, dynamic> patient) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
            child: Text(
              'تفاصيل المريض',
              style: TextStyle(color: Colors.black),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Icon(Icons.person, size: 20, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text(
                    'رقم الهوية: ${patient['id']}',
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Icon(Icons.badge, size: 20, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text(
                    'الاسم: ${patient['firstName']} ${patient['lastName']}',
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Icon(Icons.calendar_today,
                      size: 20, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text(
                    'العمر: ${patient['age']}',
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            Center(
              child: TextButton(
                child: const Text('إغلاق'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'تفاصيل المريض',
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search,
                              size: 20, color: Colors.grey),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              onChanged: (value) {
                                setState(() {
                                  searchQuery = value;
                                });
                              },
                              decoration: const InputDecoration(
                                hintText: 'ابحث عن مريض...',
                                border: InputBorder.none,
                              ),
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                          if (_controller.text.isNotEmpty)
                            IconButton(
                              icon: const Icon(Icons.clear,
                                  size: 20, color: Colors.grey),
                              onPressed: () {
                                setState(() {
                                  searchQuery = '';
                                  _controller.clear();
                                });
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Add functionality to add new patient
                      if (_controller.text.isNotEmpty &&
                          !patients.any(
                              (patient) => patient['id'] == _controller.text)) {
                        setState(() {
                          patients.add({
                            'id': _controller.text,
                            'firstName': 'مريض',
                            'lastName': 'جديد',
                            'age': 0,
                          });
                          _controller.clear();
                        });
                      }
                    },
                    child: const Text('إضافة'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: patients.length,
                itemBuilder: (context, index) {
                  final patient = patients[index];
                  if (patient['id']
                          .toLowerCase()
                          .contains(searchQuery.toLowerCase()) ||
                      '${patient['firstName']} ${patient['lastName']}'
                          .toLowerCase()
                          .contains(searchQuery.toLowerCase())) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.person,
                                      size: 20, color: Colors.grey),
                                  const SizedBox(width: 8),
                                  Text(
                                    'رقم الهوية: ${patient['id']}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                    textDirection: TextDirection.rtl,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Icon(Icons.badge,
                                      size: 20, color: Colors.grey),
                                  const SizedBox(width: 8),
                                  Text(
                                    'الاسم: ${patient['firstName']} ${patient['lastName']}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                    textDirection: TextDirection.rtl,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          onTap: () => _showPatientDetails(patient),
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
