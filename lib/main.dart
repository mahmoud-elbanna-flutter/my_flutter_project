import 'package:flutter/material.dart';

import 'splash/splash_screen.dart';

void main() {
  runApp(const BriefUpApp());
}

class BriefUpApp extends StatelessWidget {
  const BriefUpApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'BriefUp News',

      theme: ThemeData(
        useMaterial3: true,
      ),

      home: const SplashScreen(),
    );
  }
}