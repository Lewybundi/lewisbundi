import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/provider/projects_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HeroSection extends ConsumerWidget {
  final Function(String) onNavigate;

  const HeroSection({super.key, required this.onNavigate});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personalInfo = ref.watch(personalInfoProvider);

    return Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '<hello_world/>',
              style: TextStyle(
                color: Color(0xFF00FF00),
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Color(0xFF00FF00), Color(0xFF00FFFF)],
              ).createShader(bounds),
              child: Text(
                personalInfo.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.2,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              personalInfo.bio,
              style: const TextStyle(
                fontSize: 20,
                color: Color(0xFF33FF33),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => onNavigate('projects'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00FF00),
                    foregroundColor: const Color(0xFF000000),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'View Projects',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 20),
                OutlinedButton(
                  onPressed: () => onNavigate('contact'),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF00FF00)),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Contact Me',
                    style: TextStyle(fontSize: 16, color: Color(0xFF00FF00)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.code, size: 32),
                  onPressed: () => _launchUrl(personalInfo.github??''),
                  color: const Color(0xFF00FF00),
                  tooltip: 'GitHub',
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon: const Icon(Icons.work, size: 32),
                  onPressed: () => _launchUrl(personalInfo.linkedIn??''),
                  color: const Color(0xFF00FF00),
                  tooltip: 'LinkedIn',
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon: const Icon(Icons.email, size: 32),
                  onPressed: () => _launchUrl('mailto:${personalInfo.email}'),
                  color: const Color(0xFF00FF00),
                  tooltip: 'Email',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// class HeroSection extends StatelessWidget {
//   final Function(String) onNavigate;

//   const HeroSection({super.key, required this.onNavigate});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height,
//       padding: const EdgeInsets.symmetric(horizontal: 40),
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               '<hello_world/>',
//               style: TextStyle(
//                 color: Color(0xFF00FF00),
//                 fontSize: 18,
//               ),
//             ),
//             const SizedBox(height: 20),
//             ShaderMask(
//               shaderCallback: (bounds) => const LinearGradient(
//                 colors: [Color(0xFF00FF00), Color(0xFF00FFFF)],
//               ).createShader(bounds),
//               child: const Text(
//                 'Flutter & Django\nDeveloper',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 64,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                   height: 1.2,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               'Building beautiful mobile apps and robust backend systems',
//               style: TextStyle(
//                 fontSize: 20,
//                 color: Color(0xFF33FF33),
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 40),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ElevatedButton(
//                   onPressed: () => onNavigate('projects'),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF00FF00),
//                     foregroundColor: const Color(0xFF000000),
//                     padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: const Text(
//                     'View Projects',
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 const SizedBox(width: 20),
//                 OutlinedButton(
//                   onPressed: () => onNavigate('contact'),
//                   style: OutlinedButton.styleFrom(
//                     side: const BorderSide(color: Color(0xFF00FF00)),
//                     padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: const Text(
//                     'Contact Me',
//                     style: TextStyle(fontSize: 16, color: Color(0xFF00FF00)),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 40),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 IconButton(
//                   icon: const Icon(Icons.code, size: 32),
//                   onPressed: () {},
//                   color: const Color(0xFF00FF00),
//                 ),
//                 const SizedBox(width: 20),
//                 IconButton(
//                   icon: const Icon(Icons.work, size: 32),
//                   onPressed: () {},
//                   color: const Color(0xFF00FF00),
//                 ),
//                 const SizedBox(width: 20),
//                 IconButton(
//                   icon: const Icon(Icons.email, size: 32),
//                   onPressed: () {},
//                   color: const Color(0xFF00FF00),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
