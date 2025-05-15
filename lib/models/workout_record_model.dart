class WorkoutRecord {
  final String id;
  final String userId;
  final String workoutName;
  final DateTime date;
  final int duration; // 분 단위
  final List<ExerciseRecord> exercises;
  final double caloriesBurned;
  String? note;

  WorkoutRecord({
    required this.id,
    required this.userId,
    required this.workoutName,
    required this.date,
    required this.duration,
    required this.exercises,
    required this.caloriesBurned,
    this.note,
  });

  factory WorkoutRecord.fromJson(Map<String, dynamic> json) {
    return WorkoutRecord(
      id: json['id'],
      userId: json['userId'],
      workoutName: json['workoutName'],
      date: DateTime.parse(json['date']),
      duration: json['duration'],
      exercises: (json['exercises'] as List)
          .map((e) => ExerciseRecord.fromJson(e))
          .toList(),
      caloriesBurned: json['caloriesBurned'].toDouble(),
      note: json['note'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'workoutName': workoutName,
      'date': date.toIso8601String(),
      'duration': duration,
      'exercises': exercises.map((e) => e.toJson()).toList(),
      'caloriesBurned': caloriesBurned,
      'note': note,
    };
  }
}

class ExerciseRecord {
  final String exerciseName;
  final int sets;
  final List<SetRecord> setRecords;

  ExerciseRecord({
    required this.exerciseName,
    required this.sets,
    required this.setRecords,
  });

  factory ExerciseRecord.fromJson(Map<String, dynamic> json) {
    return ExerciseRecord(
      exerciseName: json['exerciseName'],
      sets: json['sets'],
      setRecords: (json['setRecords'] as List)
          .map((e) => SetRecord.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exerciseName': exerciseName,
      'sets': sets,
      'setRecords': setRecords.map((e) => e.toJson()).toList(),
    };
  }
}

class SetRecord {
  final int reps;
  final double weight; // kg
  final int restTime; // 초 단위

  SetRecord({
    required this.reps,
    required this.weight,
    required this.restTime,
  });

  factory SetRecord.fromJson(Map<String, dynamic> json) {
    return SetRecord(
      reps: json['reps'],
      weight: json['weight'].toDouble(),
      restTime: json['restTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reps': reps,
      'weight': weight,
      'restTime': restTime,
    };
  }
} 