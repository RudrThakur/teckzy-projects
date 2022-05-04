import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:global_creater/controller/auth.dart';
import 'package:global_creater/screens/auth/signup.dart';
import 'package:global_creater/widgets/text.dart';
import 'package:global_creater/widgets/text_field.dart';
import 'package:sizer/sizer.dart';

import 'forgot_password.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  final AuthCon acon = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                Container(
                  height: 20.h,
                  child: Center(
                    child: Container(
                      height: 10.h,
                      width: 80.w,
                      child: Image.asset('assets/GLobal Creaotrs logo.png'),
                    ),
                  ),
                ),
                Container(
                  height: 40.h,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/multi_can.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Stack(
                children: [
                  Container(
                    height: 45.h,
                    width: double.infinity,
                    child: Image.asset(
                      'assets/water_half.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 45.h,
                        width: 80.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: const [
                                Txt(
                                  text: 'Mobile No.',
                                  color: Colors.white,
                                  fsize: 11,
                                  weight: FontWeight.w500,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5.sp,
                            ),
                            CTextField(
                              controller: acon.lmobile,
                              istheme: true,
                              keyboard: TextInputType.number,
                              max: 10,
                            ),
                            SizedBox(
                              height: 10.sp,
                            ),
                            Row(
                              children: const [
                                Txt(
                                  text: 'Password',
                                  color: Colors.white,
                                  fsize: 11,
                                  weight: FontWeight.w500,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5.sp,
                            ),
                            Obx(
                              () => CTextField(
                                controller: acon.lpassword,
                                ispass: true,
                                istheme: true,
                                isvisible: acon.lobs.value,
                                obs: acon.lobs.value,
                                passontap: () {
                                  acon.lobs.toggle();
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                },
                              ),
                            ),
                            SizedBox(
                              height: 5.sp,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.to(() => ForgotpassView());
                                  },
                                  child: const Txt(
                                    text: 'Forgot password?',
                                    color: Colors.white,
                                    fsize: 11,
                                    weight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: const StadiumBorder(),
                                  primary: Get.theme.primaryColor,
                                ),
                                onPressed: () {
                                  if (acon.lmobile.text.isEmpty ||
                                      acon.lmobile.text.length != 10) {
                                    Fluttertoast.showToast(
                                      msg: 'Enter Valid Mobile Number',
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16,
                                    );
                                  } else if (acon.lpassword.text.isEmpty) {
                                    Fluttertoast.showToast(
                                      msg: 'Enter Password',
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16,
                                    );
                                  } else {
                                    acon.login();
                                  }
                                },
                                child: const Txt(
                                  text: '  Submit  ',
                                  color: Colors.white,
                                  defalutsize: true,
                                )),
                            SizedBox(
                              height: 5.sp,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.to(() => SignupView());
                                  },
                                  child: const Txt(
                                    text: 'Create accouunt quickly!',
                                    color: Colors.white,
                                    fsize: 11,
                                    weight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
