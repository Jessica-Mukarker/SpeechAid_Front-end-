import 'package:flutter/material.dart';
import 'package:speech_aid/therapist/AddVideoScreen.dart';
import 'package:speech_aid/therapist/CustomAppBarTherapist.dart';
import 'package:speech_aid/therapist/DeleteVideoScreen.dart';
import 'package:speech_aid/therapist/EditVideoScreen.dart';

class CombinedTherapistPage extends StatefulWidget {
  const CombinedTherapistPage({Key? key}) : super(key: key);

  @override
  _CombinedTherapistPageState createState() => _CombinedTherapistPageState();
}

class _CombinedTherapistPageState extends State<CombinedTherapistPage> {
  String? selectedLetter;
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarTherapist(
        // Use CustomAppBarTherapist instead of AppBar
        title: Text('صفحة التماريين'), // Set the title
        notificationCount: 0,
        onMenuItemSelected: (String value) {},
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  // Wrap the Row with Column
                  children: [
                    SizedBox(
                      // First button
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          _showLettersPopup(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 255, 255, 255),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 20,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'اختر الحرف ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold, // Bold text
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16), // Add spacing between buttons
                    SizedBox(
                      // Second button
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          _showPopup(context, [
                            'المقاطع القصيرة',
                            'المقاطع الطويلة',
                            'مقاطع ساكنة',
                            'اول الكلمة',
                            'وسط الكلمة',
                            'اخر الكلمة',
                          ]);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 255, 255, 255),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 20,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'اختر المقطع',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold, // Bold text
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(
                        height: 20,
                        thickness: 2), // Add divider between buttons
                  ],
                ),
              ),
              const SizedBox(height: 10),
              //exercise buttons for fix
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildLargeButton(
                      icon: Icons.add,
                      label: 'اضافة ',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddVideoScreen()),
                        );
                      },
                      color:
                          const Color(0xFF528FAA), // Blue color for add button
                    ),
                    const SizedBox(height: 20),
                    _buildLargeButton(
                      icon: Icons.remove,
                      label: 'ازالة ',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DeleteVideoScreen()),
                        );
                      },
                      color: const Color.fromARGB(
                          255, 255, 174, 229), // Pink color for delete button
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildLargeButton(
                      icon: Icons.edit,
                      label: 'تعديل ',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EditVideoScreen()),
                        );
                      },
                      color: const Color.fromARGB(
                          255, 255, 174, 229), // Pink color for update button
                    ),
                    const SizedBox(height: 20),
                    _buildLargeButton(
                      icon: Icons.block,
                      label: 'حظر ',
                      onPressed: () {},
                      color: const Color(
                          0xFF528FAA), // Blue color for block button
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Image.asset(
                'assets/image.png',
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLargeButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required Color color, // Added color parameter
  }) {
    return SizedBox(
      height: 160, // Adjust the height according to your preference
      width: 160, // Adjust the width according to your preference

      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40, // Adjust the icon size according to your preference
              color: color, // Use color parameter for icon color
            ),
            const SizedBox(height: 8), // Add spacing between icon and text
            Text(
              label,
              style: TextStyle(
                fontSize:
                    20, // Adjust the text size according to your preference
                color: color, // Use color parameter for text color
                fontWeight: FontWeight.bold, // Make text bold
              ),
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl, // Align text to the right
            ),
          ],
        ),
      ),
    );
  }

//choose the letter that you want
  void _showLettersPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: FractionallySizedBox(
            widthFactor: 0.8, // Adjust the width factor as needed
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Row(
                    // Row to align title and close button horizontally
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Center align title
                    children: [
                      Expanded(
                        child: Text(
                          'اختر الحرف الذي تريده ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Divider(height: 20, color: Colors.black),
                  const SizedBox(height: 20),
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: _buildLetterList(context),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(height: 20, color: Colors.black),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'اغلاق',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  ///the letters
  List<Widget> _buildLetterList(BuildContext context) {
    final List<String> arabicLetters = [
      'ث',
      'ت',
      'ب',
      'أ',
      'د',
      'خ',
      'ح',
      'ج',
      'س',
      'ز',
      'ر',
      'ذ',
      'ط',
      'ض',
      'ص',
      'ش',
      'ف',
      'غ',
      'ع',
      'ظ',
      'م',
      'ل',
      'ك',
      'ق',
      'ي',
      'و',
      'ه',
      'ن',
    ];

    List<Widget> rows = [];
    List<Widget> currentRow = [];
    for (int i = 0; i < arabicLetters.length; i++) {
      currentRow.add(
        SizedBox(
          height: 60,
          width: 60,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedLetter = arabicLetters[i];
                });
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: selectedLetter == arabicLetters[i]
                    ? const Color.fromARGB(255, 245, 158, 188)
                    : const Color.fromARGB(255, 207, 204, 204),
              ),
              child: Center(
                child: Text(
                  arabicLetters[i],
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
        ),
      );
      if ((i + 1) % 4 == 0 || i == arabicLetters.length - 1) {
        rows.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.from(currentRow),
          ),
        );
        currentRow.clear();
      }
    }
    return [
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.from(rows),
        ),
      ),
    ];
  }

//////Choose the part (المقطع)that you want
  void _showPopup(BuildContext context, List<String> titles) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: FractionallySizedBox(
            widthFactor: 0.8, // Adjust the width factor as needed
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'اختر المقطع الذي تريده',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(height: 20, color: Colors.black),
                  const SizedBox(height: 20),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: titles.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          if (titles[index] == 'المقاطع القصيرة') {
                            _showShortSectionOptions(context);
                          } else if (titles[index] == 'المقاطع الطويلة') {
                            _showLongSectionOptions(context);
                          } else {
                            setState(() {
                              selectedOption = titles[index];
                            });
                            Navigator.of(context).pop();
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: selectedOption == titles[index]
                                ? const Color.fromARGB(255, 245, 158, 188)
                                : Colors.transparent,
                          ),
                          child: Center(
                            child: Text(
                              titles[index],
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  const Divider(height: 20, color: Colors.black),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'اغلاق',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showShortSectionOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: FractionallySizedBox(
            widthFactor: 0.8, // Adjust the width factor as needed
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'اختر الحرف المطلوب',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(height: 20, color: Colors.black),
                  const SizedBox(height: 20),
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: _buildShortSectionOptions(context),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(height: 20, color: Colors.black),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'اغلاق',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildShortSectionOptions(BuildContext context) {
    final List<String> shortSectionOptions = [
      'فتحة',
      'ضمة',
      'كسرة',
    ];

    List<Widget> rows = [];
    List<Widget> currentRow = [];
    for (int i = 0; i < shortSectionOptions.length; i++) {
      currentRow.add(
        SizedBox(
          height: 60,
          width: 60,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedOption = shortSectionOptions[i];
                });
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: selectedOption == shortSectionOptions[i]
                    ? const Color.fromARGB(255, 245, 158, 188)
                    : const Color.fromARGB(255, 207, 204, 204),
              ),
              child: Center(
                child: Text(
                  shortSectionOptions[i],
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
        ),
      );
      if ((i + 1) % 3 == 0 || i == shortSectionOptions.length - 1) {
        rows.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.from(currentRow),
          ),
        );
        currentRow.clear();
      }
    }
    return [
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.from(rows),
        ),
      ),
    ];
  }

  void _showLongSectionOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: FractionallySizedBox(
            widthFactor: 0.8, // Adjust the width factor as needed
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'اختر الحرف المطلوب',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(height: 20, color: Colors.black),
                  const SizedBox(height: 20),
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: _buildLongSectionOptions(context),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(height: 20, color: Colors.black),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'اغلاق',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildLongSectionOptions(BuildContext context) {
    final List<String> longSectionOptions = [
      'الياء',
      'الواو',
      'الالف',
    ];

    List<Widget> rows = [];
    List<Widget> currentRow = [];
    for (int i = 0; i < longSectionOptions.length; i++) {
      currentRow.add(
        SizedBox(
          height: 60,
          width: 60,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedOption = longSectionOptions[i];
                });
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: selectedOption == longSectionOptions[i]
                    ? const Color.fromARGB(255, 245, 158, 188)
                    : const Color.fromARGB(255, 207, 204, 204),
              ),
              child: Center(
                child: Text(
                  longSectionOptions[i],
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
        ),
      );
      if ((i + 1) % 3 == 0 || i == longSectionOptions.length - 1) {
        rows.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.from(currentRow),
          ),
        );
        currentRow.clear();
      }
    }
    return [
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.from(rows),
        ),
      ),
    ];
  }
}
