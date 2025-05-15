import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';

class SignupScreen extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원가입'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
              const SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: '이름',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),
              Obx(() => ElevatedButton(
                    onPressed: authController.isLoading.value
                        ? null
                        : () {
                            authController.signUp(
                              emailController.text,
                              passwordController.text,
                              nameController.text,
                            );
                          },
                    child: authController.isLoading.value
                        ? const CircularProgressIndicator()
                        : const Text('회원가입'),
                  )),
            ],
          ),
        ),
      ),
    );
  }
} 