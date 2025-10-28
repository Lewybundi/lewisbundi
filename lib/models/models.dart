class Project {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final List<String> technologies;
  final String? githubUrl;
  final String? liveUrl;
  final bool isFeatured;

  const Project({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.technologies,
    this.githubUrl,
    this.liveUrl,
    this.isFeatured = false,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      technologies: List<String>.from(json['technologies'] as List),
      githubUrl: json['githubUrl'] as String?,
      liveUrl: json['liveUrl'] as String?,
      isFeatured: json['isFeatured'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'technologies': technologies,
      'githubUrl': githubUrl,
      'liveUrl': liveUrl,
      'isFeatured': isFeatured,
    };
  }

  Project copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    List<String>? technologies,
    String? githubUrl,
    String? liveUrl,
    bool? isFeatured,
  }) {
    return Project(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      technologies: technologies ?? this.technologies,
      githubUrl: githubUrl ?? this.githubUrl,
      liveUrl: liveUrl ?? this.liveUrl,
      isFeatured: isFeatured ?? this.isFeatured,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Project &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          description == other.description &&
          imageUrl == other.imageUrl &&
          _listEquals(technologies, other.technologies) &&
          githubUrl == other.githubUrl &&
          liveUrl == other.liveUrl &&
          isFeatured == other.isFeatured;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      imageUrl.hashCode ^
      technologies.hashCode ^
      githubUrl.hashCode ^
      liveUrl.hashCode ^
      isFeatured.hashCode;
}

class Experience {
  final String id;
  final String company;
  final String position;
  final String duration;
  final String description;
  final String? companyLogo;

  const Experience({
    required this.id,
    required this.company,
    required this.position,
    required this.duration,
    required this.description,
    this.companyLogo,
  });

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      id: json['id'] as String,
      company: json['company'] as String,
      position: json['position'] as String,
      duration: json['duration'] as String,
      description: json['description'] as String,
      companyLogo: json['companyLogo'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company': company,
      'position': position,
      'duration': duration,
      'description': description,
      'companyLogo': companyLogo,
    };
  }

  Experience copyWith({
    String? id,
    String? company,
    String? position,
    String? duration,
    String? description,
    String? companyLogo,
  }) {
    return Experience(
      id: id ?? this.id,
      company: company ?? this.company,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      description: description ?? this.description,
      companyLogo: companyLogo ?? this.companyLogo,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Experience &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          company == other.company &&
          position == other.position &&
          duration == other.duration &&
          description == other.description &&
          companyLogo == other.companyLogo;

  @override
  int get hashCode =>
      id.hashCode ^
      company.hashCode ^
      position.hashCode ^
      duration.hashCode ^
      description.hashCode ^
      companyLogo.hashCode;
}

class Skill {
  final String name;
  final double proficiency;
  final String category;
  final String? icon;

  const Skill({
    required this.name,
    required this.proficiency,
    required this.category,
    this.icon,
  });

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      name: json['name'] as String,
      proficiency: (json['proficiency'] as num).toDouble(),
      category: json['category'] as String,
      icon: json['icon'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'proficiency': proficiency,
      'category': category,
      'icon': icon,
    };
  }

  Skill copyWith({
    String? name,
    double? proficiency,
    String? category,
    String? icon,
  }) {
    return Skill(
      name: name ?? this.name,
      proficiency: proficiency ?? this.proficiency,
      category: category ?? this.category,
      icon: icon ?? this.icon,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Skill &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          proficiency == other.proficiency &&
          category == other.category &&
          icon == other.icon;

  @override
  int get hashCode =>
      name.hashCode ^
      proficiency.hashCode ^
      category.hashCode ^
      icon.hashCode;
}

class PersonalInfo {
  final String name;
  final String title;
  final String bio;
  final String email;
  final String? phone;
  final String? location;
  final String? linkedIn;
  final String? github;
  final String? twitter;
  final String? profileImageUrl;

  const PersonalInfo({
    required this.name,
    required this.title,
    required this.bio,
    required this.email,
    this.phone,
    this.location,
    this.linkedIn,
    this.github,
    this.twitter,
    this.profileImageUrl,
  });

  factory PersonalInfo.fromJson(Map<String, dynamic> json) {
    return PersonalInfo(
      name: json['name'] as String,
      title: json['title'] as String,
      bio: json['bio'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      location: json['location'] as String?,
      linkedIn: json['linkedIn'] as String?,
      github: json['github'] as String?,
      twitter: json['twitter'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'title': title,
      'bio': bio,
      'email': email,
      'phone': phone,
      'location': location,
      'linkedIn': linkedIn,
      'github': github,
      'twitter': twitter,
      'profileImageUrl': profileImageUrl,
    };
  }

  PersonalInfo copyWith({
    String? name,
    String? title,
    String? bio,
    String? email,
    String? phone,
    String? location,
    String? linkedIn,
    String? github,
    String? twitter,
    String? profileImageUrl,
  }) {
    return PersonalInfo(
      name: name ?? this.name,
      title: title ?? this.title,
      bio: bio ?? this.bio,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      location: location ?? this.location,
      linkedIn: linkedIn ?? this.linkedIn,
      github: github ?? this.github,
      twitter: twitter ?? this.twitter,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonalInfo &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          title == other.title &&
          bio == other.bio &&
          email == other.email &&
          phone == other.phone &&
          location == other.location &&
          linkedIn == other.linkedIn &&
          github == other.github &&
          twitter == other.twitter &&
          profileImageUrl == other.profileImageUrl;

  @override
  int get hashCode =>
      name.hashCode ^
      title.hashCode ^
      bio.hashCode ^
      email.hashCode ^
      phone.hashCode ^
      location.hashCode ^
      linkedIn.hashCode ^
      github.hashCode ^
      twitter.hashCode ^
      profileImageUrl.hashCode;
}

// Helper function for list equality comparison
bool _listEquals<T>(List<T>? a, List<T>? b) {
  if (a == null) return b == null;
  if (b == null || a.length != b.length) return false;
  for (int i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}