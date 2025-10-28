import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/main.dart';

class NavigationBars extends ConsumerWidget {
  final Function(String) onNavigate;

  const NavigationBars({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSection = ref.watch(selectedSectionProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isMobile = width < 600;
        final isTablet = width >= 600 && width < 1024;

        if (isMobile) {
          // Mobile: Hamburger menu
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: const Color(0xFF000000).withValues(alpha: 0.9),
              border: Border(
                bottom: BorderSide(
                  color: const Color(0xFF00FF00).withValues(alpha: 0.5),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '</Dev>',
                  style: TextStyle(
                    color: Color(0xFF00FF00),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                PopupMenuButton<String>(
                  icon: const Icon(
                    Icons.menu,
                    color: Color(0xFF00FF00),
                  ),
                  color: const Color(0xFF0A0A0A),
                  onSelected: onNavigate,
                  itemBuilder: (context) {
                    return ['home', 'about', 'projects', 'contact'].map((section) {
                      final isSelected = selectedSection == section;
                      return PopupMenuItem<String>(
                        value: section,
                        child: Text(
                          section,
                          style: TextStyle(
                            color: isSelected
                                ? const Color(0xFF00FF00)
                                : const Color(0xFF33FF33),
                            fontSize: 16,
                          ),
                        ),
                      );
                    }).toList();
                  },
                ),
              ],
            ),
          );
        }

        // Tablet and Desktop: Full navigation
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 30 : 40,
            vertical: 20,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF000000).withValues(alpha: 0.9),
            border: Border(
              bottom: BorderSide(
                color: const Color(0xFF00FF00).withValues(alpha: 0.5),
                width: 1,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '</Developer>',
                style: TextStyle(
                  color: const Color(0xFF00FF00),
                  fontSize: isTablet ? 18 : 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: ['home', 'about', 'projects', 'contact'].map((section) {
                  final isSelected = selectedSection == section;
                  return Padding(
                    padding: EdgeInsets.only(left: isTablet ? 20 : 30),
                    child: TextButton(
                      onPressed: () => onNavigate(section),
                      child: Text(
                        section,
                        style: TextStyle(
                          color: isSelected
                              ? const Color(0xFF00FF00)
                              : const Color(0xFF33FF33),
                          fontSize: isTablet ? 14 : 16,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}






// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:portfolio/main.dart';

// class NavigationBars extends ConsumerWidget {
//   final Function(String) onNavigate;

//   const NavigationBars({super.key, required this.onNavigate});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedSection = ref.watch(selectedSectionProvider);

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
//       decoration: BoxDecoration(
//         color: const Color(0xFF000000).withValues(alpha:0.9),
//         border: Border(
//           bottom: BorderSide(
//             color: const Color(0xFF00FF00).withValues(alpha:0.5),
//             width: 1,
//           ),
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           const Text(
//             '</Developer>',
//             style: TextStyle(
//               color: Color(0xFF00FF00),
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           Row(
//             children: ['home', 'about', 'projects', 'contact'].map((section) {
//               final isSelected = selectedSection == section;
//               return Padding(
//                 padding: const EdgeInsets.only(left: 30),
//                 child: TextButton(
//                   onPressed: () => onNavigate(section),
//                   child: Text(
//                     section,
//                     style: TextStyle(
//                       color: isSelected ? const Color(0xFF00FF00) : const Color(0xFF33FF33),
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//               );
//             }).toList(),
//           ),
//         ],
//       ),
//     );
//   }
// }





