// Importing required packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
    show rootBundle; // For loading local text files
import 'package:share_plus/share_plus.dart'; // For sharing text externally
import 'package:shared_preferences/shared_preferences.dart'; // For saving favorites locally
import '../global_settings.dart'; // Global font settings
import 'package:flutter_application_1/settings_sheet.dart'; // Bottom sheet for font settings

// DetailPage displays a list of paragraphs from a selected text file
class DetailPage extends StatefulWidget {
  final String title;
  final String fileName;

  const DetailPage({Key? key, required this.title, required this.fileName})
    : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List<String> paragraphs = []; // List of paragraphs loaded from file
  List<String> favorites = []; // List of saved favorite paragraphs
  int selectedParagraphIndex = -1; // Index of the currently selected paragraph
  bool isLoading = true; // Loading indicator
  String fontFamily = selectedFontNotifier.value; // Initial font family

  @override
  void initState() {
    super.initState();
    // Load file content and then load saved favorites
    loadText().then((_) => loadFavorites());
  }

  // Load text file and split paragraphs by '---' delimiter
  Future<void> loadText() async {
    try {
      String fileContent = await rootBundle.loadString(widget.fileName);
      setState(() {
        paragraphs = fileContent.split('---');
        isLoading = false;
      });
    } catch (e) {
      print('خطأ في تحميل الملف: $e');
      setState(() {
        paragraphs = ['حدث خطأ أثناء تحميل النص'];
        isLoading = false;
      });
    }
  }

  // Load favorites from SharedPreferences
  Future<void> loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      favorites = prefs.getStringList('favorites') ?? [];
    });
  }

  // Build each paragraph card, highlighted if selected
  Widget buildParagraphCard(String paragraph, int index) {
    final isSelected = selectedParagraphIndex == index;

    final spans = [
      TextSpan(
        text: paragraph,
        style: TextStyle(
          color: const Color(0xFF4E342E),
          fontSize: fontSizeNotifier.value,
          fontFamily: fontFamily,
          height: 1.8,
        ),
      ),
    ];

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedParagraphIndex = selectedParagraphIndex == index ? -1 : index;
        });
      },
      child: Card(
        color: isSelected ? const Color(0xFFEED9B6) : const Color(0xFFF6EEDB),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: RichText(
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            text: TextSpan(children: spans),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: selectedFontNotifier,
      builder: (context, fontFamilyValue, child) {
        fontFamily = fontFamilyValue; // Update fontFamily when changed

        return Scaffold(
          backgroundColor: const Color(0xFFFFF8F0),
          appBar: AppBar(
            backgroundColor: const Color(0xFFDAC3A7),
            title: Text(
              widget.title,
              style: TextStyle(color: Colors.white, fontFamily: fontFamily),
            ),
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.white),
          ),

          // Main content area
          body:
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(12),
                          itemCount: paragraphs.length,
                          itemBuilder: (context, index) {
                            final paragraph = paragraphs[index];
                            return buildParagraphCard(paragraph, index);
                          },
                        ),
                      ),
                    ],
                  ),

          // Bottom toolbar: share, favorite, settings
          bottomNavigationBar: BottomAppBar(
            color: const Color(0xFFDAC3A7),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Share button (only active when a paragraph is selected)
                  IconButton(
                    icon: const Icon(Icons.share, color: Colors.white),
                    onPressed:
                        selectedParagraphIndex >= 0
                            ? () {
                              Share.share(paragraphs[selectedParagraphIndex]);
                            }
                            : null,
                  ),

                  // Favorite toggle button
                  IconButton(
                    icon: Icon(
                      selectedParagraphIndex >= 0 &&
                              selectedParagraphIndex < paragraphs.length &&
                              favorites.contains(
                                paragraphs[selectedParagraphIndex],
                              )
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.white,
                    ),
                    onPressed:
                        selectedParagraphIndex >= 0
                            ? () async {
                              setState(() {
                                final selected =
                                    paragraphs[selectedParagraphIndex];
                                if (favorites.contains(selected)) {
                                  favorites.remove(selected);
                                } else {
                                  favorites.add(selected);
                                }
                              });
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setStringList('favorites', favorites);
                            }
                            : null,
                  ),

                  // Settings button (opens font settings sheet)
                  IconButton(
                    icon: const Icon(Icons.settings, color: Colors.white),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(24),
                          ),
                        ),
                        builder:
                            (context) => SettingsSheet(
                              onFontFamilyChanged: (newFont) {
                                selectedFontNotifier.value = newFont;
                              },
                              currentFontSize: fontSizeNotifier.value,
                              onFontSizeChanged: (newSize) {
                                setState(() {
                                  fontSizeNotifier.value = newSize;
                                });
                              },
                              currentFontFamily: fontFamily,
                            ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
