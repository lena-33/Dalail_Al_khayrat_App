// Import required packages
import 'package:flutter/material.dart';
import '../global_settings.dart'; // For font and size settings

// This page provides a simple Tasbeeh (counter) functionality
class TasbeehCounterPage extends StatefulWidget {
  const TasbeehCounterPage({Key? key}) : super(key: key);

  @override
  State<TasbeehCounterPage> createState() => _TasbeehCounterPageState();
}

class _TasbeehCounterPageState extends State<TasbeehCounterPage> {
  int counter = 0; // Tracks the current tasbeeh count

  // Increments the counter by 1
  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  // Shows a confirmation dialog to reset the counter
  void resetCounter() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ValueListenableBuilder<String>(
          valueListenable: selectedFontNotifier,
          builder: (context, fontFamily, _) {
            return ValueListenableBuilder<double>(
              valueListenable: fontSizeNotifier,
              builder: (context, fontSize, _) {
                return AlertDialog(
                  title: Text(
                    'تأكيد إعادة التعيين',
                    style: TextStyle(fontFamily: fontFamily),
                  ),
                  content: Text(
                    'هل أنت متأكد أنك تريد إعادة التعيين؟',
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: fontSize,
                    ),
                  ),
                  actions: [
                    // Cancel button
                    TextButton(
                      child: Text(
                        'إلغاء',
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: fontFamily,
                          fontSize: fontSize - 1,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),

                    // Confirm reset button
                    TextButton(
                      child: Text(
                        'نعم',
                        style: TextStyle(
                          color: Colors.red,
                          fontFamily: fontFamily,
                          fontSize: fontSize,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          counter = 0;
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: selectedFontNotifier,
      builder: (context, fontFamily, _) {
        return ValueListenableBuilder<double>(
          valueListenable: fontSizeNotifier,
          builder: (context, fontSize, _) {
            return Scaffold(
              backgroundColor: const Color(0xFFFFF8E1),

              // App bar with title
              appBar: AppBar(
                backgroundColor: const Color(0xFFDAC3A7),
                title: Text(
                  'عداد التسبيح',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: fontFamily,
                    fontSize: fontSize + 3,
                  ),
                ),
                centerTitle: true,
                iconTheme: const IconThemeData(color: Colors.white),
              ),

              // Main body content
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),

                    // Display current counter
                    Text(
                      '$counter',
                      style: TextStyle(
                        fontSize: 60,
                        color: Colors.brown,
                        fontFamily: fontFamily,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Button to increment the tasbeeh counter
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: incrementCounter,
                      child: Text(
                        'تسبيح',
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: fontSize,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Button to reset the counter (opens confirmation dialog)
                    TextButton(
                      onPressed: resetCounter,
                      child: Text(
                        'إعادة التعيين',
                        style: TextStyle(
                          color: Colors.red,
                          fontFamily: fontFamily,
                          fontSize: fontSize - 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
