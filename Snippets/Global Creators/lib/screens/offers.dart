import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_creater/controller/init.dart';
import 'package:global_creater/widgets/appbar.dart';
import 'package:global_creater/widgets/text.dart';
import 'package:sizer/sizer.dart';

import '../api_endpoints.dart';

class OffersView extends StatelessWidget {
  OffersView({Key? key}) : super(key: key);
  final InitCon icon = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        backicon: true,
        title: 'Offers',
        carticon: true,
      ),
      body: Obx(() => icon.offerlist.isEmpty
          ? const Center(
              child: Txt(
                text: 'No Offers Found',
                fsize: 12,
              ),
            )
          : ListView.builder(
              itemCount: icon.offerlist.length,
              itemBuilder: (context, index) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.sp),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.sp),
                            bottomRight: Radius.circular(10.sp),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 5,
                              blurRadius: 6,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: CachedNetworkImage(
                            imageUrl: API().imgbaseurl +
                                icon.offerlist[index]['offer_image'],
                            placeholder: (context, url) => Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.grey.withOpacity(0.2),
                                  ),
                                )),
                      ),
                    ));
              })),
    );
  }
}
