import 'package:quantacom_it/task/get_x/task_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final taskController = TaskController.instance;

void showDeleteDialog({required VoidCallback onSubmitted}) {
  Get.defaultDialog(
    barrierDismissible: false,
    title: "Warning",

    content: Obx(() {
      if (taskController.isLoading.value) {
        return const Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(child: CircularProgressIndicator()),
        );
      } else {
        return const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Are you sure you want to delete this item?"),
        );
      }
    }),

    textCancel: "No",
    textConfirm: "Yes",
    onConfirm: () {
      if (taskController.isLoading.value) return;

      onSubmitted();
    },
  );
}

