import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:quantacom_it/authorization/get_x/auth_controller.dart';

class SideDrawer extends StatelessWidget {
  SideDrawer({super.key});

  final authController = AuthController.instance;

  @override
  Widget build(BuildContext context) {
    return Obx(
          () {
 return       authController.isLoading.value ? const Center(
          child: CircularProgressIndicator()): Drawer(
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: <Widget>[
                        DrawerHeader(
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  authController.firebaseUser?.value?.email ??
                                      '',
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ListTile(
                          title: const Text(
                            'Sign out',
                            style: TextStyle(fontSize: 16),
                          ),
                          onTap: () async {
                            await authController.logout();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }

  );
  }
}
