import 'package:quantacom_it/authorization/get_x/auth_controller.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:quantacom_it/task/models/task.dart';

class TaskController extends GetxController {
  static TaskController get instance => Get.find();
  final authController = AuthController.instance;
  RxList<Task> rowTaskList = <Task>[].obs;
  RxString statusFilter = 'All'.obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxString searchedValue = ''.obs;

  RxList<Task> taskList = <Task>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onReady() {
    super.onReady();
    final user = authController.firebaseUser?.value;
    if (user != null) {
      bindTasks(user.uid);
    }
    authController.firebaseUser?.listen((user) {
      if (user != null) {
        bindTasks(user.uid);
      } else {
        clear();
      }
    });
  }

  // Fetch tasks for the current user
  void bindTasks(String userId) {
    try {
      isLoading.value = true;

      taskList.bindStream(
        _firestore
            .collection('tasks')
            .where('user_id', isEqualTo: userId)
            .snapshots()
            .map((snapshot) {
              final tasks = snapshot.docs.map((doc) {
                final task = Task.fromMap(doc.data());
                task.taskId = doc.id;
                statusFilter.value = 'All';
                searchedValue.value = '';
                return task;
              }).toList();

              rowTaskList.value = tasks;

              return tasks;
            }),
      );
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
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

  void applyFilters() {
    List<Task> tempList = rowTaskList.value;
    if (searchedValue.isNotEmpty) {
      tempList = tempList.where((task) {
        return task.title.toLowerCase().contains(searchedValue.toLowerCase());
      }).toList();
    }
    if (statusFilter != 'All') {
      tempList = tempList.where((task) {
        return task.status == statusFilter.value;
      }).toList();
    }
    taskList.value = tempList;
  }

  void clear() {
    taskList.clear();
    isLoading.value = false;
  }
}
