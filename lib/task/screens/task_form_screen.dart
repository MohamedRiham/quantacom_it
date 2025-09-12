import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantacom_it/authorization/get_x/auth_controller.dart';
import 'package:quantacom_it/task/get_x/task_controller.dart';
import 'package:quantacom_it/task/models/task.dart';
import 'package:quantacom_it/common/widgets/custom_text_field.dart';
import 'package:quantacom_it/common/widgets/custom_scaffold.dart';

class TaskFormScreen extends StatelessWidget {
  final Task? oldTask;
  TaskFormScreen({this.oldTask, super.key});

  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  final authController = AuthController.instance;
  final taskController = TaskController.instance;

  @override
  Widget build(BuildContext context) {
    if (oldTask != null) {
      titleController.text = oldTask!.title;
      descriptionController.text = oldTask!.description;
    }
    return CustomScaffold(
      title: oldTask != null ? 'Edit Task' : 'Add Task',
      body: Obx(() {
        return taskController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: titleController,
                            hintText: 'Task Title',
                            icon: Icons.title,
                            keyboardType: TextInputType.text,
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            controller: descriptionController,
                            hintText: 'Task Description',
                            icon: Icons.description,
                            keyboardType: TextInputType.text,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () async {
                        if (authController.firebaseUser?.value == null) {
                          Get.snackbar(
                            'Error',
                            'User not logged in!',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                          await authController.logout();
                          return;
                        }

                        if (!formKey.currentState!.validate()) return;
                        if (oldTask != null) {
                          Task newTask = Task(
                            userId: authController.firebaseUser!.value!.uid,
                            title: titleController.text.trim(),
                            description: descriptionController.text.trim(),
                            taskId: oldTask!.taskId,
                            isCompleted: oldTask!.isCompleted,
                          );
                          await taskController.updateTask(newTask);
                        } else {
                          Task task = Task(
                            userId: authController.firebaseUser!.value!.uid,
                            title: titleController.text.trim(),
                            description: descriptionController.text.trim(),
                          );

                          await taskController.addTask(task);
                        }
                        titleController.text = "";
                        descriptionController.text = "";
                        Get.back(closeOverlays: true);
                      },
                      child: const Text('Save Task'),
                    ),
                  ],
                ),
              );
      }),
    );
  }
}
