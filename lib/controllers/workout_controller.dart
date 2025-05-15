import 'package:get/get.dart';
import '../models/workout_program_model.dart';
import '../models/user_model.dart';

class WorkoutController extends GetxController {
  final RxList<WorkoutProgram> recommendedPrograms = <WorkoutProgram>[].obs;
  final RxBool isLoading = false.obs;

  // 사용자의 목표와 신체 정보에 기반한 운동 프로그램 추천
  Future<void> getRecommendedPrograms(User user) async {
    try {
      isLoading.value = true;
      
      // TODO: 실제 API 호출로 대체
      // 임시 데모 데이터
      final demoExercise = Exercise(
        name: '푸시업',
        description: '가슴과 삼두근을 강화하는 기본적인 운동입니다.',
        imageUrl: 'assets/images/pushup.jpg',
        sets: 3,
        reps: 10,
        restTime: 60,
      );

      final demoProgram = WorkoutProgram(
        id: '1',
        name: '초보자를 위한 상체 운동',
        description: '처음 시작하는 분들을 위한 상체 운동 프로그램입니다.',
        difficulty: 'beginner',
        targetMuscleGroup: '상체',
        exercises: [demoExercise],
        estimatedDuration: 30,
        imageUrl: 'assets/images/upper_body.jpg',
      );

      recommendedPrograms.value = [demoProgram];
      
    } catch (e) {
      Get.snackbar('오류', '운동 프로그램을 불러오는데 실패했습니다.');
    } finally {
      isLoading.value = false;
    }
  }

  // 운동 난이도에 따른 프로그램 필터링
  List<WorkoutProgram> filterByDifficulty(String difficulty) {
    return recommendedPrograms
        .where((program) => program.difficulty == difficulty)
        .toList();
  }

  // 목표 근육 그룹에 따른 프로그램 필터링
  List<WorkoutProgram> filterByMuscleGroup(String muscleGroup) {
    return recommendedPrograms
        .where((program) => program.targetMuscleGroup == muscleGroup)
        .toList();
  }
} 