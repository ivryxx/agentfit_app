class PoseAnalysis {
  final String exerciseName;
  final double accuracy;
  final List<String> feedback;
  final DateTime timestamp;

  PoseAnalysis({
    required this.exerciseName,
    required this.accuracy,
    required this.feedback,
    required this.timestamp,
  });

  factory PoseAnalysis.fromJson(Map<String, dynamic> json) {
    return PoseAnalysis(
      exerciseName: json['exerciseName'],
      accuracy: json['accuracy'].toDouble(),
      feedback: List<String>.from(json['feedback']),
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exerciseName': exerciseName,
      'accuracy': accuracy,
      'feedback': feedback,
      'timestamp': timestamp.toIso8601String(),
    };
  }
} 