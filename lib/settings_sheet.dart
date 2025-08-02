// Import required packages and global settings
import 'package:flutter/material.dart';
import 'global_settings.dart'; // For font and size notifiers

// A map that links Arabic font names to their actual font family keys
final Map<String, String> fontMap = {
  'الخط العثماني': 'UthmanicHafs_V22',
  'الخط الأندلسي': '22-andlso',
  'خط منادي': 'Monadi',
  'خط التأسيس': 'Tasees-Bold',
};

// This widget is shown as a bottom sheet to adjust font settings
class SettingsSheet extends StatefulWidget {
  final double currentFontSize;
  final ValueChanged<double> onFontSizeChanged;
  final String currentFontFamily;
  final ValueChanged<String> onFontFamilyChanged;

  const SettingsSheet({
    Key? key,
    required this.currentFontSize,
    required this.onFontSizeChanged,
    required this.currentFontFamily,
    required this.onFontFamilyChanged,
  }) : super(key: key);

  @override
  State<SettingsSheet> createState() => _SettingsSheetState();
}

class _SettingsSheetState extends State<SettingsSheet> {
  late double fontSize; // Holds current font size
  late String fontFamily; // Holds current font family

  @override
  void initState() {
    super.initState();
    fontSize = widget.currentFontSize;
    fontFamily = widget.currentFontFamily;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // RTL layout for Arabic
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header title
              const Text(
                'إعدادات الخط',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Font size slider
              Row(
                children: [
                  const Text('حجم الخط:'),
                  Expanded(
                    child: Slider(
                      value: fontSize,
                      min: 14,
                      max: 30,
                      divisions: 8,
                      label: fontSize.round().toString(),
                      onChanged: (value) {
                        setState(() {
                          fontSize = value;
                        });
                        fontSizeNotifier.value =
                            value; // update global font size
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Font family selection section
              const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'اختر نوع الخط:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),

              // List of available fonts using radio buttons
              ...fontMap.entries.map((entry) {
                final displayName = entry.key;
                final fontValue = entry.value;
                return RadioListTile<String>(
                  title: Text(
                    displayName,
                    style: TextStyle(fontFamily: fontValue),
                  ),
                  value: fontValue,
                  groupValue: fontFamily,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        fontFamily = value;
                      });
                      widget.onFontFamilyChanged(value); // notify parent
                      selectedFontNotifier.value = value; // update global font
                    }
                  },
                );
              }),

              const SizedBox(height: 16),

              // Close button
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('تم'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
