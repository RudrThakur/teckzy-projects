import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:global_creater/controller/auth.dart';
import 'package:global_creater/widgets/text.dart';
import 'package:global_creater/widgets/text_field.dart';
import 'package:sizer/sizer.dart';

class SignupView extends StatelessWidget {
  SignupView({Key? key}) : super(key: key);
  final TextEditingController tcon = TextEditingController();
  final TextEditingController tcon1 = TextEditingController();
  final TextEditingController tcon2 = TextEditingController();
  final TextEditingController tcon3 = TextEditingController();
  final TextEditingController tcon4 = TextEditingController();
  final TextEditingController tcon5 = TextEditingController();
  final AuthCon acon = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        child: ListView(
          children: [
            Container(
              height: 13.h,
              child: Center(
                child: Container(
                  height: 10.h,
                  width: 80.w,
                  child: Image.asset('assets/GLobal Creaotrs logo.png'),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Txt(
                    text: 'Register',
                    color: Get.theme.primaryColor,
                    fsize: 15,
                    weight: FontWeight.bold,
                  )
                ],
              ),
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
              controller: acon.sfirstname,
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
              controller: acon.sphone,
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
                    text: 'Email',
                    fsize: 12,
                  )
                ],
              ),
            ),
            CTextField(
              controller: acon.semail,
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
                    text: 'Password',
                    fsize: 12,
                  )
                ],
              ),
            ),
            Obx(() => CTextField(
                  controller: acon.spassword,
                  istheme: true,
                  ispass: true,
                  isvisible: acon.sobs.value,
                  obs: acon.sobs.value,
                  passontap: () {
                    acon.sobs.toggle();
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                )),
            SizedBox(
              height: 10.sp,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                children: const [
                  Txt(
                    text: 'Confirm Password',
                    fsize: 12,
                  )
                ],
              ),
            ),
            Obx(() => CTextField(
                  controller: acon.sconfirmpassword,
                  istheme: true,
                  ispass: true,
                  isvisible: acon.scobs.value,
                  obs: acon.scobs.value,
                  passontap: () {
                    acon.scobs.toggle();
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                )),
            SizedBox(
              height: 10.sp,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                children: const [
                  Txt(
                    text: 'Referrer Code',
                    fsize: 12,
                  )
                ],
              ),
            ),
            CTextField(
              controller: acon.referalcode,
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
                      if (acon.sfirstname.text.isEmpty) {
                        Fluttertoast.showToast(
                          msg: 'First Name Required',
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16,
                        );
                      } else if (acon.sphone.text.isEmpty) {
                        Fluttertoast.showToast(
                          msg: 'Mobile Number Required',
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16,
                        );
                      } else if (acon.semail.text.isEmpty) {
                        Fluttertoast.showToast(
                          msg: 'Email Required',
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16,
                        );
                      } else if (acon.spassword.text.isEmpty) {
                        Fluttertoast.showToast(
                          msg: 'Password Required',
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16,
                        );
                      } else if (acon.sconfirmpassword.text.isEmpty) {
                        Fluttertoast.showToast(
                          msg: 'Confirm Password Required',
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16,
                        );
                      } else if (acon.sphone.text.length != 10) {
                        Fluttertoast.showToast(
                          msg: 'Enter Valid Mobile Number',
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16,
                        );
                      } else if (acon.spassword.text.length < 5) {
                        Fluttertoast.showToast(
                          msg: 'Password should be above 5 characters',
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16,
                        );
                      } else if (!acon.semail.text.trim().toString().isEmail) {
                        Fluttertoast.showToast(
                          msg: 'Enter Valid Email',
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16,
                        );
                      } else if (acon.spassword.text !=
                          acon.sconfirmpassword.text) {
                        Fluttertoast.showToast(
                          msg: 'Password Not Matched',
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16,
                        );
                      } else {
                        acon.generateotp();
                      }
                    },
                    child: const Txt(
                      text: '  Submit  ',
                      color: Colors.white,
                      defalutsize: true,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
