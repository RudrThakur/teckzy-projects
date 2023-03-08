import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:global_creater/controller/init.dart';
import 'package:global_creater/widgets/appbar.dart';
import 'package:global_creater/widgets/text.dart';
import 'package:global_creater/widgets/text_field.dart';
import 'package:sizer/sizer.dart';

class AddAddressView extends StatefulWidget {
  AddAddressView({Key? key}) : super(key: key);

  @override
  State<AddAddressView> createState() => _AddAddressViewState();
}

class _AddAddressViewState extends State<AddAddressView> {
  final InitCon icon = Get.find();
  String location = 'Null, Press Button';
  String Address = 'search';
  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      Get.dialog(
        Dialog(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Txt(
                    text: 'Warning!',
                    weight: FontWeight.bold,
                    color: Get.theme.primaryColor,
                  ),
                  Txt(
                    text:
                        'Please turn on location permission into your app-permission in setting section',
                    fsize: 12,
                    weight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (Get.isDialogOpen!) Get.back();
                      },
                      child: Text(
                        'Okay',
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
      );
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    icon.name.text = GetStorage().read('username');
    icon.mobile.text = GetStorage().read('mobile');
    icon.doorno.text = place.name.toString();
    icon.street.text = place.street.toString();
    icon.area.text = place.subLocality.toString();
    icon.pincode.text = place.postalCode.toString();
    Address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode},';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        backicon: true,
        title: 'Add Address',
        carticon: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0.sp),
        child: ListView(
          children: [
            InkWell(
              onTap: () async {
                Position position = await _getGeoLocationPosition();
                location =
                    'Lat: ${position.latitude} , Long: ${position.longitude}';
                GetAddressFromLatLong(position);
              },
              child: Container(
                height: 38.sp,
                child: Row(
                  children: [
                    SizedBox(
                      width: 15.sp,
                    ),
                    Icon(
                      Icons.location_on,
                      color: Get.theme.primaryColor,
                      size: 15.sp,
                    ),
                    SizedBox(
                      width: 15.sp,
                    ),
                    const Txt(
                      text: 'Pin your location',
                      fsize: 10,
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Get.theme.primaryColor),
                    borderRadius: BorderRadius.circular(10.sp)),
              ),
            ),
            SizedBox(
              height: 10.sp,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                children: const [
                  Txt(
                    text: 'Name',
                    fsize: 12,
                  )
                ],
              ),
            ),
            CTextField(
              controller: icon.name,
              istheme: true,
            ),
            SizedBox(
              height: 10.sp,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                children: const [
                  Txt(
                    text: 'Mobile No',
                    fsize: 12,
                  )
                ],
              ),
            ),
            CTextField(
              controller: icon.mobile,
              istheme: true,
              keyboard: TextInputType.number,
              max: 10,
            ),
            SizedBox(
              height: 10.sp,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                children: const [
                  Txt(
                    text: 'Door No',
                    fsize: 12,
                  )
                ],
              ),
            ),
            CTextField(
              controller: icon.doorno,
              istheme: true,
              keyboard: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 10.sp,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                children: const [
                  Txt(
                    text: 'Street',
                    fsize: 12,
                  )
                ],
              ),
            ),
            CTextField(
              controller: icon.street,
              istheme: true,
            ),
            SizedBox(
              height: 10.sp,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                children: const [
                  Txt(
                    text: 'Area',
                    fsize: 12,
                  )
                ],
              ),
            ),
            CTextField(
              controller: icon.area,
              istheme: true,
            ),
            SizedBox(
              height: 10.sp,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                children: const [
                  Txt(
                    text: 'Landmark',
                    fsize: 12,
                  )
                ],
              ),
            ),
            CTextField(
              controller: icon.landmark,
              istheme: true,
            ),
            SizedBox(
              height: 10.sp,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                children: const [
                  Txt(
                    text: 'Pincode',
                    fsize: 12,
                  )
                ],
              ),
            ),
            CTextField(
              controller: icon.pincode,
              max: 6,
              keyboard: TextInputType.number,
              istheme: true,
            ),
            SizedBox(
              height: 10.sp,
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
                      if (icon.name.text.isEmpty) {
                        Fluttertoast.showToast(msg: 'Name Reqired');
                      } else if (icon.mobile.text.isEmpty ||
                          icon.mobile.text.length != 10) {
                        Fluttertoast.showToast(msg: 'Enter Valid Mobile No');
                      } else if (icon.doorno.text.isEmpty) {
                        Fluttertoast.showToast(msg: 'Door no Reqired');
                      } else if (icon.street.text.isEmpty) {
                        Fluttertoast.showToast(msg: 'Street Name Reqired');
                      } else if (icon.area.text.isEmpty) {
                        Fluttertoast.showToast(msg: 'Area Name Reqired');
                      } else if (icon.landmark.text.isEmpty) {
                        Fluttertoast.showToast(msg: 'Landmark Reqired');
                      } else if (icon.pincode.text.isEmpty ||
                          icon.pincode.text.length != 6) {
                        Fluttertoast.showToast(msg: 'Enter Valid Pincode');
                      } else {
                        icon.addaddress();
                      }
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
    );
  }
}
