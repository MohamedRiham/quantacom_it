import 'package:quantacom_it/task/get_x/task_controller.dart';
import 'package:quantacom_it/common/themes/constants/themes.dart';
import 'package:quantacom_it/common/themes/get_x/theme_controller.dart';
import 'package:quantacom_it/authorization/get_x/auth_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quantacom_it/authorization/screens/login.dart';
import 'package:get/get.dart';
import 'package:quantacom_it/task/screens/task_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Get.put(AuthController(), permanent: true);
  Get.put(ThemeController(), permanent: true);
  Get.lazyPut<TaskController>(() => TaskController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final authController = AuthController.instance;

    return Obx(
      () => GetMaterialApp(
        title: 'quantacom_it_practical',
        debugShowCheckedModeBanner: false,
        darkTheme: darkTheme,
        themeMode: themeController.currentTheme,
        theme: lightTheme,

        home: authController.firebaseUser?.value == null
            ? LoginScreen()
            : TaskListScreen(),
      ),
    );
  }
}
