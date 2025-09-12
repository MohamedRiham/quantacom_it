import 'package:quantacom_it/common/widgets/side_drawer.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:quantacom_it/common/themes/get_x/theme_controller.dart';

class CustomScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final bool needSideDraw;
  final Widget? floatingActionButton;
  CustomScaffold({
    super.key,
    required this.title,
    required this.body,
    this.needSideDraw = false,
    this.floatingActionButton,
  });

  final themeController = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        drawer: needSideDraw == true ? SideDrawer() : null,
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,

          actions: [
            Semantics(
              label: themeController.isDarkMode.value
                  ? 'Dark Mode On'
                  : 'Dark Mode Off',
              button: true,
              excludeSemantics: true,
              child: IconButton(
                icon: Icon(
                  themeController.isDarkMode.value
                      ? Icons.dark_mode
                      : Icons.light_mode,
                ),
                onPressed: () => themeController.toggleTheme(),
              ),
            ),
          ],
        ),
        body: body,
        floatingActionButton: floatingActionButton,
      ),
    );
  }
}
