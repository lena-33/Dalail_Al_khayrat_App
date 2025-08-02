import 'package:flutter/material.dart';

// Global notifier to track the selected font across the app.
// Default font is set to 'Monadi'
ValueNotifier<String> selectedFontNotifier = ValueNotifier<String>('Monadi');

// Global notifier to track the font size across the app.
// Default size is set to 16.0 (standard readable size)
ValueNotifier<double> fontSizeNotifier = ValueNotifier<double>(16.0);
