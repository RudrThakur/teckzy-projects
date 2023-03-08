import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_creater/widgets/text.dart';

class DrawerTile extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final IconData icon;
  const DrawerTile(
      {Key? key, required this.onTap, required this.title, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        child: ListTile(
          minLeadingWidth: 0,
          onTap: onTap,
          visualDensity: VisualDensity(horizontal: 0, vertical: -2.5),
          leading: CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(
              icon,
              color: Get.theme.primaryColor,
            ),
          ),
          title: Txt(
            text: title,
            defalutsize: true,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
