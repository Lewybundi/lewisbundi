import 'package:flutter/material.dart';

class SkillChip extends StatelessWidget {
  final String skill;

  const SkillChip({super.key, required this.skill});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final parentWidth = MediaQuery.of(context).size.width;
        final isMobile = parentWidth < 600;
        
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 12 : 16,
            vertical: isMobile ? 6 : 8,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF00FF00).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFF00FF00),
            ),
          ),
          child: Text(
            skill,
            style: TextStyle(
              color: const Color(0xFF00FF00),
              fontSize: isMobile ? 12 : 14,
            ),
          ),
        );
      },
    );
  }
}
