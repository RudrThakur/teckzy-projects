import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:global_creater/controller/init.dart';
import 'package:global_creater/screens/dashboard/profile.dart';
import 'package:global_creater/widgets/bottom_navigation.dart';

import 'text.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool center;
  final bool backicon;
  final bool carticon;
  final VoidCallback ontap;
  static _defaultFunction() {
    Get.back();
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  BaseAppBar(
      {Key? key,
      this.title = 'Global Creators',
      this.center = true,
      this.backicon = false,
      this.ontap = _defaultFunction,
      this.carticon = false})
      : super(key: key);
  final InitCon icon = Get.find();
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: center,
      title: Txt(
        text: title,
        color: Colors.white,
        weight: FontWeight.bold,
        defalutsize: true,
      ),
      actions: [
        if (carticon)
          IconButton(
            onPressed: () {
              Get.back();
              Get.offAll(() => BottomNavigation(currentindex: 2));
            },
            icon: const Icon(
                      CupertinoIcons.person_fill,
                      size: 26.0,
                    ),
          )
      ],
      leading: backicon
          ? IconButton(
              onPressed: ontap,
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ))
          : IconButton(
              icon: const Icon(
                Icons.sort,
                color: Colors.white,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
      backgroundColor: Get.theme.primaryColor,
    );
  }
}
