import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:global_creater/controller/init.dart';
import 'package:global_creater/screens/addressbook/address_list.dart';
import 'package:global_creater/screens/auth/login.dart';
import 'package:global_creater/widgets/bottom_navigation.dart';
import 'package:global_creater/widgets/text.dart';
import 'package:global_creater/widgets/text_field.dart';
import 'package:sizer/sizer.dart';
import '../reset_password.dart';

class ProfileView extends StatefulWidget {
  ProfileView({Key? key}) : super(key: key);
  
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final InitCon icon = Get.find();
  bool error = false;

  validate() {
    
    if (icon.surrendercount.value.text.isNotEmpty &&
      icon.surrendercomments.value.text.isNotEmpty) {
        setState(() {
          error = false;
        });

        Get.back();
        icon.surrendar();
      }

      else {
        setState(() {
          error = true;
        });

        Fluttertoast.showToast(
          msg: 'Please fill all the required fields',
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16,
        );
      }

      print(error);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Obx(
      () => ListView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: EdgeInsets.all(8.sp),
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(10.sp),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 6,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(8.0.sp),
              child: Column(
                children: [
                  Container(
                    height: 50.sp,
                    width: 50.sp,
                    child: Image.asset('assets/man.png'),
                  ),
                  SizedBox(
                    height: 5.sp,
                  ),
                  Txt(
                    text: icon.myprofile['customer_name'].toString(),
                    fsize: 10.sp,
                    weight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  Txt(
                    text: icon.myprofile['mobile_no'].toString(),
                    fsize: 8.sp,
                    weight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 5.sp,
                  ),
                  Row(
                    children: [
                      const Txt(
                        text: 'Referel Points            :',
                        fsize: 12,
                      ),
                      Txt(
                        text:
                            '   ' + icon.myprofile['referal_points'].toString(),
                        fsize: 12,
                        color: Colors.black87,
                        weight: FontWeight.bold,
                      ),
                      SizedBox(
                        width: 5.sp,
                      ),
                      Container(
                        height: 15.sp,
                        width: 15.sp,
                        child: Image.asset('assets/token.png'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.sp,
                  ),
                  Row(
                    children: [
                      const Txt(
                        text: 'Total Available Cans :',
                        fsize: 12,
                      ),
                      Txt(
                        text: icon.myprofile['available_cans'].toString() ==
                                'null'
                            ? '   0'
                            : '    ' +
                                icon.myprofile['available_cans'].toString(),
                        fsize: 12,
                        color: Colors.black87,
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.sp,
                  ),
                  Row(
                    children: [
                      const Txt(
                        text: 'Pending Amount        :',
                        fsize: 12,
                        color: Colors.red,
                      ),
                      Txt(
                        text: icon.myprofile['pending_payment'].toString() ==
                                'null'
                            ? '₹ 0'
                            : '₹ ' +
                                icon.myprofile['pending_payment'].toString(),
                        fsize: 12,
                        color: Colors.black87,
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15.sp,
          ),
          ProfileTile(
            icon: CupertinoIcons.bag_fill,
            text: 'Order History',
            ontap: () {
              Get.offAll(() => BottomNavigation(currentindex: 1));
            },
          ),
          ProfileTile(
            icon: CupertinoIcons.lock_fill,
            text: 'Change Password',
            ontap: () {
              Get.to(() => ResetPassword());
            },
          ),
          if (icon.myprofile['available_cans'].toString() != 'null')
            ProfileTile(
              icon: CupertinoIcons.refresh,
              text: 'Surrender',
              ontap: () {
                Get.dialog(Center(
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      width: Get.width * .8,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.sp)),
                      child: Padding(
                        padding: EdgeInsets.all(8.0.sp),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Txt(
                              text: 'Surrender Cans?',
                              color: Get.theme.primaryColor,
                              fsize: 16,
                              weight: FontWeight.bold,
                            ),
                            SizedBox(
                              height: 10.sp,
                            ),
                            const Txt(
                              text:
                                  'Are you sure want to surrender\n your cans.',
                              color: Colors.grey,
                              iscenter: true,
                              fsize: 10,
                            ),
                            SizedBox(
                              height: 10.sp,
                            ),
                            CTextField(
                              controller: icon.surrendercount,
                              hint: 'Number of Cans',
                              istheme: true,
                              keyboard: TextInputType.number,
                              max: 5,
                            ),
                            SizedBox(
                              height: 10.sp,
                            ),
                            CTextField(
                              controller: icon.surrendercomments,
                              hint: 'Comments',
                              istheme: true,
                              keyboard: TextInputType.text,
                            ),
                             SizedBox(
                              height: 10.sp,
                            ),
                            error ? const Txt(
                              text: 'Please fill all the required fields',
                              color: Colors.red,
                              fsize: 10,
                            ) : const SizedBox(),
                            SizedBox(
                              height: 10.sp,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: const StadiumBorder(),
                                  primary: Get.theme.primaryColor,
                                ),
                                onPressed: () => validate(),
                                child: const Txt(
                                  text: 'Surrender',
                                  color: Colors.white,
                                  defalutsize: true,
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ));
              },
            ),
          ProfileTile(
            icon: CupertinoIcons.book_fill,
            text: 'Address Book',
            ontap: () {
              Get.to(() => AddressList());
            },
          ),
          ProfileTile(
            icon: Icons.logout,
            text: 'Logout',
            ontap: () {
              Get.dialog(Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: Container(
                      height: 150,
                      width: Get.width * .80,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Txt(
                              text: 'Are you sure want to Logout?',
                              weight: FontWeight.bold,
                              color: Colors.grey,
                              defalutsize: true,
                              iscenter: true,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    final InitCon icon = Get.find();
                                    icon.totalvalue.value = '0';
                                    icon.totalitems.value = '0';
                                    GetStorage().remove('userid');
                                    GetStorage().remove('username');
                                    GetStorage().remove('mobile');

                                    Get.offAll(() => LoginView());
                                  },
                                  child: const Txt(
                                    text: 'YES',
                                    defalutsize: true,
                                    color: Colors.red,
                                    weight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                InkWell(
                                  onTap: () => Get.back(),
                                  child: const Txt(
                                    text: 'NO',
                                    defalutsize: true,
                                    color: Colors.green,
                                    weight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ));
            },
          ),
        ],
      ),
    ));
  }
}

class ProfileTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback ontap;
  const ProfileTile(
      {Key? key, required this.icon, required this.text, required this.ontap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: ontap,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(2.sp),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 6,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 8.sp),
              child: Row(
                children: [
                  Icon(
                    icon,
                    size: 18.sp,
                    color: Get.theme.primaryColor,
                  ),
                  SizedBox(
                    width: 8.sp,
                  ),
                  Txt(
                    text: text,
                    fsize: 12,
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10.sp,
        )
      ],
    );
  }
}
