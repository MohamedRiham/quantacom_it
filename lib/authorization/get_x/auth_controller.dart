import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:quantacom_it/authorization/models/user_details.dart';
import 'package:quantacom_it/authorization/screens/login.dart';
import 'package:quantacom_it/task/get_x/task_controller.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find();
  get taskController => TaskController.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<bool> isLoading = false.obs;
  Rx<User?>? firebaseUser;

  @override
  void onReady() {
    super.onReady();

    firebaseUser = _auth.currentUser.obs;
    firebaseUser?.bindStream(_auth.authStateChanges());
  }

  // SIGN UP
  Future<bool> register(Login details) async {
    try {
      isLoading.value = true;
      await _auth.createUserWithEmailAndPassword(
        email: details.emailAddress,
        password: details.password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error",
        e.message ?? "An error occurred",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // SIGN IN
  Future<bool> login(Login details) async {
    try {
      isLoading.value = true;
      await _auth.signInWithEmailAndPassword(
        email: details.emailAddress,
        password: details.password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error",
        e.message ?? "An error occurred",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // SIGN OUT
  Future<void> logout() async {
    try {
      isLoading.value = true;

      await _auth.signOut();

      taskController.clear();
      Get.offAll(() => LoginScreen());
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
