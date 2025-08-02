// Import required packages and internal pages
import 'package:flutter/material.dart';
import 'dalael_intro_page.dart'; // Page showing intro about Dalael
import 'dalael_explanation_page.dart'; // Page showing detailed explanation

// This page displays a simple menu to navigate to Dalael intro or explanation
class DalaelMenuPage extends StatelessWidget {
  const DalaelMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E1), // Light beige background
      // AppBar with static title
      appBar: AppBar(
        backgroundColor: const Color(0xFFDAC3A7),
        title: const Text(
          'دلائل الخيرات',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),

      // Body contains two menu items
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // List item: Navigate to Dalael Introduction
          ListTile(
            leading: const Icon(Icons.menu_book, color: Colors.brown),
            title: const Text(
              'تعريف دلائل الخيرات',
              style: TextStyle(
                color: Colors.brown,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DalaelIntroPage(),
                ),
              );
            },
          ),

          const SizedBox(height: 8),

          // List item: Navigate to Dalael Explanation
          ListTile(
            leading: const Icon(Icons.book_outlined, color: Colors.brown),
            title: const Text(
              'شرح دلائل الخيرات',
              style: TextStyle(
                color: Colors.brown,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DalaelExplanationPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
