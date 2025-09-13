import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:quantacom_it/common/services/dialog_service.dart';
import 'package:quantacom_it/task/models/task.dart';
import 'package:quantacom_it/task/get_x/task_controller.dart';
import 'package:quantacom_it/task/screens/task_form_screen.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  TaskCard({super.key, required this.task});
  final taskController = TaskController.instance;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  task.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    decoration: task.status == 'Completed'
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.to(() => TaskFormScreen(oldTask: task));
                      },
                      icon: Icon(Icons.edit),
                    ),
                    const SizedBox(width: 5),

                    IconButton(
                      onPressed: () {
                        showDeleteDialog(
                          onSubmitted: () async {
                            Get.back();

                            await taskController.deleteTask(task.taskId ?? '');
                          },
                        );
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
              ],
            ),

            const Divider(thickness: 5.0),
            Text(
              task.description,
              style: TextStyle(
                fontStyle: task.status == 'Completed'
                    ? FontStyle.italic
                    : FontStyle.normal,
              ),
            ),
            SizedBox(height: 10),

            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () async {
                  task.status = task.status == 'Pending'
                      ? 'Completed'
                      : 'Pending';
                  await taskController.updateTask(task);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: task.status == 'Completed'
                        ? Colors.green
                        : Colors.orange,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: (task.status == 'Completed'
                            ? Colors.green
                            : Colors.orange),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      Icon(
                        task.status == 'Completed'
                            ? Icons.check_circle
                            : Icons.pending,
                        color: Colors.white,
                        size: 18,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        task.status ,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
