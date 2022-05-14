import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qubic_health_assignment/constant/app_strings.dart';
import 'package:qubic_health_assignment/routes/name_routes.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.firstScreenTitle),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("Navigate"),
          onPressed: () {
            Get.toNamed(Routes.secondScreen);
          },
        ),
      ),
    );
  }
}
