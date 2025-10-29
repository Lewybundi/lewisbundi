
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:portfolio/ui/portfolio_home.dart';

// State Management with Riverpod
final selectedSectionProvider = StateProvider<String>((ref) => 'home');

void main() {
  runApp(const ProviderScope(child: MyPortfolio()));
}

class MyPortfolio extends StatelessWidget {
  const MyPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'JetBrains Mono',
        primaryColor: const Color(0xFF00FF00),
        scaffoldBackgroundColor: const Color(0xFF000000),
      ),
      home: const PortfolioHome(),
    );
  }
}

