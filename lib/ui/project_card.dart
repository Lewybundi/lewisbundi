import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCard extends StatefulWidget {
  final String title;
  final String description;
  final List<String> tech;
  final String imageUrl;
  final String? githubUrl;
  final String? liveUrl;

  const ProjectCard({
    super.key,
    required this.title,
    required this.description,
    required this.tech,
    required this.imageUrl,
    this.githubUrl,
    this.liveUrl,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool isHovered = false;

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch $url')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isMobile = width < 350;
        
        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: const Color(0xFF0A0A0A),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isHovered
                    ? const Color(0xFF00FF00)
                    : const Color(0xFF00FF00).withValues(alpha: 0.3),
                width: 2,
              ),
              boxShadow: isHovered
                  ? [
                      BoxShadow(
                        color: const Color(0xFF00FF00).withValues(alpha: 0.3),
                        blurRadius: 20,
                        spreadRadius: 2,
                      )
                    ]
                  : [],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Project Image
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: Image.network(
                    widget.imageUrl,
                    height: isMobile ? 140 : 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: isMobile ? 140 : 180,
                        color: const Color(0xFF1A1A1A),
                        child: Center(
                          child: Icon(
                            Icons.image_not_supported,
                            color: const Color(0xFF00FF00),
                            size: isMobile ? 30 : 40,
                          ),
                        ),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        height: isMobile ? 140 : 180,
                        color: const Color(0xFF1A1A1A),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: const Color(0xFF00FF00),
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(isMobile ? 16 : 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: isMobile ? 16 : 20,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF00FFFF),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: isMobile ? 8 : 12),
                        Flexible(
                          child: Text(
                            widget.description,
                            style: TextStyle(
                              fontSize: isMobile ? 12 : 14,
                              color: const Color(0xFF33FF33),
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: isMobile ? 8 : 12),
                        Flexible(
                          child: Wrap(
                            spacing: isMobile ? 6 : 8,
                            runSpacing: isMobile ? 6 : 8,
                            children: widget.tech
                                .map((t) => Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: isMobile ? 8 : 12,
                                        vertical: isMobile ? 3 : 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF00FF00)
                                            .withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: const Color(0xFF00FF00),
                                        ),
                                      ),
                                      child: Text(
                                        t,
                                        style: TextStyle(
                                          fontSize: isMobile ? 10 : 12,
                                          color: const Color(0xFF00FF00),
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                        SizedBox(height: isMobile ? 12 : 16),
                        // Action Buttons
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (widget.githubUrl != null)
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () => _launchUrl(widget.githubUrl!),
                                  icon: Icon(Icons.code, size: isMobile ? 14 : 16),
                                  label: Text(
                                    'GitHub',
                                    style: TextStyle(fontSize: isMobile ? 11 : 14),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: const Color(0xFF00FF00),
                                    side: const BorderSide(
                                      color: Color(0xFF00FF00),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: isMobile ? 8 : 12,
                                      vertical: isMobile ? 8 : 12,
                                    ),
                                  ),
                                ),
                              ),
                            if (widget.githubUrl != null && widget.liveUrl != null)
                              SizedBox(width: isMobile ? 6 : 8),
                            if (widget.liveUrl != null)
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () => _launchUrl(widget.liveUrl!),
                                  icon: Icon(Icons.launch, size: isMobile ? 14 : 16),
                                  label: Text(
                                    'Live',
                                    style: TextStyle(fontSize: isMobile ? 11 : 14),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: const Color(0xFF00FFFF),
                                    side: const BorderSide(
                                      color: Color(0xFF00FFFF),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: isMobile ? 8 : 12,
                                      vertical: isMobile ? 8 : 12,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// class ProjectCard extends StatefulWidget {
//   final String title;
//   final String description;
//   final List<String> tech;
//   final String imageUrl;
//   final String? githubUrl;
//   final String? liveUrl;

//   const ProjectCard({
//     super.key,
//     required this.title,
//     required this.description,
//     required this.tech,
//     required this.imageUrl,
//     this.githubUrl,
//     this.liveUrl,
//   });

//   @override
//   State<ProjectCard> createState() => _ProjectCardState();
// }

// class _ProjectCardState extends State<ProjectCard> {
//   bool isHovered = false;

//   Future<void> _launchUrl(String url) async {
//     final uri = Uri.parse(url);
//     if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Could not launch $url')),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       onEnter: (_) => setState(() => isHovered = true),
//       onExit: (_) => setState(() => isHovered = false),
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         decoration: BoxDecoration(
//           color: const Color(0xFF0A0A0A),
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//             color: isHovered
//                 ? const Color(0xFF00FF00)
//                 : const Color(0xFF00FF00).withValues(alpha: 0.3),
//             width: 2,
//           ),
//           boxShadow: isHovered
//               ? [
//                   BoxShadow(
//                     color: const Color(0xFF00FF00).withValues(alpha: 0.3),
//                     blurRadius: 20,
//                     spreadRadius: 2,
//                   )
//                 ]
//               : [],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Project Image
//             ClipRRect(
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(10),
//                 topRight: Radius.circular(10),
//               ),
//               child: Image.network(
//                 widget.imageUrl,
//                 height: 180,
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//                 errorBuilder: (context, error, stackTrace) {
//                   return Container(
//                     height: 180,
//                     color: const Color(0xFF1A1A1A),
//                     child: const Center(
//                       child: Icon(
//                         Icons.image_not_supported,
//                         color: Color(0xFF00FF00),
//                         size: 40,
//                       ),
//                     ),
//                   );
//                 },
//                 loadingBuilder: (context, child, loadingProgress) {
//                   if (loadingProgress == null) return child;
//                   return Container(
//                     height: 180,
//                     color: const Color(0xFF1A1A1A),
//                     child: Center(
//                       child: CircularProgressIndicator(
//                         color: const Color(0xFF00FF00),
//                         value: loadingProgress.expectedTotalBytes != null
//                             ? loadingProgress.cumulativeBytesLoaded /
//                                 loadingProgress.expectedTotalBytes!
//                             : null,
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.all(24),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       widget.title,
//                       style: const TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF00FFFF),
//                       ),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(height: 12),
//                     Expanded(
//                       child: Text(
//                         widget.description,
//                         style: const TextStyle(
//                           fontSize: 14,
//                           color: Color(0xFF33FF33),
//                         ),
//                         maxLines: 3,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     Wrap(
//                       spacing: 8,
//                       runSpacing: 8,
//                       children: widget.tech
//                           .map((t) => Container(
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 12,
//                                   vertical: 4,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   color: const Color(0xFF00FF00)
//                                       .withValues(alpha: 0.1),
//                                   borderRadius: BorderRadius.circular(12),
//                                   border: Border.all(
//                                     color: const Color(0xFF00FF00),
//                                   ),
//                                 ),
//                                 child: Text(
//                                   t,
//                                   style: const TextStyle(
//                                     fontSize: 12,
//                                     color: Color(0xFF00FF00),
//                                   ),
//                                 ),
//                               ))
//                           .toList(),
//                     ),
//                     const SizedBox(height: 16),
//                     // Action Buttons
//                     Row(
//                       children: [
//                         if (widget.githubUrl != null)
//                           Expanded(
//                             child: OutlinedButton.icon(
//                               onPressed: () => _launchUrl(widget.githubUrl!),
//                               icon: const Icon(Icons.code, size: 16),
//                               label: const Text('GitHub'),
//                               style: OutlinedButton.styleFrom(
//                                 foregroundColor: const Color(0xFF00FF00),
//                                 side: const BorderSide(
//                                   color: Color(0xFF00FF00),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         if (widget.githubUrl != null && widget.liveUrl != null)
//                           const SizedBox(width: 8),
//                         if (widget.liveUrl != null)
//                           Expanded(
//                             child: OutlinedButton.icon(
//                               onPressed: () => _launchUrl(widget.liveUrl!),
//                               icon: const Icon(Icons.launch, size: 16),
//                               label: const Text('Live'),
//                               style: OutlinedButton.styleFrom(
//                                 foregroundColor: const Color(0xFF00FFFF),
//                                 side: const BorderSide(
//                                   color: Color(0xFF00FFFF),
//                                 ),
//                               ),
//                             ),
//                           ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
