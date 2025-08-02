Dalail al-Khayrat – Flutter Mobile App

Dalail al-Khayrat is a spiritual mobile application developed in Flutter that provides users with access to the blessed book Dalail al-Khayrat, along with other useful features such as supplications, names of Allah and the Prophet ﷺ, a tasbeeh counter, daily Wird tracking, and more — all designed with simplicity, beauty, and ease of use for Arabic-speaking users.


---

🌟 Features

📖 Full access to selected Hizbs and supplications from Dalail al-Khayrat

💬 Paragraph-by-paragraph reading with the ability to:

Adjust font family and size

Share any paragraph as text

Mark favorite paragraphs


🌙 Daily Wird Tracker with date-based logging

📿 Tasbeeh counter with reset confirmation

🎨 Custom Arabic fonts (Uthmanic, Andalusi, Monadi, Tasees)

🧭 Elegant RTL layout with spiritual design aesthetics

🔒 Offline access (no internet required)



---

🛠 Built With

Flutter & Dart

share_plus, shared_preferences, youtube_player_flutter

Custom JSON files for Arabic texts

Manual widget testing



---

📂 Project Structure

lib/
├── pages/
│   ├── home_page.dart
│   ├── detail_page.dart
│   ├── favorites_page.dart
│   ├── daily_wird_tracker_page.dart
│   ├── tasbeeh_counter_page.dart
│   ├── dalael_intro_page.dart
│   ├── dalael_explanation_page.dart
│   └── dalael_menu_page.dart
├── services/
│   └── ziker_service.dart
├── settings_sheet.dart
├── global_settings.dart
└── main.dart

assets/
├── data/
│   └── azkar_data.json
├── fonts/
├── images/
│   └── beige_pattern.png
└── texts/
    └── *.txt
