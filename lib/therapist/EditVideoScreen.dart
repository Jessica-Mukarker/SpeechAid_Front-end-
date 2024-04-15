import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:speech_aid/therapist/RecordingScreenTherapist.dart';

class EditVideoScreen extends StatefulWidget {
  const EditVideoScreen({Key? key}) : super(key: key);

  @override
  _EditContentState createState() => _EditContentState();
}

class _EditContentState extends State<EditVideoScreen> {
  List<File> _selectedFiles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تعديل المحتوى'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildStartRecordingSection(),
            const SizedBox(height: 10),
            _buildSelectFilesSection(),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: _buildSelectedFilesList(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            _buildAddNowButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildStartRecordingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'هل ترغب التسجيل مرة اخرى ؟',
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RecordingScreenTherapist(),
              ),
            );
          },
          icon: const Icon(Icons.mic_rounded,
              color: Color.fromARGB(255, 0, 0, 0)),
          label: const Text(
            'بدء التسجيل',
            style: TextStyle(color: Colors.black),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 255, 174, 229),
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSelectFilesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'اختيار من الملفات',
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: _selectFiles,
          icon: const Icon(Icons.file_upload_rounded,
              color: Color.fromARGB(255, 0, 0, 0)),
          label: const Text(
            'اختيار من الملفات',
            style: TextStyle(color: Colors.black),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 255, 174, 229),
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSelectedFilesList() {
    return _selectedFiles.isEmpty
        ? const Center(
            child: Text(
              'اذا كنت ترغب في تحديث الفيديو, يرجى سحب الملفات هنا أو ابحث في التخزين',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          )
        : ListView.builder(
            itemCount: _selectedFiles.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_selectedFiles[index].path),
                // Display the file path
              );
            },
          );
  }

  Widget _buildAddNowButton() {
    return ElevatedButton.icon(
      onPressed: () {
        _saveFiles();
      },
      icon: const Icon(Icons.save_rounded),
      label: const Text(
        ' حفظ',
        style: TextStyle(fontSize: 16),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 255, 174, 229),
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Future<void> _selectFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'mp4',
        'mov',
        'avi',
        'txt',
        'pdf',
        'jpg',
        'jpeg',
        'png'
      ],
      allowMultiple: true,
    );

    if (result != null) {
      setState(() {
        _selectedFiles = result.paths.map((path) => File(path!)).toList();
      });
    }
  }

  void _saveFiles() {
    // Add functionality to save the selected files here
    // For example, you can iterate over _selectedFiles and save each file
    // You can use the File methods to save files to the desired location
  }
}
