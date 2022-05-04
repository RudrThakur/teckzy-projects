import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_creater/controller/init.dart';
import 'package:global_creater/widgets/text.dart';
import 'package:sizer/sizer.dart';

import '../../api_endpoints.dart';
import '../order_details.dart';

class OrdersView extends StatelessWidget {
  OrdersView({Key? key}) : super(key: key);
  final InitCon icon = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => icon.myorderslist.length == 0
          ? Center(
              child: Txt(
                text: 'No Orders Found',
              ),
            )
          : ListView.builder(
              itemCount: icon.myorderslist.length,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemBuilder: (context, index) {
                final order = icon.myorderslist[index];
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0.sp),
                      child: InkWell(
                        onTap: () {
                          icon.getorderdetail(order['order_id']);
                          Get.to(() => OrderDetailsView());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(2.sp),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 5,
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                color: Colors.white70,
                                width: 80.sp,
                                height: 80.sp,
                                child: CachedNetworkImage(
                                    imageUrl: API().imgbaseurl +
                                        order['products'][0]['product_image'],
                                    placeholder: (context, url) => Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            color: Colors.grey.withOpacity(0.2),
                                          ),
                                        )),
                              ),
                              // Container(
                              //   color: Colors.white70,
                              //   width: 8.sp,
                              // ),
                              Expanded(
                                  child: Container(
                                color: Colors.white70,
                                height: 80.sp,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Txt(
                                                text: order['products'][0]
                                                    ['product_name'],
                                                fsize: 10,
                                                weight: FontWeight.bold,
                                                lines: 2,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Txt(
                                              text:
                                                  'Order Id: ${order['order_unique_id']}',
                                              fsize: 9,
                                              color: Colors.black87,
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              size: 10.sp,
                                              color: Get.theme.primaryColor,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Txt(
                                          text:
                                              'Delivered on ${order['delivery_date']}',
                                          color: Colors.black87,
                                          fsize: 10,
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Txt(
                                          text:
                                              'Order On: ${order['order_date']}',
                                          color: Colors.black87,
                                          fsize: 10,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ))
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (index == icon.myorderslist.length - 1)
                      SizedBox(
                        height: 100.sp,
                      )
                  ],
                );
              }),
    ));
  }
}
