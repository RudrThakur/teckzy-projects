import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:global_creater/screens/auth/login.dart';
import 'package:global_creater/screens/auth/signup.dart';

import 'package:sizer/sizer.dart';

import 'controller/auth.dart';
import 'controller/home.dart';
import 'controller/init.dart';
import 'screens/addressbook/add_address.dart';
import 'screens/addressbook/address_list.dart';

import 'screens/auth/forgot_password.dart';
import 'screens/auth/forgot_password_reset.dart';
import 'screens/auth/otp.dart';
import 'screens/offers.dart';
import 'widgets/bottom_navigation.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  await GetStorage.init();
  runApp(MyApp());
  Get.put(InitCon());
  Get.put(AuthCon());
  Get.put(HomeCon());
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.lightBlue));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        defaultTransition: Transition.topLevel,
        transitionDuration: const Duration(seconds: 1),
        title: 'Global Creators',
        themeMode: ThemeMode.light,
        theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            scaffoldBackgroundColor: const Color(0xffe8ebfa),
            primaryColor: const Color(0xff104cf5)),
        home: GetStorage().read('userid').toString() == 'null'
            ? LoginView()
            : BottomNavigation(currentindex: 0),
        // home: BottomNavigation(currentindex: 1),
        // home: AddAddressView(),
        debugShowCheckedModeBanner: false,
      );
    });
  }
}
