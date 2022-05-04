import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:global_creater/controller/init.dart';
import 'package:global_creater/screens/dashboard/profile.dart';
import 'package:global_creater/screens/feedback.dart';
import 'package:global_creater/screens/notifications.dart';
import 'package:global_creater/screens/offers.dart';
import 'package:global_creater/screens/reset_password.dart';
import 'package:global_creater/widgets/bottom_navigation.dart';
import 'package:global_creater/widgets/text.dart';
import 'package:global_creater/widgets/text_field.dart';
import 'package:share/share.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'drawer_tile.dart';

class DrawerWidget extends StatefulWidget {
  DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  // final HomeCon hcon = Get.find();
  bool _enabled = true;

  void _onTap() {
    setState(() => _enabled = false);
    Share.share(
      'Let me recommend you this application https://play.google.com/store/apps/details?id=com.teckzy.global_creators',
      subject: 'Check it out Global-Creators app',
    );
    Timer(const Duration(seconds: 1), () => setState(() => _enabled = true));
  }

   validate() {
    if (icon.surrendercount.value.text.isNotEmpty &&
      icon.surrendercomments.value.text.isNotEmpty) {
        Get.back();
        icon.surrendar();
      }

      else {
        Fluttertoast.showToast(
          msg: 'Please fill all the required fields',
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16,
        );
      }
  }

  final InitCon icon = Get.find();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Get.theme.primaryColor,
        child: ListView(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.sp,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            child: Image.asset('assets/man.png'),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Txt(
                            text: icon.myprofile['customer_name'],
                            dsize: 16,
                            defalutsize: true,
                            color: Colors.black87,
                            weight: FontWeight.bold,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Txt(
                            text: icon.myprofile['mobile_no'],
                            dsize: 14,
                            defalutsize: true,
                            color: Colors.grey,
                            weight: FontWeight.bold,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Txt(
                                text: 'Referel Points:',
                                dsize: 14,
                                defalutsize: true,
                              ),
                              Txt(
                                text:
                                    '${icon.myprofile['referal_points'].toString() == 'null' ? '0' : icon.myprofile['referal_points'].toString()} points',
                                dsize: 14,
                                defalutsize: true,
                                color: Colors.black87,
                                weight: FontWeight.bold,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Txt(
                                text: 'Total Available Cans:',
                                dsize: 14,
                                defalutsize: true,
                              ),
                              Txt(
                                text: icon.myprofile['available_cans'] ?? '0',
                                dsize: 14,
                                defalutsize: true,
                                color: Colors.black87,
                                weight: FontWeight.bold,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          if (icon.myprofile['pending_payment'].toString() !=
                              'null')
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Txt(
                                  text: 'Pending Amount:',
                                  dsize: 14,
                                  defalutsize: true,
                                  color: Colors.red,
                                ),
                                if (icon.myprofile['pending_payment']
                                        .toString() !=
                                    'null')
                                  Txt(
                                    text: '₹ ' +
                                                icon.myprofile[
                                                        'pending_payment']
                                                    .toString() ==
                                            'null'
                                        ? '₹ 0'
                                        : icon.myprofile['pending_payment']
                                            .toString(),
                                    dsize: 14,
                                    defalutsize: true,
                                    color: Colors.black87,
                                    weight: FontWeight.bold,
                                  ),
                              ],
                            ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
            ),
            const SizedBox(
              height: 5,
            ),
             DrawerTile(
                onTap: () {
                  Get.back();
                  Get.offAll(() => BottomNavigation(currentindex: 2));
                },
                title: 'Profile',
                icon: CupertinoIcons.person),
            DrawerTile(
                onTap: () {
                  Get.back();
                  Get.offAll(() => BottomNavigation(currentindex: 1));
                },
                title: 'Order History',
                icon: CupertinoIcons.bag_fill),
            DrawerTile(
                onTap: () {
                  Get.back();
                  Get.to(() => OffersView());
                },
                title: 'Offers',
                icon: CupertinoIcons.gift),
            DrawerTile(
                onTap: () {
                  Get.back();
                  Get.to(() => NotificationView());
                },
                title: 'Notifications',
                icon: CupertinoIcons.bell),
            DrawerTile(
                onTap: () {
                  if (_enabled) _onTap();
                },
                title: 'Share App',
                icon: Icons.share),
            DrawerTile(
                onTap: () {
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
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: const StadiumBorder(),
                                  primary: Get.theme.primaryColor,
                                ),
                                onPressed: () {
                                  validate();
                                },
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
                title: 'Surrender',
                icon: Icons.refresh),
            DrawerTile(
                onTap: () {
                  Get.back();
                  Get.to(() => ResetPassword());
                },
                title: 'Change password',
                icon: CupertinoIcons.lock_fill),
            DrawerTile(
                onTap: () {
                  Get.back();
                },
                title: 'Privacy Policy',
                icon: Icons.privacy_tip),
            
            DrawerTile(
                onTap: () {
                  Get.back();
                },
                title: 'Need Help?',
                icon: Icons.help),
            DrawerTile(
                onTap: () {
                  Get.back();
                },
                title: 'Terms & Conditions',
                icon: Icons.notes),
            DrawerTile(
                onTap: () {
                  Get.back();
                },
                title: 'About',
                icon: Icons.error),
            DrawerTile(
                onTap: () {
                  // openwhatsapp();

                  Get.back();
                },
                title: 'Contact Us',
                icon: Icons.contact_mail),
            DrawerTile(
                onTap: () {
                  Get.back();
                  Get.to(() => FeedBackView());
                },
                title: 'Feedback',
                icon: Icons.feedback),
          ],
        ),
      ),
    );
  }
}
