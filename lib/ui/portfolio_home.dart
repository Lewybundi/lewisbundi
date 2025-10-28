import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/provider/provider.dart';
import 'package:portfolio/ui/Hero_section.dart';
import 'package:portfolio/ui/about_section.dart';
import 'package:portfolio/ui/contact_section.dart';
import 'package:portfolio/ui/navigation_bar.dart';
import 'package:portfolio/ui/projects_section.dart';

class PortfolioHome extends ConsumerStatefulWidget {
  const PortfolioHome({super.key});

  @override
  ConsumerState<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends ConsumerState<PortfolioHome> {
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> sectionKeys = {
    'home': GlobalKey(),
    'about': GlobalKey(),
    'projects': GlobalKey(),
    'contact': GlobalKey(),
  };

  void scrollToSection(String section) {
    final context = sectionKeys[section]?.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      ref.read(selectedSectionProvider.notifier).state = section;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              // Background gradient
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF000000),
                      Color(0xFF1A1A1A),
                      Color(0xFF000000),
                    ],
                  ),
                ),
              ),
              // Content
              SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    HeroSection(key: sectionKeys['home'], onNavigate: scrollToSection),
                    AboutSection(key: sectionKeys['about']),
                    ProjectsSection(key: sectionKeys['projects']),
                    ContactSection(key: sectionKeys['contact']),
                  ],
                ),
              ),
              // Navigation Bar
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: NavigationBars(onNavigate: scrollToSection),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}






// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:portfolio/provider/provider.dart';
// import 'package:portfolio/ui/Hero_section.dart';
// import 'package:portfolio/ui/about_section.dart';
// import 'package:portfolio/ui/contact_section.dart';
// import 'package:portfolio/ui/navigation_bar.dart';
// import 'package:portfolio/ui/projects_section.dart';



// class PortfolioHome extends ConsumerStatefulWidget {
//   const PortfolioHome({super.key});

//   @override
//   ConsumerState<PortfolioHome> createState() => _PortfolioHomeState();
// }

// class _PortfolioHomeState extends ConsumerState<PortfolioHome> {
//   final ScrollController _scrollController = ScrollController();
//   final Map<String, GlobalKey> sectionKeys = {
//     'home': GlobalKey(),
//     'about': GlobalKey(),
//     'projects': GlobalKey(),
//     'contact': GlobalKey(),
//   };

//   void scrollToSection(String section) {
//     final context = sectionKeys[section]?.currentContext;
//     if (context != null) {
//       Scrollable.ensureVisible(
//         context,
//         duration: const Duration(milliseconds: 500),
//         curve: Curves.easeInOut,
//       );
//       ref.read(selectedSectionProvider.notifier).state = section;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background gradient
//           Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [
//                   Color(0xFF000000),
//                   Color(0xFF1A1A1A),
//                   Color(0xFF000000),
//                 ],
//               ),
//             ),
//           ),
//           // Content
//           SingleChildScrollView(
//             controller: _scrollController,
//             child: Column(
//               children: [
//                 HeroSection(key: sectionKeys['home'], onNavigate: scrollToSection),
//                 AboutSection(key: sectionKeys['about']),
//                 ProjectsSection(key: sectionKeys['projects']),
//                 ContactSection(key: sectionKeys['contact']),
//               ],
//             ),
//           ),
//           // Navigation Bar
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             child: NavigationBars(onNavigate: scrollToSection),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
// }
