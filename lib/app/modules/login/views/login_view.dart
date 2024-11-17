import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/controllers/auth_controller.dart';
import 'package:myapp/app/modules/allbrand/views/allbrand_view.dart'; // Import halaman AllbrandView

class LoginScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')), 
      body: Obx(() {
        return Center(
          child: SingleChildScrollView( // Tambahkan ScrollView jika overflow
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0), // Atur padding horizontal
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Input email
                  Container(
                    width: double.infinity, // Mengatur lebar agar penuh
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(height: 10), // Spasi antar input
                  
                  // Input password
                  Container(
                    width: double.infinity,
                    child: TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.visibility_off), // Ikon untuk visibilitas password
                      ),
                      obscureText: true,
                    ),
                  ),
                  SizedBox(height: 20), // Spasi antar input dan tombol

                  // Tombol Login
                  authController.isLoading.value
                      ? CircularProgressIndicator()
                      : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              bool success = await authController.loginUser(
                                emailController.text,
                                passwordController.text,
                              );
                              if (success) {
                                // Navigasi ke halaman AllbrandView setelah login berhasil
                                Get.to(() => AllbrandView());
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 15),
                            ),
                            child: Text('Login', style: TextStyle(fontSize: 18)),
                          ),
                        ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
