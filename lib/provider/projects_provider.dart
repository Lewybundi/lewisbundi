
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/models/models.dart';

final personalInfoProvider = Provider<PersonalInfo>((ref) {
  return const PersonalInfo(
    name: 'Bundi Lewis',
    title: 'Mobile & Backend Developer',
    bio: 'Flutter in the front, Python in the back, solutions everywhere in between.',
    email: 'lewisbundi037@gmail.com',
    phone: '+254 757 934 457',
    location: 'Meru,Kenya',
    linkedIn: 'https://www.linkedin.com/in/lewis-bundi-6ab216364/',
    github: 'https://github.com/Lewybundi',
    twitter: 'https://x.com/LewyMbuba64673',
    profileImageUrl: 'https://i.postimg.cc/g05NCzw8/IMG1.jpg',
  );
});

final projectsProvider = Provider<List<Project>>((ref) {
  return [
    const Project(
      id: '1',
      title: 'Conned',
      description: 'Community-driven platform helping users report, expose, and learn about scams',
      imageUrl: 'https://i.postimg.cc/2yWvKkq6/conned2-1-2.png',
      technologies: ['Flutter', 'Supabase', 'Riverpod', 'onesignal'],
      liveUrl: 'https://play.google.com/store/apps/details?id=com.LewisBundi.conned',
      isFeatured: true,
    ),
    const Project(
      id: '2',
      title: 'Scambuster',
      description: 'Digital scams exposé api',
      imageUrl: 'https://i.postimg.cc/FsyfwnKT/SL-011823-55360-17.jpg',
      technologies: ['Django', 'Drf'],
      githubUrl: 'https://github.com/Lewybundi/scambuster_drf',
      isFeatured: true,
    ),
    const Project(
      id: '3',
      title: 'RecipeApp',
      description: 'This project showcases a Recipe App that consumes TheMealDB API',
      imageUrl: 'https://i.postimg.cc/BZgbgP7z/food.webp',
      technologies: ['Flutter', 'Riverpod', 'Dio', 'Freezed'],
      githubUrl: 'https://github.com/Lewybundi/RecipeApp-Dio-Riverpod',
    ),
    const Project(
      id: '4',
      title: 'virtual-card',
      description: 'A modern Flutter application for managing contacts with advanced features like business card scanning, OCR text recognition, and comprehensive contact management capabilities.',
      imageUrl: 'https://i.postimg.cc/TYK9vxbT/cardf.png',
      technologies: ['Flutter', 'Sqflite', 'Riverpod'],
      githubUrl: 'https://github.com/Lewybundi/virtual-card-Sqflite',
    ),
    const Project(
      id: '5',
      title: 'Rawg-movies',
      description: 'A Flutter application that uses the RAWG Video Games Database API to display games with search and filtering functionality.',
      imageUrl: 'https://i.postimg.cc/ZKKM1PkJ/rawg.webp',
      technologies: ['Flutter', 'dio', 'Riverpod', 'Freezed'],
      githubUrl: 'https://github.com/Lewybundi/rawg-flutter',
    ),
  ];
});

final experiencesProvider = Provider<List<Experience>>((ref) {
  return [
     const Experience(
      id: '1',
      company: 'Hope Orphanage',
      position: 'Mobile Development Tutor (Volunteer)',
      duration: 'November 2024 - June 2025',
      description: 'Volunteering to teach mobile app development fundamentals to orphanage youth, empowering them with marketable Flutter and programming skills.',
    ),
    const Experience(
      id: '2',
      company: 'Self-Employed.',
      position: 'Backend Developer',
      duration: 'March 2025 - present',
      description: 'Building RESTful APIs with Django REST Framework and curating a diverse GitHub portfolio of technical solutions.',
    ),
  ];
});

final skillsProvider = Provider<List<Skill>>((ref) {
  return [
    const Skill(name: 'Flutter', proficiency: 0.89, category: 'Mobile'),
    const Skill(name: 'Dart', proficiency: 0.90, category: 'Programming'),
    const Skill(name: 'Python', proficiency: 0.80, category: 'Programming'),
    const Skill(name: 'Riverpod', proficiency: 0.85, category: 'State Management'),
    const Skill(name: 'Django', proficiency: 0.80, category: 'Backend'),
    const Skill(name: 'Supabase', proficiency: 0.80, category: 'Backend'),
    const Skill(name: 'REST APIs', proficiency: 0.85, category: 'Backend'),
    const Skill(name: 'Git', proficiency: 0.90, category: 'Tools'),
  ];
});
