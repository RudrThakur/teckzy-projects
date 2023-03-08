import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:global_creater/controller/auth.dart';
import 'package:global_creater/widgets/appbar.dart';
import 'package:global_creater/widgets/text.dart';
import 'package:global_creater/widgets/text_field.dart';
import 'package:sizer/sizer.dart';

class ForgotpassChangeView extends StatelessWidget {
  ForgotpassChangeView({Key? key}) : super(key: key);
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
                  text: 'Change Password',
                  fsize: 12,
                ),
                BackButton(
                  color: Colors.transparent,
                  onPressed: () {},
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.sp),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: const [
                        Txt(
                          text: 'New password',
                          fsize: 12,
                        )
                      ],
                    ),
                  ),
                  Obx(
                    () => CTextField(
                      controller: acon.rpassword,
                      ispass: true,
                      obs: acon.robs.value,
                      isvisible: acon.lobs.value,
                      passontap: () {
                        acon.robs.toggle();
                        FocusScope.of(context).requestFocus(new FocusNode());
                      },
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
                          text: 'Confirm password',
                          fsize: 12,
                        )
                      ],
                    ),
                  ),
                  Obx(
                    () => CTextField(
                      controller: acon.rconfirmpassword,
                      ispass: true,
                      obs: acon.rcobs.value,
                      isvisible: acon.lobs.value,
                      passontap: () {
                        acon.rcobs.toggle();
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                    ),
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
                        if (acon.rconfirmpassword.text.isEmpty ||
                            acon.rpassword.text.isEmpty) {
                          Fluttertoast.showToast(
                            msg: 'Fields Required',
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                          );
                        } else if (acon.rpassword.text.length < 5) {
                          Fluttertoast.showToast(
                            msg: 'Password should above 5 charaters',
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                          );
                        } else if (acon.rconfirmpassword.text !=
                            acon.rpassword.text) {
                          Fluttertoast.showToast(
                            msg: 'Password Not Matched',
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                          );
                        } else {
                          acon.forgotchangepassword();
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
            Placeholder(
              fallbackHeight: 40.h,
            )
          ],
        ),
      ),
    );
  }
}
