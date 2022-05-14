import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qubic_health_assignment/constant/app_strings.dart';

import '../routes/name_routes.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.secondScreenTitle),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
          ),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("Navigate"),
          onPressed: () {
            Get.toNamed(Routes.thirdScreen);
          },
        ),
      ),
    );
  }
}
