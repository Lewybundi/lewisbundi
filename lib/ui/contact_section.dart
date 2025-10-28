import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/provider/projects_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:portfolio/ui/contact_button.dart';

class ContactSection extends ConsumerStatefulWidget {
  const ContactSection({super.key});

  @override
  ConsumerState<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends ConsumerState<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isLoading = false;
  bool _showForm = false;

  // EmailJS Configuration
  static const String _emailJSPublicKey = '0nkmvYpNGGV5dgNJv';
  static const String _emailJSServiceId = 'service_gih5brd';
  static const String _emailJSTemplateId = 'template_w4jg7ps';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final personalInfo = ref.watch(personalInfoProvider);
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 800;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 100),
      child: Column(
        children: [
          const Text(
            '<contact/>',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Color(0xFF00FF00),
            ),
          ),
          const SizedBox(height: 60),
          const Text(
            'Let\'s work together!',
            style: TextStyle(
              fontSize: 24,
              color: Color(0xFF33FF33),
            ),
          ),
          const SizedBox(height: 40),
          
          // Social buttons
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              ContactButton(
                icon: Icons.code,
                label: 'GitHub',
                onPressed: () => _launchUrl(personalInfo.github??''),
              ),
              ContactButton(
                icon: Icons.work,
                label: 'LinkedIn',
                onPressed: () => _launchUrl(personalInfo.linkedIn??''),
              ),
              if (personalInfo.twitter != null)
                ContactButton(
                  icon: Icons.alternate_email,
                  label: 'Twitter',
                  onPressed: () => _launchUrl(personalInfo.twitter!),
                ),
            ],
          ),
          
          const SizedBox(height: 60),
          
          // Toggle form button
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                _showForm = !_showForm;
              });
            },
            icon: Icon(_showForm ? Icons.close : Icons.send),
            label: Text(_showForm ? 'Close Form' : 'Send Message'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00FF00),
              foregroundColor: const Color(0xFF000000),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          
          // Contact Form
          if (_showForm) ...[
            const SizedBox(height: 40),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isMobile ? double.infinity : 600,
              ),
              child: _buildContactForm(context),
            ),
          ],
          
          // Contact Info
          const SizedBox(height: 60),
          _buildContactInfo(context, personalInfo, isMobile),
        ],
      ),
    );
  }

  Widget _buildContactInfo(BuildContext context, personalInfo, bool isMobile) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.black..withValues(alpha:0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF00FF00).withValues(alpha:0.3),
        ),
      ),
      child: Column(
        children: [
          const Text(
            'Contact Information',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF00FF00),
            ),
          ),
          const SizedBox(height: 30),
          Wrap(
            spacing: 40,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              _buildInfoItem(Icons.email, personalInfo.email),
              if (personalInfo.phone != null)
                _buildInfoItem(Icons.phone, personalInfo.phone!),
              if (personalInfo.location != null)
                _buildInfoItem(Icons.location_on, personalInfo.location!),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: const Color(0xFF00FF00),
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            color: Color(0xFF33FF33),
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildContactForm(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha:0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF00FF00)..withValues(alpha:0.3),
        ),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Send me a message',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00FF00),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _nameController,
              style: const TextStyle(color: Color(0xFF00FF00)),
              decoration: InputDecoration(
                labelText: 'Your Name',
                labelStyle: const TextStyle(color: Color(0xFF33FF33)),
                prefixIcon: const Icon(Icons.person, color: Color(0xFF00FF00)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF00FF00)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: const Color(0xFF00FF00).withValues(alpha:0.5)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF00FF00), width: 2),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              style: const TextStyle(color: Color(0xFF00FF00)),
              decoration: InputDecoration(
                labelText: 'Your Email',
                labelStyle: const TextStyle(color: Color(0xFF33FF33)),
                prefixIcon: const Icon(Icons.email, color: Color(0xFF00FF00)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF00FF00)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: const Color(0xFF00FF00).withValues(alpha:0.5)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF00FF00), width: 2),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!value.contains('@')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _messageController,
              maxLines: 5,
              style: const TextStyle(color: Color(0xFF00FF00)),
              decoration: InputDecoration(
                labelText: 'Your Message',
                labelStyle: const TextStyle(color: Color(0xFF33FF33)),
                prefixIcon: const Icon(Icons.message, color: Color(0xFF00FF00)),
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF00FF00)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: const Color(0xFF00FF00).withValues(alpha:0.5)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF00FF00), width: 2),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your message';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _sendMessage,
              icon: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                      ),
                    )
                  : const Icon(Icons.send),
              label: Text(
                _isLoading ? 'Sending...' : 'Send Message',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00FF00),
                foregroundColor: const Color(0xFF000000),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendMessage() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _sendEmailWithEmailJS();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Message sent successfully! I\'ll get back to you soon.',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: const Color(0xFF00FF00),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );

        // Clear the form
        _nameController.clear();
        _emailController.clear();
        _messageController.clear();
        
        setState(() {
          _showForm = false;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Failed to send message. Please try again or contact me directly.',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _sendEmailWithEmailJS() async {
    const String emailJSUrl = 'https://api.emailjs.com/api/v1.0/email/send';

    final Map<String, dynamic> templateParams = {
      'from_name': _nameController.text.trim(),
      'from_email': _emailController.text.trim(),
      'message': _messageController.text.trim(),
      'to_name': 'Lewis Bundi',
      'reply_to': _emailController.text.trim(),
    };

    final Map<String, dynamic> emailData = {
      'service_id': _emailJSServiceId,
      'template_id': _emailJSTemplateId,
      'user_id': _emailJSPublicKey,
      'template_params': templateParams,
    };

    final response = await http.post(
      Uri.parse(emailJSUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(emailData),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to send email: ${response.statusCode}');
    }
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
