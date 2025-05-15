import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import '../../controllers/pose_controller.dart';

class PoseAnalysisScreen extends StatelessWidget {
  final PoseController poseController = Get.find<PoseController>();
  final String exerciseName;

  PoseAnalysisScreen({super.key, required this.exerciseName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$exerciseName 자세 분석'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Obx(() {
              if (!poseController.isCameraInitialized.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return Stack(
                children: [
                  CameraPreview(poseController.cameraController!),
                  if (poseController.isAnalyzing.value)
                    Container(
                      color: Colors.black54,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                ],
              );
            }),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Obx(() {
                final analysis = poseController.currentAnalysis.value;
                if (analysis == null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '카메라를 통해 운동 자세를 분석합니다.',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: poseController.isAnalyzing.value
                              ? null
                              : () => poseController.startPoseAnalysis(exerciseName),
                          child: const Text('자세 분석 시작'),
                        ),
                      ],
                    ),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '정확도: ${(analysis.accuracy * 100).toStringAsFixed(1)}%',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '피드백:',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: analysis.feedback.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: const Icon(Icons.feedback),
                            title: Text(analysis.feedback[index]),
                          );
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: poseController.isAnalyzing.value
                          ? null
                          : () => poseController.startPoseAnalysis(exerciseName),
                      child: const Text('다시 분석하기'),
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
} 