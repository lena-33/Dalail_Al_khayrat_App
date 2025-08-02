// Import required packages and dependencies
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // For opening YouTube playlist
import 'package:youtube_player_flutter/youtube_player_flutter.dart'; // For embedded YouTube videos
import '../../global_settings.dart'; // ← Used for dynamic font and size settings

// This page displays explanation of Dalael Al-Khayrat with bio and videos
class DalaelExplanationPage extends StatelessWidget {
  const DalaelExplanationPage({Key? key}) : super(key: key);

  // Helper widget to display section headers with icons
  Widget sectionTitle(IconData icon, String title) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        children: [
          Icon(icon, color: Colors.brown),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget to create YouTube players for each video
  Widget buildYoutubePlayer(String videoId) {
    return YoutubePlayer(
      controller: YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
      ),
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.brown,
    );
  }

  @override
  Widget build(BuildContext context) {
    // List of YouTube video IDs for embedding
    final List<String> videoIds = [
      'QHxA--ukckU',
      'X_87MvS5UQw',
      'v6P-uoulDMc',
      'TUAdVewPxjk',
      'spXV2XOFOes',
      'Rz0NwmbPdSY',
      'tvMQhmbqQ3c',
      'mqfpP2Qt3jw',
      'd3QbvdzLguc',
      'OKmF_iOm-JA',
      'KqNM0sFvcQ8',
      'NryB3AGxXEQ',
      'l7OOlB9K4ww',
      'ybU0BBtHsw4',
      'vNfOVDzQEgE',
      'm_Zh_yuIqzI',
      'jaIm_-TWkBk',
      'WD67TPh8AN4',
      'gx21C59ahzY',
      'qlfT-yHT8jw',
      'XJBULw5xhso',
      'XM-QoKlykPI',
    ];

    return ValueListenableBuilder<String>(
      valueListenable: selectedFontNotifier,
      builder: (context, fontFamily, _) {
        return ValueListenableBuilder<double>(
          valueListenable: fontSizeNotifier,
          builder: (context, fontSize, _) {
            return Scaffold(
              backgroundColor: const Color(0xFFF5F5DC),
              // AppBar
              appBar: AppBar(
                backgroundColor: const Color(0xFFDAC3A7),
                elevation: 0,
                iconTheme: const IconThemeData(color: Colors.white),
                title: Text(
                  'شرح دلائل الخيرات',
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: fontSize,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
              ),
              // Main content
              body: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Section heading
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      ':شرح دلائل الخيرات للدكتور يسري جبر',
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: fontSize + 1,
                        color: Colors.brown,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  // Section 1: Bio - Birth and Background
                  sectionTitle(Icons.calendar_today, 'المولد والنشأة'),
                  const SizedBox(height: 8),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      'ولد في حي روض الفرج بالقاهرة ۲۳ / ٩ / ۱٩٥٤ ، تلقى التعليم بالمدارس الحكومية حتى التحق بكلية الطب جامعة القاهرة، وتخرج فيها بتقدير جيد جدًا مع مرتبة الشرف ديسمبر ۱٩٧۸م ، وحصل على ماجستير الجراحة العامة وجراحة الأوعية الدموية من جامعة القاهرة نوفمبر ۱٩۸۳ م ، ثم حصل على دكتوراه الجراحة العامة من جامعة القاهرة مايو ۱٩٩۱م، وزمالة جمعية الجراحين الدولية في مايو ۱٩٩۲م، ثم التحق بكلية الشريعة والقانون جامعة الأزهر ۱٩٩۲م ، وحصل على ليسانس الشريعة الإسلامية بتقدير جيد جدًا ۱٩٩۸م.',
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: fontSize,
                        height: 1.8,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Section 2: Quran memorization
                  sectionTitle(Icons.menu_book, 'حفظ القرآن الكريم'),
                  const SizedBox(height: 8),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      'بدأ حفظ القرآن الكريم برواية حفص عن عاصم أثناء دراسته بكلية الطب على يد فضيلة الشيخ عبد الحكيم بن عبد السلام خاطر، وختمه حفظًا عام ۱٩۸٥ م، وعلى يد الشيخ محمد آدم، وختم على الشيخ محمد بدوي السيد بالسند المتصل إلى حفص الذي قرأ على عاصم بن أبي النجود عن أبي عبد الرحمن عبد الله بن حبيب السلمي وزر بن حبيش – الأول عن عثمان بن عفان وعلي بن أبي طالب وأبي بن كعب وزيد بن ثابت وعبد الله بن مسعود رضي الله عنهم ، والثاني عن عثمان بن عفان وعبد الله بن مسعود رضي الله عنهما – وهم عن النبي صلى الله عليه وسلم سيد الأنام وخاتم المرسلين عن أمين الوحي جبريل عليه السلام عن اللوح المحفوظ عن رب العزة سبحانه وتعالى جل جلاله وتقدست أسماؤه.',
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: fontSize,
                        height: 1.8,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Section 3: YouTube Playlist & Link
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          '📺 يمكنك مشاهدة الشرح الكامل من خلال الفيديوهات التالية:',
                          style: TextStyle(
                            fontFamily: fontFamily,
                            fontSize: fontSize,
                            height: 1.8,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Clickable YouTube playlist link
                        GestureDetector(
                          onTap: () async {
                            final url =
                                'https://youtube.com/playlist?list=PLEkQk5xrP-tlAzcbIpuqjdFICW-knvTlR&si=fVDouQrntRal3gVt';
                            if (await canLaunchUrl(Uri.parse(url))) {
                              await launchUrl(
                                Uri.parse(url),
                                mode: LaunchMode.externalApplication,
                              );
                            }
                          },
                          child: Text(
                            'رابط قائمة التشغيل على اليوتيوب',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontFamily: fontFamily,
                              fontSize: fontSize,
                              height: 1.8,
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  ...videoIds.map(
                    (id) => Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: buildYoutubePlayer(id),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
