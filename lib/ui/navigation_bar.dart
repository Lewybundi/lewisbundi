
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/main.dart';

class NavigationBars extends ConsumerWidget {
  final Function(String) onNavigate;

  const NavigationBars({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSection = ref.watch(selectedSectionProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF000000).withValues(alpha:0.9),
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFF00FF00).withValues(alpha:0.5),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            '</Developer>',
            style: TextStyle(
              color: Color(0xFF00FF00),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: ['home', 'about', 'projects', 'contact'].map((section) {
              final isSelected = selectedSection == section;
              return Padding(
                padding: const EdgeInsets.only(left: 30),
                child: TextButton(
                  onPressed: () => onNavigate(section),
                  child: Text(
                    section,
                    style: TextStyle(
                      color: isSelected ? const Color(0xFF00FF00) : const Color(0xFF33FF33),
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}





