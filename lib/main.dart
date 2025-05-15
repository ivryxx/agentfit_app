import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'controllers/auth_controller.dart';
import 'controllers/workout_controller.dart';
import 'controllers/pose_controller.dart';
import 'views/auth/login_screen.dart';
import 'views/auth/signup_screen.dart';
import 'views/workout/workout_recommendations_screen.dart';
import 'views/pose/pose_analysis_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  
  // 의존성 주입
  Get.put(AuthController());
  Get.put(WorkoutController());
  Get.put(PoseController());
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'AgentFit',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6200EE),
          primary: const Color(0xFF6200EE),
          secondary: const Color(0xFF03DAC6),
        ),
        textTheme: GoogleFonts.notoSansTextTheme(),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/signup', page: () => SignupScreen()),
        GetPage(name: '/home', page: () => const HomeScreen()),
        GetPage(name: '/workout-recommendations', page: () => WorkoutRecommendationsScreen()),
        GetPage(
          name: '/pose-analysis',
          page: () => PoseAnalysisScreen(
            exerciseName: Get.arguments as String,
          ),
        ),
      ],
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    final WorkoutController workoutController = Get.find<WorkoutController>();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('AgentFit'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => authController.signOut(),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to AgentFit',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            Text(
              'Your AI-powered fitness companion',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => Get.toNamed('/workout-recommendations'),
              child: const Text('운동 프로그램 추천 받기'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Get.toNamed('/pose-analysis', arguments: '푸시업'),
              child: const Text('운동 자세 분석하기'),
            ),
          ],
        ),
      ),
    );
  }
}
