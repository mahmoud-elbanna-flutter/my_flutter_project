import 'package:flutter/material.dart';

import 'Onboarding/Presentation/Screens/splash.dart';

void main() {
  runApp(const BriefUpApp());
}

class BriefUpApp extends StatelessWidget {
  const BriefUpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BriefUp News',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const SplashScreen(),
    );
  }
}