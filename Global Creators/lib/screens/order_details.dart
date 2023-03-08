import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_creater/controller/init.dart';
import 'package:global_creater/widgets/appbar.dart';
import 'package:global_creater/widgets/text.dart';
import 'package:sizer/sizer.dart';

import '../api_endpoints.dart';
import 'offlinepay.dart';

class OrderDetailsView extends StatelessWidget {
  OrderDetailsView({Key? key}) : super(key: key);
  final InitCon icon = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BaseAppBar(
          title: 'Order Details',
          backicon: true,
          carticon: true,
        ),
        body: Obx(() => icon.orderdetails.length == 0
            ? const Center(child: CupertinoActivityIndicator())
            : ListView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                padding: EdgeInsets.all(8.0.sp),
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(8.sp),
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
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                          height: 80.sp,
                          child: Padding(
                            padding: EdgeInsets.all(4.0.sp),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Txt(
                                  text:
                                      'Ordered on ${icon.orderdetails[0]['date_time']}',
                                  color: Colors.black87,
                                  fsize: 14,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.bottomSheet(Container(
                                      height: Get.height / 2,
                                      child: ListView.builder(
                                          itemCount: icon
                                              .orderdetails[0]['products']
                                              .length,
                                          itemBuilder: (context, i) {
                                            return Column(
                                              children: [
                                                ListTile(
                                                  subtitle: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Txt(
                                                        text: 'Qty:' +
                                                            icon.orderdetails[0]
                                                                    ['products']
                                                                [i]['qty'],
                                                        fsize: 11,
                                                        weight: FontWeight.w600,
                                                        color: Colors.grey,
                                                      ),
                                                      SizedBox(
                                                        height: 2.sp,
                                                      ),
                                                      Txt(
                                                        text: icon.orderdetails[
                                                                0]['products']
                                                            [i]['description'],
                                                        fsize: 13,
                                                        color: Colors.black,
                                                      ),
                                                    ],
                                                  ),
                                                  trailing: Txt(
                                                    text: '₹ ' +
                                                        icon.orderdetails[0]
                                                                ['products'][i]
                                                                ['price']
                                                            .toString(),
                                                    fsize: 13,
                                                    weight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                  leading: CachedNetworkImage(
                                                      imageUrl: API()
                                                              .imgbaseurl +
                                                          icon.orderdetails[0][
                                                                  'products'][i]
                                                              ['product_image'],
                                                      placeholder: (context,
                                                              url) =>
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.2),
                                                            ),
                                                          )),
                                                  title: Txt(
                                                    text: icon.orderdetails[0]
                                                            ['products'][i]
                                                        ['product_name'],
                                                    fsize: 13,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.sp,
                                                      vertical: 10.sp),
                                                  child: Container(
                                                    height: .5,
                                                    width: double.infinity,
                                                    color: Colors.grey,
                                                  ),
                                                )
                                              ],
                                            );
                                          }),
                                      color: Colors.white,
                                    ));
                                  },
                                  child: const Txt(
                                    text: 'View Items Detail >',
                                    color: Colors.red,
                                    fsize: 10,
                                  ),
                                ),
                                Txt(
                                  text:
                                      'Order value: ₹${icon.orderdetails[0]['total_payable']}',
                                  color: Colors.black87,
                                  fsize: 14,
                                )
                              ],
                            ),
                          ),
                        )),
                        SizedBox(
                          width: 8.sp,
                        ),
                        Container(
                          height: 80.sp,
                          width: 80.sp,
                          child: CachedNetworkImage(
                              imageUrl: API().imgbaseurl +
                                  icon.orderdetails[0]['products'][0]
                                      ['product_image'],
                              placeholder: (context, url) => Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey.withOpacity(0.2),
                                    ),
                                  )),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 13, top: 50),
                        width: 3,
                        height: 250,
                        color: Colors.grey[400],
                      ),
                      Column(
                        children: [
                          statusWidget("Order Placed", true),
                          statusWidget("Shipped", false),
                          statusWidget("Delivered", false),
                          statusWidget("Completed", false),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(5.sp),
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Txt(
                            text: 'Delivery Address',
                            fsize: 12,
                            weight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                          SizedBox(
                            height: 5.sp,
                          ),
                          Txt(
                            text: icon.orderdetails[0]['name'],
                            fsize: 10,
                            weight: FontWeight.w500,
                          ),
                          SizedBox(
                            height: 4.sp,
                          ),
                          Txt(
                            text: icon.orderdetails[0]['door_no'] +
                                ',' +
                                icon.orderdetails[0]['street'] +
                                ',' +
                                icon.orderdetails[0]['city'] +
                                ',' +
                                icon.orderdetails[0]['pincode'],
                            fsize: 9,
                            color: Colors.grey,
                          ),
                          Txt(
                            text:
                                'Landmark: ${icon.orderdetails[0]['landmark']}',
                            fsize: 9,
                            color: Colors.grey,
                          ),
                          Txt(
                            text: 'Contact: ${icon.orderdetails[0]['mobile']}',
                            fsize: 9,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.sp,
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
                            Get.to(() => OfflinePayment());
                          },
                          child: const Txt(
                            text: 'Offline payment',
                            color: Colors.white,
                            defalutsize: true,
                          )),
                      SizedBox(
                        width: 20.sp,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            primary: Get.theme.primaryColor,
                          ),
                          onPressed: () {},
                          child: const Txt(
                            text: 'Online payment',
                            color: Colors.white,
                            defalutsize: true,
                          ))
                    ],
                  ),
                  if (icon.orderdetails[0]['order_status'].toString() ==
                      'Cancelled')
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Txt(
                          text: 'NOTE: This Order is Cancelled!',
                          color: Colors.red,
                          fsize: 12,
                        ),
                      ],
                    ),
                  if (icon.orderdetails[0]['order_status'].toString() !=
                      'Cancelled')
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.red),
                        onPressed: () {
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
                                      const Txt(
                                        text: 'Alert!',
                                        color: Colors.red,
                                        fsize: 16,
                                        weight: FontWeight.bold,
                                      ),
                                      SizedBox(
                                        height: 10.sp,
                                      ),
                                      const Txt(
                                        text:
                                            'Are you sure want to cancel\n this order?',
                                        color: Colors.grey,
                                        iscenter: true,
                                        fsize: 10,
                                      ),
                                      SizedBox(
                                        height: 10.sp,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                shape: const StadiumBorder(),
                                                primary: Get.theme.primaryColor,
                                              ),
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: const Txt(
                                                text: 'Back',
                                                color: Colors.white,
                                                defalutsize: true,
                                              )),
                                          SizedBox(
                                            width: 10.sp,
                                          ),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                shape: const StadiumBorder(),
                                                primary: Colors.red,
                                              ),
                                              onPressed: () {
                                                icon.cencelorder(
                                                    icon.orderdetails[0]
                                                        ['order_id']);
                                              },
                                              child: const Txt(
                                                text: 'Cancel',
                                                color: Colors.white,
                                                defalutsize: true,
                                              )),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ));
                        },
                        child: const Text(
                          'Cancel Order',
                          style: TextStyle(color: Colors.white),
                        ))
                ],
              )));
  }

  Container statusWidget(String status, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          Container(
            height: 20,
            width: 30,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (isActive) ? Colors.green : Colors.white,
                border: Border.all(
                    color: (isActive) ? Colors.transparent : Colors.green,
                    width: 3)),
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            children: [
              Container(
                height: 20,
                width: 30,
              ),
              Txt(
                text: status,
                weight: FontWeight.bold,
                color: (isActive) ? Colors.green : Colors.black,
                dsize: 14,
                defalutsize: true,
              ),
              Container(
                height: 20,
                width: 40,
              ),
            ],
          )
        ],
      ),
    );
  }
}
