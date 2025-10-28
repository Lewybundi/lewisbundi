import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/provider/projects_provider.dart';
import 'package:portfolio/ui/skill_chip.dart';

class AboutSection extends ConsumerWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personalInfo = ref.watch(personalInfoProvider);
    final skills = ref.watch(skillsProvider);
    final experiences = ref.watch(experiencesProvider);
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 800;

    // Group skills by category
    final skillsByCategory = <String, List<String>>{};
    for (var skill in skills) {
      if (!skillsByCategory.containsKey(skill.category)) {
        skillsByCategory[skill.category] = [];
      }
      skillsByCategory[skill.category]!.add(skill.name);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 100),
      child: Column(
        children: [
          const Text(
            '<about_me/>',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Color(0xFF00FF00),
            ),
          ),
          const SizedBox(height: 60),
          
          // Bio Section
          Container(
            padding: const EdgeInsets.all(30),
            margin: const EdgeInsets.only(bottom: 60),
            decoration: BoxDecoration(
              color: Colors.black..withValues(alpha:0.3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFF00FF00)..withValues(alpha:0.3),
              ),
            ),
            child: Column(
              children: [
                Text(
                  personalInfo.name,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00FFFF),
                  ),
                ),
                const SizedBox(height: 20),
                // Profile Image
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF00FF00),
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF00FF00)..withValues(alpha:0.5),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.network(
                      personalInfo.profileImageUrl??'',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.black,
                          child: const Icon(
                            Icons.person,
                            size: 80,
                            color: Color(0xFF00FF00),
                          ),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: Colors.black,
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                              color: const Color(0xFF00FF00),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  personalInfo.title,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xFF33FF33),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'I\'m a passionate developer specializing in crafting elegant mobile experiences with Flutter and building robust backend systems with Django.  I thrive on solving complex problems and delivering applications that users love. When I\'m not coding, you\'ll find me exploring the latest tech trends,  mentoring aspiring developers in the community.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF33FF33),
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // Experience Section
          if (experiences.isNotEmpty) ...[
            const Text(
              'Experience',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00FFFF),
              ),
            ),
            const SizedBox(height: 30),
            ...experiences.map((exp) => Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.black..withValues(alpha:0.3),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF00FF00)..withValues(alpha:0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          exp.position,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF00FF00),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00FF00).withValues(alpha:0.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          exp.duration,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF00FF00),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    exp.company,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF00FFFF),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    exp.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF33FF33),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            )),
            const SizedBox(height: 40),
          ],

          // Skills Section
          const Text(
            'Skills & Technologies',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF00FFFF),
            ),
          ),
          const SizedBox(height: 30),
          
          if (isMobile)
            // Mobile Layout - Stacked
            Column(
              children: skillsByCategory.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: _buildSkillCategory(entry.key, entry.value),
                );
              }).toList(),
            )
          else
            // Desktop Layout - Side by side
            Wrap(
              spacing: 40,
              runSpacing: 40,
              alignment: WrapAlignment.center,
              children: skillsByCategory.entries.map((entry) {
                return SizedBox(
                  width: (size.width - 160) / 2 - 20,
                  child: _buildSkillCategory(entry.key, entry.value),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildSkillCategory(String category, List<String> skills) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF00FFFF),
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: skills
              .map((skill) => SkillChip(skill: skill))
              .toList(),
        ),
      ],
    );
  }
}
