import 'package:get/get.dart';
import 'package:shared_preferences.dart';
import 'dart:convert';
import '../models/workout_record_model.dart';

class WorkoutRecordController extends GetxController {
  final RxList<WorkoutRecord> workoutRecords = <WorkoutRecord>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadWorkoutRecords();
  }

  Future<void> loadWorkoutRecords() async {
    try {
      isLoading.value = true;
      final prefs = await SharedPreferences.getInstance();
      final recordsJson = prefs.getStringList('workout_records') ?? [];
      
      workoutRecords.value = recordsJson
          .map((json) => WorkoutRecord.fromJson(jsonDecode(json)))
          .toList();
      
      // 날짜순으로 정렬
      workoutRecords.sort((a, b) => b.date.compareTo(a.date));
    } catch (e) {
      Get.snackbar('오류', '운동 기록을 불러오는데 실패했습니다.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addWorkoutRecord(WorkoutRecord record) async {
    try {
      isLoading.value = true;
      workoutRecords.insert(0, record);
      await _saveRecords();
      Get.snackbar('성공', '운동 기록이 저장되었습니다.');
    } catch (e) {
      Get.snackbar('오류', '운동 기록 저장에 실패했습니다.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateWorkoutRecord(WorkoutRecord record) async {
    try {
      isLoading.value = true;
      final index = workoutRecords.indexWhere((r) => r.id == record.id);
      if (index != -1) {
        workoutRecords[index] = record;
        await _saveRecords();
        Get.snackbar('성공', '운동 기록이 수정되었습니다.');
      }
    } catch (e) {
      Get.snackbar('오류', '운동 기록 수정에 실패했습니다.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteWorkoutRecord(String recordId) async {
    try {
      isLoading.value = true;
      workoutRecords.removeWhere((record) => record.id == recordId);
      await _saveRecords();
      Get.snackbar('성공', '운동 기록이 삭제되었습니다.');
    } catch (e) {
      Get.snackbar('오류', '운동 기록 삭제에 실패했습니다.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _saveRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final recordsJson = workoutRecords
        .map((record) => jsonEncode(record.toJson()))
        .toList();
    await prefs.setStringList('workout_records', recordsJson);
  }

  // 통계 관련 메서드들
  double getTotalCaloriesBurned() {
    return workoutRecords.fold(0, (sum, record) => sum + record.caloriesBurned);
  }

  int getTotalWorkoutDuration() {
    return workoutRecords.fold(0, (sum, record) => sum + record.duration);
  }

  Map<String, int> getWorkoutFrequencyByName() {
    final frequency = <String, int>{};
    for (final record in workoutRecords) {
      frequency[record.workoutName] = (frequency[record.workoutName] ?? 0) + 1;
    }
    return frequency;
  }
} 