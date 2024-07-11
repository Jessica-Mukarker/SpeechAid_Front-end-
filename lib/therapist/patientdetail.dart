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
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل المريض'),
      ),
      body: Column(
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
                        const Icon(Icons.search),
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
                          ),
                        ),
                        if (_controller.text.isNotEmpty)
                          IconButton(
                            icon: const Icon(Icons.clear),
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
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'رقم الهوية: ${patient['id']}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'الاسم: ${patient['firstName']} ${patient['lastName']}',
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'العمر: ${patient['age']}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        // Add any other details or actions related to each patient
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
    );
  }
}
