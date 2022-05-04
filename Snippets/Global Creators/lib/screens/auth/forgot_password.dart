import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:global_creater/controller/auth.dart';
import 'package:global_creater/widgets/appbar.dart';
import 'package:global_creater/widgets/text.dart';
import 'package:global_creater/widgets/text_field.dart';
import 'package:sizer/sizer.dart';

class ForgotpassView extends StatelessWidget {
  ForgotpassView({Key? key}) : super(key: key);
  final TextEditingController tcon1 = TextEditingController();
  final AuthCon acon = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackButton(
                  color: Get.theme.primaryColor,
                ),
                const Txt(
                  text: 'Forgot Password',
                  fsize: 12,
                ),
                BackButton(
                  color: Colors.transparent,
                  onPressed: () {
                    Get.back();
                  },
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.sp),
              child: Column(
                children: [
                  SizedBox(
                    height: 20.sp,
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
                    controller: acon.fphone,
                    istheme: true,
                    max: 10,
                    keyboard: TextInputType.number,
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        primary: Get.theme.primaryColor,
                      ),
                      onPressed: () {
                        if (acon.fphone.text.isEmpty ||
                            acon.fphone.text.length != 10) {
                          Fluttertoast.showToast(
                            msg: 'Enter Valid Mobile Number',
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16,
                          );
                        } else {
                          acon.forgotpassword(acon.fphone.text.trim());
                        }
                      },
                      child: const Txt(
                        text: '  Submit  ',
                        color: Colors.white,
                        defalutsize: true,
                      )),
                ],
              ),
            ),
            Image.asset(
              'assets/Intersection 1.png',
              height: 60.h,
              fit: BoxFit.cover,
            )
          ],
        ),
      ),
    );
  }
}
