// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:game_flutter/controller/auth/auth_controller.dart';
import 'package:game_flutter/controller/database/database_controller.dart';
import 'package:game_flutter/pages/login.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  // final DatabaseController databaseController = Get.put(DatabaseController());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                // authController.registerUser(
                //     emailController.text, passwordController.text);
              },
              child: Container(
                height: 60,
                width: size.width,
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(16)),
                child: Center(
                    child: Text(
                  "Register",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                )),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: () => Get.to(() => LoginScreen()),
              child: Text(
                "Sudah punya akun? Login",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
