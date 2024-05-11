import 'package:flutter/material.dart';

class TherapistInfoPage extends StatelessWidget {
  final String therapistName;
  final String phoneNumber;
  final String address;
  final int age;
  final String hospital;

  const TherapistInfoPage({
    Key? key,
    required this.therapistName,
    required this.phoneNumber,
    required this.address,
    required this.age,
    required this.hospital,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('معلومات الأخصائي'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildInfoItem(
                      context,
                      title: ':اسم الأخصائي',
                      value: therapistName,
                      icon: Icons.person,
                      iconColor: Colors.blue,
                    ),
                    const SizedBox(height: 16),
                    _buildInfoItem(
                      context,
                      title: ': رقم الهاتف ',
                      value: phoneNumber,
                      icon: Icons.phone,
                      iconColor: Colors.green,
                    ),
                    const SizedBox(height: 16),
                    _buildInfoItem(
                      context,
                      title: ':العنوان',
                      value: address,
                      icon: Icons.location_on,
                      iconColor: Colors.orange,
                    ),
                    const SizedBox(height: 16),
                    _buildInfoItem(
                      context,
                      title: ':العمر',
                      value: age.toString(),
                      icon: Icons.cake,
                      iconColor: Colors.pink,
                    ),
                    const SizedBox(height: 16),
                    _buildInfoItem(
                      context,
                      title: ':المستشفى',
                      value: hospital,
                      icon: Icons.local_hospital,
                      iconColor: Colors.red,
                    ),
                    const SizedBox(
                        height: 20), // Add some spacing before the image
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 140, // Set your desired width
              height: 150, // Set your desired height
              child: Image.asset(
                'assets/image.png', // Adjust how the image fills the box
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(BuildContext context,
      {required String title,
      required String value,
      required IconData icon,
      required Color iconColor}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            icon,
            color: iconColor,
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}
