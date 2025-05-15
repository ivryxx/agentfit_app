class Exercise {
  final String name;
  final String description;
  final String imageUrl;
  final int sets;
  final int reps;
  final int restTime; // 초 단위

  Exercise({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.sets,
    required this.reps,
    required this.restTime,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      sets: json['sets'],
      reps: json['reps'],
      restTime: json['restTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'sets': sets,
      'reps': reps,
      'restTime': restTime,
    };
  }
}

class WorkoutProgram {
  final String id;
  final String name;
  final String description;
  final String difficulty; // 'beginner', 'intermediate', 'advanced'
  final String targetMuscleGroup;
  final List<Exercise> exercises;
  final int estimatedDuration; // 분 단위
  final String imageUrl;

  WorkoutProgram({
    required this.id,
    required this.name,
    required this.description,
    required this.difficulty,
    required this.targetMuscleGroup,
    required this.exercises,
    required this.estimatedDuration,
    required this.imageUrl,
  });

  factory WorkoutProgram.fromJson(Map<String, dynamic> json) {
    return WorkoutProgram(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      difficulty: json['difficulty'],
      targetMuscleGroup: json['targetMuscleGroup'],
      exercises: (json['exercises'] as List)
          .map((e) => Exercise.fromJson(e))
          .toList(),
      estimatedDuration: json['estimatedDuration'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'difficulty': difficulty,
      'targetMuscleGroup': targetMuscleGroup,
      'exercises': exercises.map((e) => e.toJson()).toList(),
      'estimatedDuration': estimatedDuration,
      'imageUrl': imageUrl,
    };
  }
} 