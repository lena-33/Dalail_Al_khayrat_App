// Import necessary packages
import 'package:flutter/material.dart';
import 'pages/home_page.dart'; // Main entry page
import 'global_settings.dart'; // Contains font and size notifiers

// Entry point of the Flutter application
void main() {
  runApp(const MyApp());
}

// Main app widget using StatelessWidget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Listen to font changes using ValueListenableBuilder
    return ValueListenableBuilder<String>(
      valueListenable: selectedFontNotifier,
      builder: (context, fontFamily, _) {
        // Listen to font size changes
        return ValueListenableBuilder<double>(
          valueListenable: fontSizeNotifier,
          builder: (context, fontSize, _) {
            return MaterialApp(
              title: 'دلائل الخيرات',
              debugShowCheckedModeBanner: false,

              // App-wide theme settings
              theme: ThemeData(
                primarySwatch: Colors.brown,
                fontFamily: fontFamily,
                textTheme: Theme.of(
                  context,
                ).textTheme.apply(fontSizeFactor: fontSize / 16.0),
              ),

              // Initial screen of the app
              home: HomePage(),
            );
          },
        );
      },
    );
  }
}
