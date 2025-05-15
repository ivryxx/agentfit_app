import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import '../models/pose_analysis_model.dart';

class PoseController extends GetxController {
  CameraController? cameraController;
  final RxBool isAnalyzing = false.obs;
  final RxBool isCameraInitialized = false.obs;
  final Rx<PoseAnalysis?> currentAnalysis = Rx<PoseAnalysis?>(null);
  final RxList<PoseAnalysis> analysisHistory = <PoseAnalysis>[].obs;

  @override
  void onInit() {
    super.onInit();
    initializeCamera();
  }

  @override
  void onClose() {
    cameraController?.dispose();
    super.onClose();
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) {
      Get.snackbar('오류', '사용 가능한 카메라를 찾을 수 없습니다.');
      return;
    }

    // 전면 카메라 사용
    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );

    cameraController = CameraController(
      frontCamera,
      ResolutionPreset.high,
      enableAudio: false,
    );

    try {
      await cameraController!.initialize();
      isCameraInitialized.value = true;
    } catch (e) {
      Get.snackbar('오류', '카메라 초기화에 실패했습니다.');
    }
  }

  Future<void> startPoseAnalysis(String exerciseName) async {
    if (!isCameraInitialized.value) {
      Get.snackbar('오류', '카메라가 준비되지 않았습니다.');
      return;
    }

    isAnalyzing.value = true;

    try {
      // TODO: 실제 API 호출로 대체
      // 임시 데모 분석 결과
      await Future.delayed(const Duration(seconds: 2));
      final analysis = PoseAnalysis(
        exerciseName: exerciseName,
        accuracy: 0.85,
        feedback: [
          '팔꿈치를 더 구부려주세요.',
          '허리를 똑바로 유지하세요.',
        ],
        timestamp: DateTime.now(),
      );

      currentAnalysis.value = analysis;
      analysisHistory.add(analysis);

    } catch (e) {
      Get.snackbar('오류', '자세 분석에 실패했습니다.');
    } finally {
      isAnalyzing.value = false;
    }
  }

  Future<String?> captureFrame() async {
    if (!isCameraInitialized.value) return null;

    try {
      final XFile file = await cameraController!.takePicture();
      final directory = await getApplicationDocumentsDirectory();
      final fileName = 'pose_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final savedPath = path.join(directory.path, fileName);
      
      // 파일 저장
      await file.saveTo(savedPath);
      return savedPath;
    } catch (e) {
      Get.snackbar('오류', '이미지 캡처에 실패했습니다.');
      return null;
    }
  }
} 