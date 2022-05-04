import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:global_creater/controller/auth.dart';
import 'package:global_creater/screens/auth/forgot_password_reset.dart';
import 'package:global_creater/widgets/text.dart';
import 'package:global_creater/widgets/text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:sizer/sizer.dart';
import 'package:timer_count_down/timer_controller.dart';

import 'package:timer_count_down/timer_count_down.dart';

class OtpView extends StatefulWidget {
  final String mobile;
  final bool isfogot;
  OtpView({Key? key, this.mobile = '', this.isfogot = false}) : super(key: key);

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  final TextEditingController tcon = TextEditingController();

  final TextEditingController pass = TextEditingController();
  final AuthCon acon = Get.find();
  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0.sp),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  final CountdownController _controller = CountdownController(autoStart: true);
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
                    ),
                  ),
                ),
                Container(
                  height: 40.h,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/single_can.png',
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
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Txt(
                                  text: 'Confrm OTP',
                                  color: Colors.white,
                                  fsize: 14,
                                  weight: FontWeight.w500,
                                )
                              ],
                            ),
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Txt(
                                        text:
                                            'Enter OTP we just to your phone number - ${widget.mobile}',
                                        color: Colors.white,
                                        fsize: 12,
                                        weight: FontWeight.w500,
                                        iscenter: true,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Spacer(),
                            PinPut(
                                controller: tcon,
                                onChanged: (o) {},
                                eachFieldPadding: const EdgeInsets.all(10),
                                eachFieldHeight: 35.sp,
                                eachFieldWidth: 35.sp,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                ],
                                textStyle: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                        letterSpacing: .8)),
                                followingFieldDecoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(3.0.sp),
                                ),
                                keyboardType: TextInputType.number,
                                submittedFieldDecoration:
                                    _pinPutDecoration.copyWith(
                                  borderRadius: BorderRadius.circular(100.0.sp),
                                ),
                                selectedFieldDecoration: _pinPutDecoration,
                                fieldsCount: 4),
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Obx(
                                  () => Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      if (!acon.isenabled.value)
                                        Countdown(
                                          seconds: 120,
                                          controller: _controller,
                                          build: (BuildContext context,
                                                  double time) =>
                                              Txt(
                                            text: 'Time Remaining ' +
                                                time.minutes
                                                    .toString()
                                                    .split(':')[0] +
                                                ':' +
                                                time.minutes
                                                    .toString()
                                                    .split(':')[1] +
                                                ' Sec',
                                            color: Colors.white,
                                            fsize: 12,
                                          ),
                                          interval: Duration(milliseconds: 100),
                                          onFinished: () {
                                            acon.isenabled.value = true;
                                          },
                                        )
                                    ],
                                  ),
                                ),
                                Obx(() => InkWell(
                                      onTap: () {
                                        acon.isenabled.value = false;
                                        acon.generateotp();
                                        if (mounted) {
                                          setState(() {
                                            //   _controller.restart();
                                          });
                                        }
                                      },
                                      child: Txt(
                                        text: !acon.isenabled.value == true
                                            ? ''
                                            : 'Resend OTP',
                                        fsize: 12,
                                        color: Colors.white,
                                        weight: FontWeight.w500,
                                      ),
                                    ))
                              ],
                            ),
                            Spacer(),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: const StadiumBorder(),
                                  primary: Get.theme.primaryColor,
                                ),
                                onPressed: () {
                                  if (acon.otp.value == tcon.text) {
                                    if (widget.isfogot) {
                                      Get.to(() => ForgotpassChangeView());
                                    } else {
                                      acon.signup();
                                    }
                                  } else {
                                    Fluttertoast.showToast(
                                      msg: 'Incorrect OTP',
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                    );
                                  }
                                },
                                child: const Txt(
                                  text: '  Submit  ',
                                  color: Colors.white,
                                  defalutsize: true,
                                )),
                            Spacer(),
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
