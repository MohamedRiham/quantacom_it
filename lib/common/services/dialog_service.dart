import 'package:flutter/material.dart';
import 'package:get/get.dart';


void showDeleteDialog({required VoidCallback onSubmitted}) {
  Get.defaultDialog(
    barrierDismissible: false,
    title: "Warning",

    content:
 const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Are you sure you want to delete this item?"),
        ),


    textCancel: "No",
    textConfirm: "Yes",
    onConfirm: () =>

      onSubmitted(),

  );
}

