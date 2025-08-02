// Import required Dart and Flutter libraries
import 'dart:convert'; // For decoding JSON
import 'package:flutter/services.dart'; // For loading asset files

// Model class representing a Zikr (remembrance phrase)
class Zikr {
  final String arabicText; // Arabic version of the Zikr
  final String englishTranslation; // English translation

  Zikr({required this.arabicText, required this.englishTranslation});

  // Factory method to create a Zikr from a JSON map
  factory Zikr.fromJson(Map<String, dynamic> json) {
    return Zikr(
      arabicText: json['arabic'], // e.g., "سُبْحَانَ الله"
      englishTranslation: json['translation'], // e.g., "Glory be to Allah"
    );
  }
}

// Service class responsible for loading and parsing Zikr data
class ZikrService {
  // Loads the JSON file and returns a list of Zikr objects
  Future<List<Zikr>> loadZikrData() async {
    // Load JSON content from the asset file
    final String jsonString = await rootBundle.loadString(
      'assets/data/azkar_data.json',
    );

    // Decode the JSON string to a dynamic list
    final List<dynamic> jsonData = json.decode(jsonString);

    // Map each item to a Zikr instance and return the list
    return jsonData.map((item) => Zikr.fromJson(item)).toList();
  }
}
