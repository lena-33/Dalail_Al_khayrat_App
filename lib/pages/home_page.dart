// Importing required Flutter packages and app-specific pages
import 'package:flutter/material.dart';
import 'detail_page.dart';
import 'package:flutter_application_1/pages/favorites_page.dart';
import 'package:flutter_application_1/pages/dalael_intro_page.dart';
import 'package:flutter_application_1/pages/dalael_explanation_page.dart';
import '../global_settings.dart'; // Global font and size settings
import 'daily_wird_tracker_page.dart';
import 'TasbeehCounterPage.dart';

// HomePage displays the main dashboard of the app with all core navigation
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  // List of content items with titles and associated text file paths
  final List<Map<String, String>> items = const [
    // Introductory and special prayers
    {'title': 'دعاء الافتتاح', 'file': 'assets/texts/doa1.txt'},
    {
      'title': 'أسماء الله الحسنى',
      'file': 'assets/texts/asmaAllahAllHusna.txt',
    },
    {'title': 'أسماء النبي ﷺ', 'file': 'assets/texts/asmaAlNabi.txt'},
    {'title': 'دعاء النية', 'file': 'assets/texts/doa2.txt'},

    // Daily Ahzab
    {'title': 'الحزب 1', 'file': 'assets/texts/hizb1.txt'},
    {'title': 'الحزب 2', 'file': 'assets/texts/hizb2.txt'},
    {'title': 'الحزب 3', 'file': 'assets/texts/hizb3.txt'},
    {'title': 'الحزب 4', 'file': 'assets/texts/hizb4.txt'},
    {'title': 'الحزب 5', 'file': 'assets/texts/hizb5.txt'},
    {'title': 'الحزب 6', 'file': 'assets/texts/hizb6.txt'},
    {'title': 'الحزب 7', 'file': 'assets/texts/hizb7.txt'},
    {'title': 'الحزب 8', 'file': 'assets/texts/hizb8.txt'},

    // Final closing prayer
    {
      'title': 'دعاء يقرأ عقب دلائل الخيرات',
      'file': 'assets/texts/doaAfter.txt',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Dynamically listen to font family and size changes
    return ValueListenableBuilder<String>(
      valueListenable: selectedFontNotifier,
      builder: (context, fontFamily, _) {
        return ValueListenableBuilder<double>(
          valueListenable: fontSizeNotifier,
          builder: (context, fontSize, _) {
            return Scaffold(
              // App bar with title and font styling
              appBar: AppBar(
                backgroundColor: const Color(0xFFF5F5DC),
                title: Text(
                  'الرئيسية',
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: fontSize + 4,
                    color: Colors.brown,
                  ),
                ),
                centerTitle: true,
                iconTheme: const IconThemeData(color: Colors.brown),
              ),

              // Side drawer with additional navigation items
              drawer: Drawer(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
                backgroundColor: const Color(0xE6FFF8E1),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    const SizedBox(height: 32),
                    // Navigation tile: App Introduction
                    ListTile(
                      leading: const Icon(Icons.menu_book, color: Colors.brown),
                      title: Text(
                        'تعريف دلائل الخيرات',
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DalaelIntroPage(),
                          ),
                        );
                      },
                    ),
                    // Navigation tile: Explanation Page
                    ListTile(
                      leading: const Icon(
                        Icons.book_outlined,
                        color: Colors.brown,
                      ),
                      title: Text(
                        'شرح دلائل الخيرات',
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DalaelExplanationPage(),
                          ),
                        );
                      },
                    ),
                    // Navigation tile: Wird Tracker
                    ListTile(
                      leading: const Icon(
                        Icons.track_changes,
                        color: Colors.brown,
                      ),
                      title: Text(
                        'تتبع وردي اليومي',
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DailyWirdTrackerPage(),
                          ),
                        );
                      },
                    ),
                    // Navigation tile: Tasbeeh Counter
                    ListTile(
                      leading: const Icon(Icons.exposure, color: Colors.brown),
                      title: Text(
                        'عداد تسبيح',
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TasbeehCounterPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              // Main content area with decorative background
              body: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFFFF8E1),
                  image: DecorationImage(
                    image: AssetImage('assets/images/beige_pattern.png'),
                    repeat: ImageRepeat.repeat,
                    fit: BoxFit.cover,
                    opacity: 0.1,
                  ),
                ),
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Full-width items
                      buildFullWidthItem(
                        context,
                        'دعاء الافتتاح',
                        fontFamily,
                        fontSize,
                        'assets/texts/doa1.txt',
                      ),
                      buildFullWidthItem(
                        context,
                        'دعاء النية',
                        fontFamily,
                        fontSize,
                        'assets/texts/doa2.txt',
                      ),

                      // Rows with two items side by side
                      buildDoubleItemRow(
                        context,
                        'أسماء النبي ﷺ',
                        'assets/texts/asmaAlNabi.txt',
                        'أسماء الله الحسنى',
                        'assets/texts/asmaAllahAllHusna.txt',
                        fontFamily,
                        fontSize,
                      ),

                      // Hizb sections displayed in pairs
                      buildDoubleItemRow(
                        context,
                        'الحزب 2',
                        'assets/texts/hizb2.txt',
                        'الحزب 1',
                        'assets/texts/hizb1.txt',
                        fontFamily,
                        fontSize,
                      ),
                      buildDoubleItemRow(
                        context,
                        'الحزب 4',
                        'assets/texts/hizb4.txt',
                        'الحزب 3',
                        'assets/texts/hizb3.txt',
                        fontFamily,
                        fontSize,
                      ),
                      buildDoubleItemRow(
                        context,
                        'الحزب 6',
                        'assets/texts/hizb6.txt',
                        'الحزب 5',
                        'assets/texts/hizb5.txt',
                        fontFamily,
                        fontSize,
                      ),
                      buildDoubleItemRow(
                        context,
                        'الحزب 8',
                        'assets/texts/hizb8.txt',
                        'الحزب 7',
                        'assets/texts/hizb7.txt',
                        fontFamily,
                        fontSize,
                      ),

                      // Closing prayer
                      buildFullWidthItem(
                        context,
                        'دعاء يُقرأ عقب دلائل الخيرات',
                        fontFamily,
                        fontSize,
                        'assets/texts/doaAfter.txt',
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom navigation bar with only two items
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: 0,
                selectedItemColor: Colors.brown,
                unselectedItemColor: Colors.grey,
                backgroundColor: const Color(0xFFF5F5DC),
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'الرئيسية',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.bookmark),
                    label: 'المفضلة',
                  ),
                ],
                onTap: (index) {
                  if (index == 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FavoritesPage(),
                      ),
                    );
                  }
                },
              ),
            );
          },
        );
      },
    );
  }

  // Helper widget for creating a full-width clickable card item
  Widget buildFullWidthItem(
    BuildContext context,
    String title,
    String fontFamily,
    double fontSize,
    String fileName,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => DetailPage(title: title, fileName: fileName),
            ),
          );
        },
        child: Card(
          color: const Color(0xFFF5F5DC),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.brown.shade300, width: 1),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to create a horizontal row with two cards side by side
  Widget buildDoubleItemRow(
    BuildContext context,
    String title1,
    String file1,
    String title2,
    String file2,
    String fontFamily,
    double fontSize,
  ) {
    return Row(
      children: [
        Expanded(
          child: buildFullWidthItem(
            context,
            title1,
            fontFamily,
            fontSize,
            file1,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: buildFullWidthItem(
            context,
            title2,
            fontFamily,
            fontSize,
            file2,
          ),
        ),
      ],
    );
  }
}
