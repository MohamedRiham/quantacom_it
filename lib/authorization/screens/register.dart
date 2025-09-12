import 'package:get/get.dart';
import 'package:quantacom_it/authorization/get_x/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:quantacom_it/authorization/models/user_details.dart';
import 'package:quantacom_it/authorization/screens/login.dart';
import 'package:quantacom_it/common/widgets/custom_scaffold.dart';
import 'package:quantacom_it/common/widgets/custom_text_field.dart';
import 'package:quantacom_it/task/screens/task_list_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authController = AuthController.instance;

    return CustomScaffold(
      title: 'Register',
      body: Obx(() {
        return authController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 40),
                          const Text(
                            'Create an Account',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 32),

                          const Text('Email'),
                          CustomTextField(
                            controller: emailController,
                            hintText: 'Email',
                            icon: Icons.email,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 16),

                          const Text('Password'),
                          CustomTextField(
                            controller: passwordController,
                            hintText: 'Password',
                            icon: Icons.lock,
                            keyboardType: TextInputType.visiblePassword,
                            isPassword: true,
                          ),
                          const SizedBox(height: 24),

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  Login login = Login(
                                    emailAddress: emailController.text,
                                    password: passwordController.text,
                                  );
                                  bool result = await authController.register(
                                    login,
                                  );
                                  if (result) {
                                    Get.off(() => TaskListScreen());
                                  } else {
                                    return;
                                  }
                                }
                              },
                              child: const Text(
                                'Sign Up',
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          Center(
                            child: TextButton(
                              onPressed: () {
                                Get.off(() => LoginScreen());
                              },
                              child: const Text(
                                "Already have an account? Login",
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
