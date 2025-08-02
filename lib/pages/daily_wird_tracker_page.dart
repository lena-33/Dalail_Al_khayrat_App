// Import required packages
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // For local storage
import '../global_settings.dart'; // For font and size settings

// This page tracks daily Wird completion status
class DailyWirdTrackerPage extends StatefulWidget {
  const DailyWirdTrackerPage({Key? key}) : super(key: key);

  @override
  State<DailyWirdTrackerPage> createState() => _DailyWirdTrackerPageState();
}

class _DailyWirdTrackerPageState extends State<DailyWirdTrackerPage> {
  Map<String, int> dailyCounts = {}; // Holds daily Wird completions
  String todayKey = ''; // Current date key

  @override
  void initState() {
    super.initState();
    _loadData(); // Load past records and today's status
  }

  // Load Wird records from SharedPreferences
  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    todayKey = '${now.year}-${now.month}-${now.day}'; // Format: YYYY-M-D

    final keys = prefs.getKeys().where((k) => k.startsWith('wird_')).toList();
    final counts = <String, int>{};
    for (var key in keys) {
      counts[key.replaceFirst('wird_', '')] = prefs.getInt(key) ?? 0;
    }

    setState(() {
      dailyCounts = counts;
    });
  }

  // Handle marking today's Wird as completed
  Future<void> _incrementTodayCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final key = 'wird_$todayKey';
    final currentCount = prefs.getInt(key) ?? 0;

    // If already marked, show a confirmation message
    if (currentCount > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'تم تسجيل قراءة الورد مسبقًا اليوم ✅',
            style: TextStyle(fontFamily: selectedFontNotifier.value),
          ),
          backgroundColor: Colors.brown,
        ),
      );
      return;
    }

    // Otherwise, mark as completed and save
    final newCount = currentCount + 1;
    await prefs.setInt(key, newCount);
    setState(() {
      dailyCounts[todayKey] = newCount;
    });
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
              // AppBar with static title
              appBar: AppBar(
                backgroundColor: const Color(0xFFDAC3A7),
                title: const Text(
                  'تتبع وردي اليومي',
                  style: TextStyle(color: Colors.white),
                ),
                centerTitle: true,
                iconTheme: const IconThemeData(color: Colors.white),
              ),

              backgroundColor: const Color(0xFFFFF8E1),

              // Main content
              body: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Display today's date
                    Text(
                      '📆 تاريخ اليوم: $todayKey',
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: fontSize,
                        color: Colors.brown.shade700,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Button to mark today's Wird as read
                    ElevatedButton.icon(
                      onPressed: _incrementTodayCount,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.check, color: Colors.white),
                      label: Text(
                        'تمّ قراءة الورد',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: fontFamily,
                          fontSize: fontSize,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Display either a list of records or a message
                    Expanded(
                      child:
                          dailyCounts.isEmpty
                              ? Center(
                                child: Text(
                                  'لا توجد بيانات بعد ✨',
                                  style: TextStyle(
                                    fontFamily: fontFamily,
                                    fontSize: fontSize,
                                    color: Colors.brown.shade400,
                                  ),
                                ),
                              )
                              : ListView(
                                children:
                                    dailyCounts.entries
                                        .map((entry) {
                                          return Card(
                                            color: Colors.brown.shade50,
                                            child: ListTile(
                                              title: Text(
                                                '📅 ${entry.key}',
                                                style: TextStyle(
                                                  fontFamily: fontFamily,
                                                  fontSize: fontSize,
                                                ),
                                              ),
                                              trailing: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    '✅ ${entry.value} مرة',
                                                    style: TextStyle(
                                                      fontFamily: fontFamily,
                                                      fontSize: fontSize,
                                                    ),
                                                  ),
                                                  if (entry.value >= 3)
                                                    const Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                ],
                                              ),
                                            ),
                                          );
                                        })
                                        .toList()
                                        .reversed
                                        .toList(),
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
