import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/controllers/auth_controller.dart';

class RegisterPageView extends StatelessWidget {
  final AuthController _authController = Get.put(AuthController());
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: "Username"),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: "Password"),
            ),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: "Confirm Password"),
            ),
            SizedBox(height: 20),
            Obx(() {
              return ElevatedButton(
                onPressed: _authController.isLoading.value
                    ? null
                    : () {
                        _authController.registerUser(
                          _usernameController.text,
                          _emailController.text,
                          _passwordController.text,
                          _confirmPasswordController.text,
                        );
                      },
                child: _authController.isLoading.value
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      )
                    : Text("Register"),
              );
            }),
          ],
        ),
      ),
    );
  }
}
