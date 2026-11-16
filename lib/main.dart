import 'package:flutter/material.dart';
import 'pages/harmogrow_home_page.dart';

void main() {
  runApp(const HarmoGrowApp());
}

class HarmoGrowApp extends StatelessWidget {
  const HarmoGrowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HarmonyKids - HarmoGrow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E5BB8),
          primary: const Color(0xFF1E5BB8),
          secondary: const Color(0xFF2563EB),
          surface: const Color(0xFFF4F7FC),
        ),
        scaffoldBackgroundColor: const Color(0xFFF4F7FC),
        fontFamily: 'Roboto',
      ),
      // Membungkus tampilan dalam frame mobile (maxWidth 430) agar proporsional saat dibuka di Chrome
      builder: (context, child) {
        return Container(
          color: const Color(0xFFE2E8F0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: ClipRect(child: child!),
            ),
          ),
        );
      },
      home: const HarmoGrowHomePage(),
    );
  }
}
