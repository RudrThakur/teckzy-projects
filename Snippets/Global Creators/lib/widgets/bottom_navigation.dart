import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:global_creater/controller/init.dart';
import 'package:global_creater/screens/dashboard/check_out.dart';
import 'package:global_creater/screens/dashboard/home.dart';
import 'package:global_creater/screens/dashboard/orders.dart';
import 'package:global_creater/screens/dashboard/profile.dart';
import 'package:global_creater/widgets/text.dart';
import 'package:sizer/sizer.dart';

import 'bottom.dart';
import 'appbar.dart';
import 'drawer.dart';

// ignore: must_be_immutable
class BottomNavigation extends StatefulWidget {
  int currentindex;
  BottomNavigation({Key? key, required this.currentindex}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  // ignore: prefer_final_fields
  List<Widget> _widgetOptions = <Widget>[
    // ignore: prefer_const_constructors
    HomeView(),
    // ignore: prefer_const_constructors
    OrdersView(),
    // ignore: prefer_const_constructors
    ProfileView(),
  ];

  DateTime? currentBackPressTime;

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
          msg: 'Press back button again to Exit!',
          backgroundColor: Colors.black54);
      return Future.value(false);
    }
    return Future.value(true);
  }

  final InitCon icon = Get.find();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: BaseAppBar(
          carticon: true,
        ),
        drawer: DrawerWidget(),
        body: Obx(() => Stack(
              children: [
                PageTransitionSwitcher(
                  duration: const Duration(milliseconds: 800),
                  transitionBuilder: (child, animation, secondaryAnimation) =>
                      FadeThroughTransition(
                    animation: animation,
                    secondaryAnimation: secondaryAnimation,
                    child: child,
                  ),
                  child: _widgetOptions.elementAt(widget.currentindex),
                ),
                icon.totalitems.value != '0'
                    ? Positioned(
                        bottom: 2.sp,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding: EdgeInsets.all(3.0.sp),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.sp),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10.sp),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Txt(
                                        text: '${icon.totalitems.value} ITEMS',
                                        fsize: 10,
                                        weight: FontWeight.bold,
                                      ),
                                      SizedBox(
                                        height: 3.sp,
                                      ),
                                      Row(
                                        children: [
                                          Txt(
                                            text: '₹ ${icon.totalvalue.value}',
                                            fsize: 10,
                                            weight: FontWeight.bold,
                                          ),
                                          const Txt(
                                            text: ' plus delivery charges',
                                            fsize: 10,
                                            weight: FontWeight.w500,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.to(() => CheckOutView());
                                        },
                                        child: const Txt(
                                          text: 'NEXT',
                                          weight: FontWeight.bold,
                                          fsize: 12,
                                        ),
                                      ),
                                      Icon(Icons.arrow_right_rounded,
                                          size: 15.sp,
                                          color: Get.theme.primaryColor)
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : SizedBox()
              ],
            )),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              color: Get.theme.primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              )),
          child: SalomonBottomBar(
            currentIndex: widget.currentindex,
            onTap: (i) => setState(() => widget.currentindex = i),
            items: [
              /// Home
              SalomonBottomBarItem(
                  icon: Image.asset(
                    'assets/home.png',
                    height: 15.sp,
                  ),
                  title: Text(
                    "HOME",
                    style: TextStyle(
                        color: Get.theme.primaryColor, fontSize: 10.sp),
                  ),
                  selectedColor: Colors.white),

              /// Likes
              SalomonBottomBarItem(
                  icon: Image.asset(
                    'assets/order.png',
                    height: 15.sp,
                  ),
                  title: Text(
                    "ORDERS",
                    style: TextStyle(
                        color: Get.theme.primaryColor, fontSize: 10.sp),
                  ),
                  selectedColor: Colors.white),

              /// Search
              SalomonBottomBarItem(
                  icon: Image.asset(
                    'assets/my-account.png',
                    height: 15.sp,
                  ),
                  title: Text(
                    "PROFILE",
                    style: TextStyle(
                        color: Get.theme.primaryColor, fontSize: 10.sp),
                  ),
                  selectedColor: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
