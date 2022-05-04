import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_creater/controller/init.dart';
import 'package:global_creater/widgets/appbar.dart';
import 'package:global_creater/widgets/text.dart';
import 'package:sizer/sizer.dart';

class NotificationView extends StatelessWidget {
  NotificationView({Key? key}) : super(key: key);
  final InitCon icon = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Notifications',
        backicon: true,
        carticon: false,
      ),
      body: Obx(() => icon.notificationlist.isEmpty
          ? Center(
              child: Txt(
                text: 'No Data Found',
                fsize: 12.sp,
              ),
            )
          : ListView.builder(
              itemCount: icon.notificationlist.length,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(2.sp),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 6,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: ListTile(
                      minLeadingWidth: 0,
                      leading: Icon(
                        CupertinoIcons.globe,
                        color: Get.theme.primaryColor,
                      ),
                      title: Txt(
                        text: icon.notificationlist[index]['title'],
                        fsize: 12,
                        weight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                      subtitle: Txt(
                        text: icon.notificationlist[index]['message'],
                        fsize: 10,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                );
              },
            )),
    );
  }
}
