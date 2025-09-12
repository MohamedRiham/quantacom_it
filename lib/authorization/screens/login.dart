import 'package:get/get.dart';
import 'package:quantacom_it/authorization/get_x/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:quantacom_it/authorization/models/user_details.dart';
import 'package:quantacom_it/authorization/screens/register.dart';
import 'package:quantacom_it/common/widgets/custom_scaffold.dart';
import 'package:quantacom_it/common/widgets/custom_text_field.dart';
import 'package:quantacom_it/task/screens/task_list_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final authController = AuthController.instance;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Login',
      body: Obx(() {
        return authController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SafeArea(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,

                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 40),
                          const Text(
                            'Please enter your details',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 32),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text('User Name'),
                          ),
                          CustomTextField(
                            controller: emailController,
                            hintText: 'Email',
                            icon: Icons.person,
                            keyboardType: TextInputType.name,
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Password'),
                          ),

                          const SizedBox(height: 16),
                          CustomTextField(
                            controller: passwordController,
                            hintText: 'Password',
                            icon: Icons.password,
                            keyboardType: TextInputType.visiblePassword,
                            isPassword: true,
                          ),

                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  Login login = Login(
                                    emailAddress: emailController.text,
                                    password: passwordController.text,
                                  );
                                  bool success = await authController.login(
                                    login,
                                  );
                                  if (success) {
                                    Get.off(() => TaskListScreen());
                                  } else {
                                    return;
                                  }
                                }
                              },
                              child: const Text(
                                'Login',
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Center(
                            child: TextButton(
                              onPressed: () {
                                Get.off(() => RegisterScreen());
                              },
                              child: const Text(
                                "Don't have an account? Sign Up",
                                style: TextStyle(
                                  fontSize: 14,

                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              );
      }),
    );
  }
}
