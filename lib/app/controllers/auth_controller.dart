import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Fungsi untuk login
  Future<bool> loginUser(String email, String password) async {
    isLoading.value = true;

    // Konversi email dan password ke huruf kecil
    email = email.trim().toLowerCase();
    password = password.trim();

    try {
      // Validasi email dan password
      if (email.isEmpty || password.isEmpty) {
        Get.snackbar('Error', 'Email and password are required');
        return false;
      }

      // Proses login menggunakan Firebase
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      isLoading.value = false;

      Get.snackbar('Login', 'Login successful');
      return true; // Login berhasil
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', e.message ?? 'Login failed');
      return false; // Login gagal
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'An unexpected error occurred');
      return false;
    }
  }

  // Fungsi untuk registrasi
  Future<void> registerUser(String username, String email, String password,
      String confirmPassword) async {
    // Validasi input registrasi
    if (username.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      Get.snackbar('Error', 'All fields are required');
      return;
    }

    // Konversi input ke huruf kecil
    username = username.trim().toLowerCase();
    email = email.trim().toLowerCase();

    if (password != confirmPassword) {
      Get.snackbar('Error', 'Passwords do not match');
      return;
    }

    // Validasi format email
    if (!GetUtils.isEmail(email)) {
      Get.snackbar('Error', 'Please enter a valid email address');
      return;
    }

    try {
      // Menampilkan indikator loading
      isLoading.value = true;

      // Registrasi menggunakan Firebase Authentication
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // Setelah registrasi berhasil
      Get.snackbar('Success', 'Registration successful');
      Get.offAllNamed('/login'); // Navigasi ke halaman login
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'Registration failed');
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred');
    } finally {
      isLoading.value = false;
    }
  }

  // Fungsi untuk logout
  void logoutUser() async {
    await _auth.signOut(); // Logout dari Firebase
    Get.snackbar('Logout', 'You have been logged out');
    Get.offAllNamed('/login'); // Navigasi ke halaman login
  }
}
