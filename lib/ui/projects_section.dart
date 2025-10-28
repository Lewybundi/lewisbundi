
// projects_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/provider/projects_provider.dart';
import 'package:portfolio/ui/project_card.dart';

class ProjectsSection extends ConsumerWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projects = ref.watch(projectsProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        int crossAxisCount;
        double childAspectRatio;
        double horizontalPadding;
        double spacing;

        if (width < 600) {
          // Mobile
          crossAxisCount = 1;
          childAspectRatio = 0.85;
          horizontalPadding = 20;
          spacing = 20;
        } else if (width < 1024) {
          // Tablet
          crossAxisCount = 2;
          childAspectRatio = 1.0;
          horizontalPadding = 30;
          spacing = 25;
        } else {
          // Desktop
          crossAxisCount = 2;
          childAspectRatio = 1.2;
          horizontalPadding = 40;
          spacing = 30;
        }

        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: width < 600 ? 60 : 100,
          ),
          child: Column(
            children: [
              Text(
                '<projects/>',
                style: TextStyle(
                  fontSize: width < 600 ? 28 : 36,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF00FF00),
                ),
              ),
              SizedBox(height: width < 600 ? 40 : 60),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: spacing,
                  mainAxisSpacing: spacing,
                  childAspectRatio: childAspectRatio,
                ),
                itemCount: projects.length,
                itemBuilder: (context, index) {
                  final project = projects[index];
                  return ProjectCard(
                    title: project.title,
                    description: project.description,
                    tech: project.technologies,
                    imageUrl: project.imageUrl,
                    githubUrl: project.githubUrl,
                    liveUrl: project.liveUrl,
                  );
                },
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
// import 'package:portfolio/provider/projects_provider.dart';
// import 'package:portfolio/ui/project_card.dart';

// class ProjectsSection extends ConsumerWidget {
//   const ProjectsSection({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final projects = ref.watch(projectsProvider);

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 100),
//       child: Column(
//         children: [
//           const Text(
//             '<projects/>',
//             style: TextStyle(
//               fontSize: 36,
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF00FF00),
//             ),
//           ),
//           const SizedBox(height: 60),
//           GridView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               crossAxisSpacing: 30,
//               mainAxisSpacing: 30,
//               childAspectRatio: 1.2,
//             ),
//             itemCount: projects.length,
//             itemBuilder: (context, index) {
//               final project = projects[index];
//               return ProjectCard(
//                 title: project.title,
//                 description: project.description,
//                 tech: project.technologies,
//                 imageUrl: project.imageUrl,
//                 githubUrl: project.githubUrl,
//                 liveUrl: project.liveUrl,
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }