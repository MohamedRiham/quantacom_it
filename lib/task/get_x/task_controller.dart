import 'package:quantacom_it/authorization/get_x/auth_controller.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:quantacom_it/task/models/task.dart';

class TaskController extends GetxController {
  static TaskController get instance => Get.find();
  final authController = AuthController.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxList<Task> taskList = <Task>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onReady() {
    super.onReady();

    final user = authController.firebaseUser?.value;
    if (user != null) {
      bindTasks(user.uid);
    }
  }

  // Fetch tasks for the current user
  void bindTasks(String userId) {
    isLoading.value = true;

    _firestore
        .collection('tasks')
        .where('user_id', isEqualTo: userId)
        .snapshots()
        .listen(
          (snapshot) {
            final tasks = snapshot.docs.map((doc) {
              Task task = Task.fromMap(doc.data());

              task.taskId = doc.id;
              return task;
            }).toList();

            taskList.assignAll(tasks);
            isLoading.value = false;
          },
          onError: (e) {
            Get.snackbar("Error", e.toString());
            isLoading.value = false;
          },
        );
  }

  // Add a new task
  Future<bool> addTask(Task task) async {
    try {
      isLoading.value = true;
      await _firestore.collection('tasks').add(task.toMap());

      Get.snackbar(
        "Success",
        "Task added successfully!",
        snackPosition: SnackPosition.BOTTOM,
      );
      return true;
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Update task status or details

  Future<void> updateTask(Task task) async {
    try {
      isLoading.value = true;
      await _firestore
          .collection('tasks')
          .doc(task.taskId)
          .update(task.toMap());
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  // Delete a task
  Future<void> deleteTask(String taskId) async {
    try {
      isLoading.value = true;
      await _firestore.collection('tasks').doc(taskId).delete();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
