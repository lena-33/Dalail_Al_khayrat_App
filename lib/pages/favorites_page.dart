// Import required packages and app dependencies
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // For storing favorites
import 'package:flutter_application_1/pages/home_page.dart'; // For navigation
import '../../global_settings.dart'; // Access to global font and size settings

// This page displays the user's saved favorite paragraphs
class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<String> favoriteParagraphs = []; // Stores list of saved favorites

  @override
  void initState() {
    super.initState();
    loadFavorites(); // Load favorites on initialization
  }

  // Load saved favorite paragraphs from SharedPreferences
  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final storedFavorites = prefs.getStringList('favorites') ?? [];
    setState(() {
      favoriteParagraphs = storedFavorites;
    });
  }

  // Remove a paragraph from favorites and update storage
  Future<void> removeFromFavorites(String paragraph) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      favoriteParagraphs.remove(paragraph);
      prefs.setStringList('favorites', favoriteParagraphs);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar with dynamic font and size
      appBar: AppBar(
        backgroundColor: const Color(0xFFDAC3A7),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: ValueListenableBuilder<String>(
          valueListenable: selectedFontNotifier,
          builder: (context, fontFamily, _) {
            return ValueListenableBuilder<double>(
              valueListenable: fontSizeNotifier,
              builder: (context, fontSize, _) {
                return Text(
                  'المفضلة',
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: fontSize + 2,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                );
              },
            );
          },
        ),
      ),
      backgroundColor: const Color(0xFFFFF8F0),

      // Display message if no favorites are found
      body:
          favoriteParagraphs.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.bookmark_border, size: 100, color: Colors.brown),
                    SizedBox(height: 16),
                    Text(
                      'لا توجد مفضلات بعد',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.brown,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
              // Display list of favorite paragraphs
              : ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: favoriteParagraphs.length,
                itemBuilder: (context, index) {
                  final paragraph = favoriteParagraphs[index];
                  return Card(
                    color: const Color(0xFFF6EEDB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(
                        paragraph,
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Color(0xFF4E342E),
                          height: 1.6,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => removeFromFavorites(paragraph),
                      ),
                    ),
                  );
                },
              ),

      // Bottom navigation bar to switch between home and favorites
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.grey,
        backgroundColor: const Color(0xFFF5F5DC),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'المفضلة'),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          }
        },
      ),
    );
  }
}
