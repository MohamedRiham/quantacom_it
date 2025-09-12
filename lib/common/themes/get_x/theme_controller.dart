import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  Rx<bool> isDarkMode = false.obs;

  late final SharedPreferences prefs;
  ThemeMode get currentTheme => isDarkMode.value ? ThemeMode.dark : ThemeMode.light;



  @override
  void onReady() {
    super.onReady();
    _loadTheme();

  }


  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    _cashTheme();
  }

  Future<void> _loadTheme() async {
    prefs = await SharedPreferences.getInstance();
    isDarkMode.value = prefs.getBool('user_theme') ?? false;
  }

  Future<void> _cashTheme() async {
    await prefs.setBool('user_theme', isDarkMode.value);
  }
}
