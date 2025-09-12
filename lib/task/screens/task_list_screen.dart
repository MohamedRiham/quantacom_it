import 'package:quantacom_it/authorization/get_x/auth_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:quantacom_it/common/widgets/custom_scaffold.dart';
import 'package:quantacom_it/task/custom_widgets/task_card.dart';
import 'package:quantacom_it/task/get_x/task_controller.dart';
import 'package:quantacom_it/task/screens/task_form_screen.dart';

class TaskListScreen extends StatelessWidget {
  TaskListScreen({super.key});
  final authController = AuthController.instance;

  final taskController = TaskController.instance;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Tasks',
      needSideDraw: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 400,
                child: Obx(() {
                  return taskController.isLoading.value
                      ? Center(child: CircularProgressIndicator())
                      : taskController.taskList.isEmpty
                      ? const Center(child: Text('No tasks available yet'))
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: taskController.taskList.length,
                          itemBuilder: (context, index) {
                            final task = taskController.taskList[index];
                            return TaskCard(task: task);
                          },
                        );
                }),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: IconButton(
        onPressed: () {
          Get.to(() => TaskFormScreen());
        },
        icon: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(blurRadius: 6, offset: const Offset(0, 3))],
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white, // icon color
            size: 28, // make it bigger
          ),
        ),
      ),
    );
  }
}
