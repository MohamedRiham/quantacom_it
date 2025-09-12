import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:quantacom_it/authorization/models/user_details.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find();

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
      Get.snackbar(
        "Success",
        "Account created successfully!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      isLoading.value = false;
      return true;
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;

      Get.snackbar(
        "Error",
        e.message ?? "An error occurred",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    } catch (e) {
      isLoading.value = false;

      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
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
      Get.snackbar(
        "Success",
        "Logged in successfully!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      isLoading.value = false;
      return true;
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;

      Get.snackbar(
        "Error",
        e.message ?? "An error occurred",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    } catch (e) {
      isLoading.value = false;

      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }
  }

  // SIGN OUT
  Future<void> logout() async {
    try {
      isLoading.value = true;

      await _auth.signOut();
      Get.snackbar(
        "Success",
        "Logged out successfully!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;

      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
