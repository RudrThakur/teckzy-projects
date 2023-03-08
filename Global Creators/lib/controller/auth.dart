import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:global_creater/controller/init.dart';
import 'package:global_creater/screens/auth/login.dart';
import 'package:global_creater/screens/auth/otp.dart';
import 'package:global_creater/widgets/bottom_navigation.dart';

import '../api_endpoints.dart';
import '../base_client.dart';
import 'package:get/get.dart';

class AuthCon extends GetxController with BaseController {
  var otp = ''.obs;
  var isenabled = true.obs;
  var userid = GetStorage().read('userid').toString();

  ///login
  final TextEditingController lmobile = TextEditingController();
  final TextEditingController lpassword = TextEditingController();
  var lobs = true.obs;

  ///signup
  final TextEditingController sfirstname = TextEditingController();
  final TextEditingController referalcode = TextEditingController();
  final TextEditingController sphone = TextEditingController();
  final TextEditingController semail = TextEditingController();
  final TextEditingController spassword = TextEditingController();
  final TextEditingController sconfirmpassword = TextEditingController();
  var sobs = true.obs;
  var scobs = true.obs;

  ///forgotpass
  final TextEditingController fphone = TextEditingController();

  ///resetpass
  final TextEditingController rpassword = TextEditingController();
  final TextEditingController rconfirmpassword = TextEditingController();
  var robs = true.obs;
  var rcobs = true.obs;

  final TextEditingController coldpass = TextEditingController();
  final TextEditingController cnewpass = TextEditingController();
  final TextEditingController cnewcpass = TextEditingController();
  var oobs = true.obs;
  var nobs = true.obs;
  var ncobs = true.obs;
  void generateotp() async {
    showLoading();

    var body = {
      'mobile_no': sphone.text.trim(),
      'email': semail.text.trim(),
    };
    var response = await BaseClient()
        .post(API().baseurl + API().otp, body)
        .catchError(handleError);
    if (response == null) return;
    hideLoading();
    var data = json.decode(response);
    if (data[0]['status']) {
      otp.value = data[0]['otp_no'];
      Fluttertoast.showToast(
        msg: data[0]['otp_no'],
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      Get.to(() => OtpView(
            mobile: sphone.text,
          ));
    } else {
      Fluttertoast.showToast(
        msg: data[0]['msg'],
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  void login() async {
    showLoading();

    var body = {
      'mobile_no': lmobile.text.trim(),
      'password': lpassword.text.trim(),
    };
    var response = await BaseClient()
        .post(API().baseurl + API().login, body)
        .catchError(handleError);
    if (response == null) return;
    hideLoading();
    var data = json.decode(response);
    if (data['status']) {
      final InitCon icon = Get.find();
      Fluttertoast.showToast(
        msg: data['message'],
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      GetStorage().write('userid', data['customer']['customer_id']);
      GetStorage().write('username', data['customer']['name']);
      GetStorage().write('mobile', data['customer']['mobile_no']);
      GetStorage().write('usertype', data['customer']['user_type']);
      icon.userid = GetStorage().read('userid').toString();

      icon.getprofile();
      icon.getaddress();
      icon.getproducts();
      icon.getcart();
      icon.getreferalpoints();
      icon.getorders();
      print(GetStorage().read('userid'));
      Get.offAll(() => BottomNavigation(currentindex: 0));
    } else {
      Fluttertoast.showToast(
        msg: data['message'],
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  void signup() async {
    showLoading();

    var body = {
      'username': sfirstname.text.trim(),
      'referal_code': referalcode.text.trim(),
      'mobile_no': sphone.text.trim(),
      'email': semail.text.trim(),
      'password': spassword.text.trim(),
    };
    var response = await BaseClient()
        .post(API().baseurl + API().signup, body)
        .catchError(handleError);
    if (response == null) return;
    hideLoading();
    var data = json.decode(response);
    if (data[0]['status'] == true) {
      Get.offAll(() => BottomNavigation(currentindex: 0));
      Fluttertoast.showToast(
        msg: data[0]['msg'],
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      sfirstname.clear();
      referalcode.clear();
      spassword.clear();
      sconfirmpassword.clear();
      sphone.clear();
      semail.clear();
      GetStorage().write('userid', data[0]['customer'][0]['customer_id']);

      GetStorage().write('username', data[0]['customer'][0]['name']);
      GetStorage().write('mobile', data[0]['customer'][0]['mobile_no']);

      GetStorage().write('usertype', data[0]['customer'][0]['user_type']);
      print(GetStorage().read('userid').toString());
      final InitCon icon = Get.find();
      icon.getprofile();
      icon.getaddress();
      icon.getproducts();
      icon.getcart();
      icon.getreferalpoints();
      icon.getorders();
      // final HomeCon hcon = Get.find();
      // final CartCon ccon = Get.find();
      // final ProfileCon icon = Get.find();
      // hcon.getrecentlyadd();
      // ccon.getcartlist();
      // ccon.checkoutaddres();
      // icon.getfavlist();
      // icon.getaddress();
      // icon.myorders();
    } else {
      Fluttertoast.showToast(
        msg: data[0]['msg'],
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  void forgotpassword(mobile) async {
    showLoading();

    var body = {
      'mobile_no': mobile,
    };
    var response = await BaseClient()
        .post(API().baseurl + API().forpassword, body)
        .catchError(handleError);
    if (response == null) return;
    hideLoading();
    var data = json.decode(response);
    if (data[0]['status']) {
      otp.value = data[0]['otp_no'];
      Fluttertoast.showToast(
        msg: data[0]['otp_no'],
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      Get.to(() => OtpView(
            mobile: sphone.text,
            isfogot: true,
          ));
    } else {
      Fluttertoast.showToast(
        msg: data[0]['msg'],
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  void forgotchangepassword() async {
    showLoading();

    var body = {
      'mobile_no': fphone.text.trim(),
      'password': rpassword.text.trim(),
    };
    var response = await BaseClient()
        .post(API().baseurl + API().changeforpassword, body)
        .catchError(handleError);
    if (response == null) return;
    hideLoading();
    var data = json.decode(response);
    if (data[0]['status']) {
      Fluttertoast.showToast(
        msg: data[0]['msg'],
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      Get.offAll(() => LoginView());
    } else {
      Fluttertoast.showToast(
        msg: data[0]['msg'],
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  void changepassword() async {
    showLoading();
    var body = {
      'customer_id': userid,
      'old_password': coldpass.text.trim(),
      'new_password': cnewcpass.text.trim(),
    };
    var response = await BaseClient()
        .post(API().baseurl + API().changepassword, body)
        .catchError(handleError);
    if (response == null) return;

    var data = json.decode(response);
    if (data[0]['status']) {
      hideLoading();

      Fluttertoast.showToast(
        msg: data[0]['msg'],
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      coldpass.clear();
      cnewcpass.clear();
      cnewpass.clear();

      Get.offAll(() => BottomNavigation(currentindex: 0));
    } else {
      hideLoading();

      Fluttertoast.showToast(
        msg: data[0]['msg'],
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }
}
