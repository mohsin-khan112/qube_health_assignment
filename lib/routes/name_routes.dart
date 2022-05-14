// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qubic_health_assignment/view/feeling_screen.dart';
import 'package:qubic_health_assignment/view/first_screen.dart';
import 'package:qubic_health_assignment/view/second_screen.dart';
import 'package:qubic_health_assignment/view/third_screen.dart';

class Routes {
  static const firstScreen = '/first';
  static const secondScreen = '/second';
  static const thirdScreen = '/third';
  static const feeling = '/feeling ';
}

class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: Routes.firstScreen,
      page: () => const FirstScreen(),
    ),
    GetPage(
      name: Routes.secondScreen,
      page: () => const SecondScreen(),
    ),
    GetPage<MaterialPageRoute>(
      name: Routes.thirdScreen,
      page: () => const ThirdScreen(),
    ),
    GetPage<MaterialPageRoute>(
      name: Routes.feeling,
      page: () => const FeelingHistoryScreen(),
    ),
  ];
}
