import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/workout_controller.dart';
import '../../models/workout_program_model.dart';

class WorkoutRecommendationsScreen extends StatelessWidget {
  final WorkoutController workoutController = Get.find<WorkoutController>();

  WorkoutRecommendationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('추천 운동 프로그램'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Obx(
        () => workoutController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: workoutController.recommendedPrograms.length,
                itemBuilder: (context, index) {
                  final program = workoutController.recommendedPrograms[index];
                  return WorkoutProgramCard(program: program);
                },
              ),
      ),
    );
  }
}

class WorkoutProgramCard extends StatelessWidget {
  final WorkoutProgram program;

  const WorkoutProgramCard({
    super.key,
    required this.program,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.asset(
              program.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  program.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  program.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Chip(
                      label: Text(program.difficulty),
                      backgroundColor: _getDifficultyColor(program.difficulty),
                    ),
                    const SizedBox(width: 8),
                    Chip(
                      label: Text(program.targetMuscleGroup),
                    ),
                    const SizedBox(width: 8),
                    Chip(
                      label: Text('${program.estimatedDuration}분'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // TODO: 프로그램 상세 페이지로 이동
                    Get.toNamed('/workout-detail', arguments: program);
                  },
                  child: const Text('자세히 보기'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case 'beginner':
        return Colors.green.shade100;
      case 'intermediate':
        return Colors.orange.shade100;
      case 'advanced':
        return Colors.red.shade100;
      default:
        return Colors.grey.shade100;
    }
  }
} 