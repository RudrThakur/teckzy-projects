import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:global_creater/screens/auth/otp.dart';
import 'package:global_creater/widgets/bottom_navigation.dart';
import 'package:global_creater/widgets/text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:sizer/sizer.dart';

import '../api_endpoints.dart';
import '../base_client.dart';
import 'package:get/get.dart';

class InitCon extends GetxController with BaseController {
  var totalpoints = '0'.obs;
  var usedpoints = '0'.obs;
  var availablecan = '0'.obs;
  var totalitems = '0'.obs;
  var totalvalue = '0'.obs;
  var referalchecout = '0'.obs;
  var rating = '3.0'.obs;
  var productservicerating = '3.0'.obs;
  var deliveryservicerating = '3.0'.obs;
  var myprofile = {}.obs;
  var bannerlist = [].obs;
  var categorylist = [].obs;
  var offerlist = [].obs;
  var productlist = [].obs;
  var notificationlist = [].obs;
  var myorderslist = [].obs;
  var addresslist = [].obs;
  var checkoutlist = [].obs;
  var orderdetails = [].obs;

  var addname = ''.obs;
  var addid = ''.obs;
  var addmobile = ''.obs;
  var adddoor = ''.obs;
  var addstreet = ''.obs;
  var addcity = ''.obs;
  var addarea = ''.obs;
  var addlandmark = ''.obs;
  var addpincode = ''.obs;
  var addcategory = ''.obs;
  var addcategoryname = ''.obs;

  var userid = GetStorage().read('userid').toString();
  final TextEditingController feedcon = TextEditingController();

  final TextEditingController name = TextEditingController();
  final TextEditingController mobile = TextEditingController();
  final TextEditingController doorno = TextEditingController();
  final TextEditingController street = TextEditingController();
  final TextEditingController area = TextEditingController();
  final TextEditingController landmark = TextEditingController();
  final TextEditingController pincode = TextEditingController();
  final TextEditingController surrendercount = TextEditingController();
  final TextEditingController surrendercomments = TextEditingController();

  late Razorpay _razorpay;

  final picker = ImagePicker();
  var payimage;

  @override
  void onInit() {
    super.onInit();
    getbanners();
    getcategories();
    getoffers();
    // payimage.getnotification();
    if (GetStorage().read('userid').toString() != 'null') {
      referalponits();
      getprofile();
      getproducts();
      getcart();
      getorders();
      getaddress();
      getcheckout();
      getreferalpoints();
    }
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    finalpayment(
      response.orderId!.toString(),
      response.paymentId!.toString(),
      response.signature!.toString(),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: 'Payment Failed', toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void referalponits() async {
    var body = {
      'customer_id': GetStorage().read('userid').toString(),
    };
    var response = await BaseClient()
        .post(API().baseurl + API().referalpoints, body)
        .catchError(handleError);
    if (response == null) return;

    var data = json.decode(response);

    totalpoints.value = data['points'].toString();
    usedpoints.value = data['used_points'].toString();
    availablecan.value = data['available_cans'].toString();
  }

  void getprofile() async {
    var body = {
      'customer_id': GetStorage().read('userid').toString(),
    };
    var response = await BaseClient()
        .post(API().baseurl + API().myprofile, body)
        .catchError(handleError);
    if (response == null) return;

    var data = json.decode(response);
    myprofile.value = data[0];
  }

  void getbanners() async {
    var response = await BaseClient()
        .get(
          API().baseurl + API().banners,
        )
        .catchError(handleError);
    if (response == null) return;

    var data = json.decode(response);
    bannerlist.value = data;
  }

  void getoffers() async {
    var response = await BaseClient()
        .get(
          API().baseurl + API().offers,
        )
        .catchError(handleError);
    if (response == null) return;

    var data = json.decode(response);
    offerlist.value = data;
  }

  void getproducts() async {
    var body = {
      'customer_id': GetStorage().read('userid').toString(),
    };

    if (addcategory.value != '') {
      body['category_id'] = addcategory.value.toString();
    } else {
      body['category_id'] = '0';
    }

    var response = await BaseClient()
        .post(API().baseurl + API().getproducts, body)
        .catchError(handleError);
    if (response == null) return;

    var data = json.decode(response);
    productlist.value = data;

    print(data);
  }

  void getcart() async {
    var body = {'customer_id': GetStorage().read('userid').toString()};
    var response = await BaseClient()
        .post(API().baseurl + API().getcart, body)
        .catchError(handleError);
    if (response == null) return;
    if (response.toString() != '[]') {
      var data = json.decode(response);

      totalvalue.value = data['total_value'].toString();
      totalitems.value = data['total_items'].toString();
    } else {
      totalvalue.value = '0';
      totalitems.value = '0';
    }
  }

  void getaddress() async {
    var body = {'customer_id': GetStorage().read('userid').toString()};
    var response = await BaseClient()
        .post(API().baseurl + API().getaddress, body)
        .catchError(handleError);
    if (response == null) return;
    if (response.toString() != '[]') {
      var data = json.decode(response);

      addresslist.value = data;
    } else {
      addresslist.value = [];
    }
  }

  void getnotification() async {
    var response = await BaseClient()
        .get(
          API().baseurl + API().getnotification,
        )
        .catchError(handleError);
    if (response == null) return;

    if (response.toString() != '[]') {
      var data = json.decode(response);
      notificationlist.value = data;
    }
  }

  void getorders() async {
    var body = {'customer_id': GetStorage().read('userid').toString()};
    var response = await BaseClient()
        .post(API().baseurl + API().myorders, body)
        .catchError(handleError);
    if (response == null) return;
    if (response.toString() != '[]') {
      var data = json.decode(response);
      myorderslist.value = data;
      print(myorderslist);
    } else {
      myorderslist.value = [];
    }
  }

  void feedback() async {
    showLoading();
    var body = {
      'customer_id': GetStorage().read('userid').toString(),
      'rate': rating.value.toString(),
      'feedback': feedcon.text.trim().toString(),
    };
    var response = await BaseClient()
        .post(API().baseurl + API().feedback, body)
        .catchError(handleError);
    if (response == null) return;

    var data = json.decode(response);
    if (data[0]['status'] == 'true') {
      hideLoading();
      rating.value = '3.0';
      Fluttertoast.showToast(
        msg: data[0]['msg'],
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      feedcon.clear();
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

  void addaddress() async {
    showLoading();

    var body = {
      'customer_id': GetStorage().read('userid').toString(),
      'name': name.text,
      'door_no': doorno.text,
      'mobile': mobile.text,
      'street': street.text,
      'location': area.text,
      'landmark': landmark.text,
      'pincode': pincode.text,
      'city': area.text,
      'state': '',
      'address_type': 'Home',
      'district': '',
      'latitude': '',
      'longitude': '',
    };
    var response = await BaseClient()
        .post(API().baseurl + API().addaddress, body)
        .catchError(handleError);
    if (response == null) return;

    var data = json.decode(response);
    if (data[0]['status'] == 'true') {
      hideLoading();

      Fluttertoast.showToast(
        msg: data[0]['msg'],
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      name.clear();
      doorno.clear();
      mobile.clear();
      street.clear();
      area.clear();
      landmark.clear();
      pincode.clear();
      getaddress();
      Get.back();
    } else {
      hideLoading();

      Fluttertoast.showToast(
        msg: data[0]['msg'],
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  void getcheckout() async {
    var body = {
      'customer_id': GetStorage().read('userid').toString(),
      'address_id': '0'
    };
    var response = await BaseClient()
        .post(API().baseurl + API().getcheckout, body)
        .catchError(handleError);
    if (response == null) return;
    if (response.toString() != '[]') {
      var data = json.decode(response);
      checkoutlist.value = data;

      if (checkoutlist[0]['address'] != []) {
        var add = checkoutlist[0]['address'][0];
        addid.value = add['address_id'];
        addname.value = add['name'];
        addmobile.value = add['mobile'];
        adddoor.value = add['door_no'];
        addlandmark.value = add['landmark'];
        addcity.value = add['location'] ?? '';
        addpincode.value = add['pincode'];
        addarea.value = add['city'];
        addstreet.value = add['street'];
      }
    } else {
      checkoutlist.value = [];
    }
  }

  void getreferalpoints() async {
    var body = {
      'customer_id': GetStorage().read('userid').toString(),
    };
    var response = await BaseClient()
        .post(API().baseurl + API().getreferealcheckout, body)
        .catchError(handleError);
    if (response == null) return;

    var data = json.decode(response);
    if (data.toString() == '[]') {
    } else {
      referalchecout.value = data[0]['value'].toString();
    }
  }

  void getorderdetail(orderid) async {
    var body = {
      'order_id': orderid,
    };
    var response = await BaseClient()
        .post(API().baseurl + API().orderdetail, body)
        .catchError(handleError);
    if (response == null) return;

    var data = json.decode(response);
    orderdetails.value = data;
    print(orderdetails);
  }

  void deletecartitem(cartid) async {
    var body = {
      'customer_id': GetStorage().read('userid').toString(),
      'cart_id': cartid,
    };
    var response = await BaseClient()
        .post(API().baseurl + API().deletecartitem, body)
        .catchError(handleError);
    if (response == null) return;

    var data = json.decode(response);

    Fluttertoast.showToast(
      msg: data[0]['msg'],
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
    getcheckout();
    getcart();
  }

  void deletaddress(addressid) async {
    var body = {
      'customer_id': GetStorage().read('userid').toString(),
      'address_id': addressid,
    };
    var response = await BaseClient()
        .post(API().baseurl + API().deleteaddres, body)
        .catchError(handleError);
    if (response == null) return;

    var data = json.decode(response);

    Fluttertoast.showToast(
      msg: data[0]['msg'],
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
    getaddress();
  }

  void updateqty(cartid, qty) async {
    var body = {
      'customer_id': GetStorage().read('userid').toString(),
      'cart_id': cartid,
      'qty': qty
    };
    var response = await BaseClient()
        .post(API().baseurl + API().updateqty, body)
        .catchError(handleError);
    if (response == null) return;

    var data = json.decode(response);

    Fluttertoast.showToast(
      msg: data[0]['msg'],
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
    getcheckout();
    getcart();
  }

  void paynow(total, comments) async {
    showLoading();
    var body = {
      'customer_id': GetStorage().read('userid').toString(),
      'order_amount': total.toString(),
      'address_id': addid.value.toString(),
      'referal_status': 'false',
      'comments': comments,
    };
    var response = await BaseClient()
        .post(API().baseurl + API().paynow, body)
        .catchError(handleError);
    if (response == null) return;

    var data = json.decode(response);
    openCheckout(data);
    hideLoading();
  }

  void finalpayment(orderid, payid, signature) async {
    showLoading();
    var body = {
      'razorpay_order_id': orderid,
      'razorpay_payment_id': payid,
      'razorpay_signature': signature,
    };
    var response = await BaseClient()
        .post(API().baseurl + API().finalpay, body)
        .catchError(handleError);
    if (response == null) return;

    var data = json.decode(response);
    if (data[0]['status']) {
      getorders();
      getcart();
      Get.dialog(Center(
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Container(
                height: 30.h,
                width: 80.w,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        CupertinoIcons.check_mark_circled_solid,
                        color: Colors.green,
                        size: 50.sp,
                      ),
                      const Txt(
                        iscenter: true,
                        fsize: 16,
                        text: 'Order Placed Succussfully!',
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: const StadiumBorder(),
                                primary: Get.theme.primaryColor,
                              ),
                              onPressed: () {
                                Get.offAll(
                                    () => BottomNavigation(currentindex: 0));
                              },
                              child: const Txt(
                                text: '  Submit  ',
                                color: Colors.white,
                                defalutsize: true,
                              )),
                        ],
                      )
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
              )),
            ],
          ),
        ),
      ));
    } else {
      Fluttertoast.showToast(
        msg: 'Something went wrong',
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  void openCheckout(data) async {
    var options = data;

    try {
      _razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void surrendar() async {
    showLoading();
    var body = {
      'customer_id': GetStorage().read('userid').toString(),
      'empty_can': surrendercount.value.text,
      'comments': surrendercomments.value.text
    };
    var response = await BaseClient()
        .post(API().baseurl + API().surrender, body)
        .catchError(handleError);
    if (response == null) return;

    var data = json.decode(response);

    surrendercount.clear();
    surrendercomments.clear();

    Fluttertoast.showToast(
      msg: data[0]['msg'],
      textColor: Colors.white,
    );
    hideLoading();
    getreferalpoints();
    getprofile();
  }

  void cencelorder(orderId) async {
    showLoading();
    var body = {
      'order_id': orderId,
    };

    var response = await BaseClient()
        .post(API().baseurl + API().cancelorder, body)
        .catchError(handleError);

    if (response == null) return;

    var data = json.decode(response);

    print(data);

    Fluttertoast.showToast(
      msg: data[0]['msg'],
      textColor: Colors.white,
    );
    hideLoading();
    getorders();
    Get.back();
    Get.back();
  }

  void getcategories() async {
    var response = await BaseClient()
        .get(
          API().baseurl + API().getcategories,
        )
        .catchError(handleError);
    if (response == null) return;

    var data = json.decode(response);
    categorylist.value = data;

    print(data);
  }

  // category
  void setcategory(category) {
    addcategory.value = category;
  }

  String getcategory() {
    return addcategory.value;
  }

  // category name
  void setcategoryname(categoryname) {
    addcategoryname.value = categoryname;
  }

  String getcategoryname() {
    return addcategoryname.value;
  }

  Future getpayimage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source, imageQuality: 10);

    if (pickedFile != null) {
      payimage = File(pickedFile.path);
      if (Get.isDialogOpen!) Get.back();

      update();
    } else {
      print('No image selected.');
      if (Get.isDialogOpen!) Get.back();
      update();
    }
    if (pickedFile != null) {
      // List<int> imageBytes = sparesimage.readAsBytesSync();
      // String base64Image = base64.encode(imageBytes);
      // updatelistimages.add(base64Image);
    }
    print(payimage.toString());
  }
}
