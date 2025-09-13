import 'package:quantacom_it/authorization/get_x/auth_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:quantacom_it/common/widgets/custom_dropdown.dart';
import 'package:quantacom_it/common/widgets/custom_scaffold.dart';
import 'package:quantacom_it/common/widgets/search_bar.dart';
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
      body: Obx(() {
        if (taskController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12,
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SearchBox(
                      enabled:
                          !taskController.isLoading.value &&
                          taskController.rowTaskList.isNotEmpty,
                      hiddenText: 'Search...',
                      onChange: (text) {
                        taskController.searchedValue.value = text;
                        taskController.applyFilters();
                      },
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(blurRadius: 4, offset: const Offset(0, 2)),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Select Status',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            ),
                          ),
                          const SizedBox(height: 8),
                          CustomDropdown(
                            enabled:
                                !taskController.isLoading.value &&
                                taskController.rowTaskList.isNotEmpty,

                            value: taskController.statusFilter.value,
                            onChanged: (newValue) {
                              taskController.statusFilter.value =
                                  newValue ?? 'All';
                              taskController.applyFilters();
                            },
                            items: ['All', 'Pending', 'Completed'],
                            hintLabel: 'Select Status',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    if (taskController.rowTaskList.isEmpty)
                      const Center(child: Text('No tasks available yet'))
                    else if (taskController.taskList.isEmpty)
                      const Center(child: Text('No task found'))
                    else
                      SizedBox(
                        height: 400,

                        child: ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: taskController.taskList.length,
                          itemBuilder: (context, index) {
                            final task = taskController.taskList[index];
                            return TaskCard(task: task);
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        }
      }),

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
          child: const Icon(Icons.add, color: Colors.white, size: 28),
        ),
      ),
    );
  }
}
