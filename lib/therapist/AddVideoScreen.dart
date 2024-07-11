import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:speech_aid/Constants.dart';
import 'package:speech_aid/therapist/RecordingScreenTherapist.dart';
import 'package:http/http.dart' as http;

class AddVideoScreen extends StatefulWidget {
  String therapist_id;

  int exercise_level;

  String exercise_letter;

  AddVideoScreen(
      {Key? key,
      required this.therapist_id,
      required this.exercise_letter,
      required this.exercise_level})
      : super(key: key);

  @override
  _AddVideoScreenState createState() => _AddVideoScreenState();
}

class _AddVideoScreenState extends State<AddVideoScreen> {
  List<File> _selectedFiles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إضافة محتوى'),
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
          'هل ترغب في بدء التسجيل؟',
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
              'سحب الملفات هنا أو ابحث في التخزين',
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
        'أضف الآن',
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
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        _selectedFiles = result.paths.map((path) => File(path!)).toList();
      });
    }
  }

  List level = ['Short', 'Long', 'Silent', 'Start', 'Middle', 'End'];
  Future<void> _saveFiles() async {
    String apiUrl = ADDEXERCICES;

    Map<String, String> headers = {"Content-type": "application/json"};

    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.files.add(await http.MultipartFile.fromPath(
        'exercise_file', _selectedFiles.first.path));
    request.fields['therapist_id'] = widget.therapist_id;
    request.fields['exercise_level'] = level[widget.exercise_level];
    request.fields['exercise_letter'] = widget.exercise_letter;
    request.fields['exercise_description'] = "";
    var response = await http.Response.fromStream(await request.send());
    print(request.fields);
    final responseStream = response.body;

    print("Response Data: $responseStream");

    if (response.statusCode == 200) {
      print('Video uploaded successfully');
    } else {
      print('Failed to upload video. Error: ${response.statusCode}');
    }
    if (_selectedFiles.isEmpty) {
      // If no videos were selected or recorded
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('لم يتم اختيار أي فيديو'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('حسنا'),
              ),
            ],
          );
        },
      );
    } else {
      // If videos were selected or recorded
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('تم حفظ الفيديو بنجاح'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('حسنا'),
              ),
            ],
          );
        },
      );
    }
  }
}
