import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:global_creater/controller/auth.dart';
import 'package:global_creater/widgets/appbar.dart';
import 'package:global_creater/widgets/text.dart';
import 'package:global_creater/widgets/text_field.dart';
import 'package:sizer/sizer.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({Key? key}) : super(key: key);
  final AuthCon acon = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        backicon: true,
        title: 'Change password',
        carticon: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0.sp),
        child: ListView(
          children: [
            Obx(
              () => CTextField(
                controller: acon.coldpass,
                hint: 'Old Password',
                ispass: true,
                istheme: true,
                obs: acon.oobs.value,
                isvisible: acon.oobs.value,
                passontap: () {
                  acon.oobs.toggle();
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
              ),
            ),
            SizedBox(
              height: 20.sp,
            ),
            Obx(
              () => CTextField(
                controller: acon.cnewpass,
                hint: 'New Password',
                ispass: true,
                istheme: true,
                obs: acon.nobs.value,
                isvisible: acon.nobs.value,
                passontap: () {
                  acon.nobs.toggle();
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
              ),
            ),
            SizedBox(
              height: 20.sp,
            ),
            Obx(
              () => CTextField(
                controller: acon.cnewcpass,
                hint: 'Confirm Password',
                ispass: true,
                istheme: true,
                obs: acon.ncobs.value,
                isvisible: acon.ncobs.value,
                passontap: () {
                  acon.ncobs.toggle();
                  FocusScope.of(context).requestFocus(FocusNode());
                },
              ),
            ),
            SizedBox(
              height: 20.sp,
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
                      if (acon.coldpass.text.isEmpty) {
                        Fluttertoast.showToast(
                          msg: 'Old Password Required',
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16,
                        );
                      } else if (acon.cnewpass.text.isEmpty) {
                        Fluttertoast.showToast(
                          msg: 'New Password Required',
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16,
                        );
                      } else if (acon.cnewcpass.text.isEmpty) {
                        Fluttertoast.showToast(
                          msg: 'Confirm Password Required',
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16,
                        );
                      } else if (acon.cnewpass.text.length < 5) {
                        Fluttertoast.showToast(
                          msg: 'Password should above 5 characters',
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16,
                        );
                      } else if (acon.cnewcpass.text != acon.cnewpass.text) {
                        Fluttertoast.showToast(
                          msg: 'Password Not Matched',
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16,
                        );
                      } else {
                        acon.changepassword();
                      }
                    },
                    child: const Txt(
                      text: '  Confirm  ',
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
