import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class DeleteVideoScreen extends StatefulWidget {
  const DeleteVideoScreen({Key? key}) : super(key: key);

  @override
  _DeleteVideoScreenState createState() => _DeleteVideoScreenState();
}

class _DeleteVideoScreenState extends State<DeleteVideoScreen> {
  List<File> _selectedFiles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('حذف الفيديو'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            _buildSelectFilesSection(),
            const SizedBox(height: 20),
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
                child: _buildSelectedFilesList(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _deleteSelectedFiles,
              icon: const Icon(Icons.delete, color: Colors.red),
              label: const Text(
                'حذف',
                style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(
                        255, 255, 0, 0)), // Changed text color to white
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
        ),
      ),
    );
  }

  Widget _buildSelectFilesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'اختر الفيديو الذي تريد حذفه',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: _selectFiles,
          icon: Icon(Icons.upload_file,
              color: const Color.fromARGB(
                  255, 0, 0, 0)), // Color the upload icon white
          label: const Text(
            'اختيار من الملفات',
            style:
                TextStyle(color: Colors.black), // Changed text color to black
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
              'لم يتم تحديد أي ملف حتى الآن',
              style: TextStyle(fontSize: 18),
            ),
          )
        : ListView.builder(
            itemCount: _selectedFiles.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  _selectedFiles[index].path,
                  style: TextStyle(fontSize: 16),
                ),
                leading: Icon(Icons.video_library,
                    color: Colors.black), // Color the video library icon black
                trailing: IconButton(
                  icon: Icon(Icons.delete,
                      color: Colors.red), // Color the delete icon red
                  onPressed: () {
                    setState(() {
                      _selectedFiles.removeAt(index);
                    });
                  },
                ),
              );
            },
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

  void _deleteSelectedFiles() {
    if (_selectedFiles.isEmpty) {
      // If no files are selected, show a message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('لم يتم تحديد أي فيديو لحذفه'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('حسنا'),
              ),
            ],
          );
        },
      );
    } else {
      // If files are selected, show a confirmation dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('هل أنت متأكد أنك تريد حذف الفيديو؟'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  // Delete the files and close the dialog
                  setState(() {
                    _selectedFiles.clear();
                  });
                  Navigator.of(context).pop();
                },
                child: Text(
                  'نعم',
                  style: TextStyle(color: Colors.red), // Set text color to red
                ),
              ),
              TextButton(
                onPressed: () {
                  // Close the dialog without deleting files
                  Navigator.of(context).pop();
                },
                child: Text('لا'),
              ),
            ],
          );
        },
      );
    }
  }
}
