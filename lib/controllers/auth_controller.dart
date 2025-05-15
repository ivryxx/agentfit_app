import 'package:get/get.dart';
import 'package:shared_preferences.dart';
import '../models/user_model.dart';

class AuthController extends GetxController {
  final Rx<User?> user = Rx<User?>(null);
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user');
    if (userData != null) {
      // TODO: Implement user data parsing
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      isLoading.value = true;
      // TODO: Implement sign in logic
    } catch (e) {
      Get.snackbar('오류', '로그인에 실패했습니다.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signUp(String email, String password, String name) async {
    try {
      isLoading.value = true;
      // TODO: Implement sign up logic
    } catch (e) {
      Get.snackbar('오류', '회원가입에 실패했습니다.');
    } finally {
      isLoading.value = false;
    }
  }

  void signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    user.value = null;
    Get.offAllNamed('/login');
  }
} 