import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controllers/workout_record_controller.dart';
import '../../models/workout_record_model.dart';

class WorkoutRecordsScreen extends StatelessWidget {
  final WorkoutRecordController recordController = Get.find<WorkoutRecordController>();

  WorkoutRecordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('운동 기록'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Get.toNamed('/add-workout-record'),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildStatisticsCard(context),
          Expanded(
            child: Obx(() {
              if (recordController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (recordController.workoutRecords.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.fitness_center, size: 64, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text(
                        '아직 운동 기록이 없습니다.',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () => Get.toNamed('/add-workout-record'),
                        child: const Text('운동 기록 추가하기'),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: recordController.workoutRecords.length,
                itemBuilder: (context, index) {
                  final record = recordController.workoutRecords[index];
                  return _buildWorkoutRecordCard(context, record);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsCard(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem(
              context,
              '총 운동 시간',
              '${recordController.getTotalWorkoutDuration()}분',
            ),
            _buildStatItem(
              context,
              '소모 칼로리',
              '${recordController.getTotalCaloriesBurned().toStringAsFixed(1)}kcal',
            ),
            _buildStatItem(
              context,
              '운동 횟수',
              '${recordController.workoutRecords.length}회',
            ),
          ],
        )),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }

  Widget _buildWorkoutRecordCard(BuildContext context, WorkoutRecord record) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        title: Text(record.workoutName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(DateFormat('yyyy-MM-dd HH:mm').format(record.date)),
            Text('운동 시간: ${record.duration}분 • 소모 칼로리: ${record.caloriesBurned}kcal'),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () => _showRecordOptions(context, record),
        ),
        onTap: () => Get.toNamed('/workout-record-detail', arguments: record),
      ),
    );
  }

  void _showRecordOptions(BuildContext context, WorkoutRecord record) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('수정하기'),
              onTap: () {
                Navigator.pop(context);
                Get.toNamed('/edit-workout-record', arguments: record);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('삭제하기', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                _showDeleteConfirmation(context, record);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, WorkoutRecord record) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('운동 기록 삭제'),
        content: const Text('이 운동 기록을 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              recordController.deleteWorkoutRecord(record.id);
            },
            child: const Text('삭제', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
} 