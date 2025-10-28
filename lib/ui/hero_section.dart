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

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = MediaQuery.of(context).size.height;
        final isMobile = width < 600;
        final isTablet = width >= 600 && width < 1024;

        return Container(
          height: height,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20 : (isTablet ? 30 : 40),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '<hello_world/>',
                    style: TextStyle(
                      color: const Color(0xFF00FF00),
                      fontSize: isMobile ? 14 : 18,
                    ),
                  ),
                  SizedBox(height: isMobile ? 15 : 20),
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Color(0xFF00FF00), Color(0xFF00FFFF)],
                    ).createShader(bounds),
                    child: Text(
                      personalInfo.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isMobile ? 32 : (isTablet ? 48 : 64),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.2,
                      ),
                    ),
                  ),
                  SizedBox(height: isMobile ? 15 : 20),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 0 : 20,
                    ),
                    child: Text(
                      personalInfo.bio,
                      style: TextStyle(
                        fontSize: isMobile ? 14 : (isTablet ? 16 : 20),
                        color: const Color(0xFF33FF33),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: isMobile ? 30 : 40),
                  // Buttons - Stack on mobile, row on larger screens
                  if (isMobile)
                    Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => onNavigate('projects'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF00FF00),
                              foregroundColor: const Color(0xFF000000),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'View Projects',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () => onNavigate('contact'),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFF00FF00)),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Contact Me',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF00FF00),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 20,
                      runSpacing: 15,
                      children: [
                        ElevatedButton(
                          onPressed: () => onNavigate('projects'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00FF00),
                            foregroundColor: const Color(0xFF000000),
                            padding: EdgeInsets.symmetric(
                              horizontal: isTablet ? 30 : 40,
                              vertical: isTablet ? 16 : 20,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'View Projects',
                            style: TextStyle(
                              fontSize: isTablet ? 14 : 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        OutlinedButton(
                          onPressed: () => onNavigate('contact'),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFF00FF00)),
                            padding: EdgeInsets.symmetric(
                              horizontal: isTablet ? 30 : 40,
                              vertical: isTablet ? 16 : 20,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Contact Me',
                            style: TextStyle(
                              fontSize: isTablet ? 14 : 16,
                              color: const Color(0xFF00FF00),
                            ),
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: isMobile ? 30 : 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.code,
                          size: isMobile ? 24 : 32,
                        ),
                        onPressed: () => _launchUrl(personalInfo.github ?? ''),
                        color: const Color(0xFF00FF00),
                        tooltip: 'GitHub',
                      ),
                      SizedBox(width: isMobile ? 15 : 20),
                      IconButton(
                        icon: Icon(
                          Icons.work,
                          size: isMobile ? 24 : 32,
                        ),
                        onPressed: () => _launchUrl(personalInfo.linkedIn ?? ''),
                        color: const Color(0xFF00FF00),
                        tooltip: 'LinkedIn',
                      ),
                      SizedBox(width: isMobile ? 15 : 20),
                      IconButton(
                        icon: Icon(
                          Icons.email,
                          size: isMobile ? 24 : 32,
                        ),
                        onPressed: () =>
                            _launchUrl('mailto:${personalInfo.email}'),
                        color: const Color(0xFF00FF00),
                        tooltip: 'Email',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
