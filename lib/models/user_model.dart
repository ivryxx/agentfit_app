class User {
  final String id;
  final String email;
  final String name;
  String? profileImage;
  int? height;
  int? weight;
  String? fitnessGoal;

  User({
    required this.id,
    required this.email,
    required this.name,
    this.profileImage,
    this.height,
    this.weight,
    this.fitnessGoal,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      profileImage: json['profileImage'],
      height: json['height'],
      weight: json['weight'],
      fitnessGoal: json['fitnessGoal'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'profileImage': profileImage,
      'height': height,
      'weight': weight,
      'fitnessGoal': fitnessGoal,
    };
  }
} 