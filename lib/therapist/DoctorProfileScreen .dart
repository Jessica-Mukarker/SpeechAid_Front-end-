import 'package:flutter/material.dart';

class DoctorProfileScreen extends StatelessWidget {
  const DoctorProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50], // Set background color
      appBar: AppBar(
        title: const Text('ملف الأخصائي'),
        backgroundColor:
            const Color(0xFF528FAA), // Set app bar background color
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          children: [
            _buildProfileImagePicker(context), // Add profile image picker
            const SizedBox(height: 20),
            _buildProfileInfo(context, 'الاسم', 'د. جون دو'),
            const SizedBox(height: 20),
            _buildProfileInfo(context, 'العمر', '40'),
            const SizedBox(height: 10),
            _buildProfileInfo(context, 'الهوية الخاصة', 'XYZ123'),
            const SizedBox(height: 10),
            _buildProfileInfo(context, 'المستشفى/العيادة', 'مستشفى XYZ'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add functionality to edit profile
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                backgroundColor: const Color(0xFF528FAA),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'تعديل الملف الشخصي',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImagePicker(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('اختر من المعرض'),
                  onTap: () async {
                    // Implement logic to pick image from gallery
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('التقط صورة'),
                  onTap: () async {
                    // Implement logic to capture image from camera
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      },
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: const Icon(
          Icons.camera_alt,
          size: 60,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildProfileInfo(BuildContext context, String label, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white, // Set card background color
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
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.end, // Align content to the right
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.right, // Align text to the right
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
            ),
            textAlign: TextAlign.right, // Align text to the right
          ),
        ],
      ),
    );
  }
}
