import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'AgentFit',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 40),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: '이메일',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: '비밀번호',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 30),
              Obx(() => ElevatedButton(
                    onPressed: authController.isLoading.value
                        ? null
                        : () {
                            authController.signIn(
                              emailController.text,
                              passwordController.text,
                            );
                          },
                    child: authController.isLoading.value
                        ? const CircularProgressIndicator()
                        : const Text('로그인'),
                  )),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => Get.toNamed('/signup'),
                child: const Text('회원가입'),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 