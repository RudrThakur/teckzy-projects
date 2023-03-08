import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';

import '../api_endpoints.dart';
import '../base_client.dart';
import 'package:get/get.dart';

import 'init.dart';

class HomeCon extends GetxController with BaseController {
  void addtocart(qty, empcan, amt, pid) async {
    showLoading();

    var body = {
      'customer_id': GetStorage().read('userid').toString(),
      'qty': qty.toString(),
      'empty_can': empcan.toString(),
      'amount': amt.toString(),
      'product_id': pid.toString(),
    };
    var response = await BaseClient()
        .post(API().baseurl + API().addtocart, body)
        .catchError(handleError);
    if (response == null) return;
    hideLoading();
    var data = json.decode(response);
    print(data);

    final InitCon icon = Get.find();
    icon.getcart();
    icon.getcheckout();
    icon.getreferalpoints();
    Fluttertoast.showToast(
      msg: data[0]['msg'],
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );

    print('xdmi');
  }
}
