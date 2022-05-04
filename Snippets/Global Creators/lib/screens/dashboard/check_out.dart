import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_creater/controller/init.dart';
import 'package:global_creater/screens/addressbook/address_list.dart';
import 'package:global_creater/widgets/appbar.dart';
import 'package:global_creater/widgets/bottom_navigation.dart';
import 'package:global_creater/widgets/text.dart';
import 'package:sizer/sizer.dart';

import '../../api_endpoints.dart';

class CheckOutView extends StatefulWidget {
  CheckOutView({Key? key}) : super(key: key);

  @override
  State<CheckOutView> createState() => _CheckOutViewState();
}

class _CheckOutViewState extends State<CheckOutView> {
  final InitCon icon = Get.find();

  final TextEditingController cmnt = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BaseAppBar(
          title: 'Checkout',
          backicon: true,
          carticon: true,
        ),
        body: Obx(
          () => icon.checkoutlist.length == 0
              ? SizedBox()
              : ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
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
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 5.sp, horizontal: 5.sp),
                        child: Column(
                          children: [
                            if (icon.checkoutlist[0]['address'].toString() !=
                                "[]")
                              ListTile(
                                contentPadding: EdgeInsets.all(0),
                                leading: const Txt(
                                  text: 'Delivery\nAddress:',
                                  fsize: 12,
                                  weight: FontWeight.w500,
                                ),
                                title: Txt(
                                  text: icon.addname.value.toString() +
                                      '-' +
                                      icon.addmobile.value.toString() +
                                      '\n' +
                                      icon.adddoor.value.toString() +
                                      ',' +
                                      icon.addstreet.value.toString() +
                                      ',' +
                                      '\n' +
                                      'Landmark:' +
                                      icon.addlandmark.value.toString() +
                                      '\n' +
                                      icon.addpincode.value.toString(),
                                  fsize: 11,
                                  color: Colors.black87,
                                ),
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
                                      Get.to(() => AddressList(
                                            isadd: true,
                                            isgetcart: icon.checkoutlist[0]
                                                        ['address']
                                                    .toString() ==
                                                "[]",
                                          ));
                                    },
                                    child: Txt(
                                      text: icon.checkoutlist[0]['address']
                                                  .toString() !=
                                              "[]"
                                          ? 'Change or Edit'
                                          : 'Add Address',
                                      color: Colors.white,
                                      defalutsize: true,
                                    ))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 7.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Txt(
                            text: 'Products:',
                            fsize: 12,
                            weight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                    if (icon.checkoutlist.isNotEmpty)
                      ListView.builder(
                        itemCount: icon.checkoutlist[0]['items'].length,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          final item = icon.checkoutlist[0]['items'][index];
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 6.sp),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white70,
                                borderRadius: BorderRadius.circular(10.sp),
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
                              child: Row(
                                children: [
                                  Container(
                                    height: 80.sp,
                                    width: 80.sp,
                                    child: CachedNetworkImage(
                                        imageUrl: API().imgbaseurl +
                                            item['product_image'],
                                        placeholder: (context, url) =>
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                              ),
                                            )),
                                  ),
                                  Expanded(
                                      child: Container(
                                    height: 80.sp,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
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
                                                      text:
                                                          item['product_name'],
                                                      fsize: 12,
                                                      weight: FontWeight.bold,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  if (icon
                                                          .checkoutlist[0]
                                                              ['items']
                                                          .length ==
                                                      1) {
                                                    icon.totalvalue.value = '0';
                                                    icon.totalitems.value = '0';
                                                    Get.offAll(() =>
                                                        BottomNavigation(
                                                            currentindex: 0));
                                                    icon.deletecartitem(
                                                        item['cart_id']);
                                                  } else {
                                                    icon.deletecartitem(
                                                        item['cart_id']);
                                                  }
                                                },
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Get.theme
                                                            .primaryColor),
                                                    child: Padding(
                                                      padding: EdgeInsets.all(
                                                          2.0.sp),
                                                      child: Icon(
                                                        Icons.close,
                                                        size: 10.sp,
                                                        color: Colors.white,
                                                      ),
                                                    )),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5.sp),
                                            child: Row(
                                              children: [
                                                const Txt(
                                                  text: 'Quantity:     ',
                                                  color: Colors.black87,
                                                  fsize: 10,
                                                ),
                                                SizedBox(
                                                  width: 5.sp,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.sp)),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(2.0.sp),
                                                    child: Row(
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            var qty = int.parse(
                                                                    item[
                                                                        'qty']) -
                                                                1;
                                                            icon.updateqty(
                                                                item['cart_id'],
                                                                qty.toString());

                                                            print(qty);
                                                            //  setState(() {});
                                                          },
                                                          child: Icon(
                                                            Icons.remove_circle,
                                                            color: Get.theme
                                                                .primaryColor,
                                                            size: 12.sp,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5.sp,
                                                        ),
                                                        Txt(
                                                          text: item['qty'],
                                                          fsize: 12,
                                                        ),
                                                        SizedBox(
                                                          width: 5.sp,
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            var qty = int.parse(
                                                                    item[
                                                                        'qty']) +
                                                                1;
                                                            icon.updateqty(
                                                                item['cart_id'],
                                                                qty.toString());
                                                          },
                                                          child: Icon(
                                                            Icons.add_circle,
                                                            color: Get.theme
                                                                .primaryColor,
                                                            size: 12.sp,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  const Txt(
                                                    text: 'Empty Can: ',
                                                    color: Colors.black87,
                                                    fsize: 10,
                                                  ),
                                                  SizedBox(
                                                    width: 5.sp,
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey
                                                            .withOpacity(0.5),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10.sp)),
                                                    child: Padding(
                                                      padding: EdgeInsets.all(
                                                          2.0.sp),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.remove_circle,
                                                            color: Get.theme
                                                                .primaryColor,
                                                            size: 12.sp,
                                                          ),
                                                          SizedBox(
                                                            width: 5.sp,
                                                          ),
                                                          Txt(
                                                            text: '2',
                                                            fsize: 12,
                                                          ),
                                                          SizedBox(
                                                            width: 5.sp,
                                                          ),
                                                          Icon(
                                                            Icons.add_circle,
                                                            color: Get.theme
                                                                .primaryColor,
                                                            size: 12.sp,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Txt(
                                                    text: '₹ ${ int.parse(item['qty']) * int.parse(item['price']) }',
                                                    fsize: 10,
                                                    weight: FontWeight.bold,
                                                  ),
                                                  SizedBox(
                                                    width: 5.sp,
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              2.sp),
                                                      color: Get
                                                          .theme.primaryColor,
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 2.sp,
                                                              horizontal: 4.sp),
                                                      child: Txt(
                                                        text:
                                                            '${item['litre']}L',
                                                        color: Colors.white,
                                                        fsize: 8,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ))
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    SizedBox(
                      height: 4.sp,
                    ),
                    Container(
                        padding: EdgeInsets.all(5.sp),
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          border: Border.all(
                              color: Get.theme.primaryColor, width: 1),
                          borderRadius: BorderRadius.circular(7.sp),
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
                        child: TextField(
                          maxLines: 3,
                          controller: cmnt,
                          decoration: const InputDecoration(
                              hintText: "Add comments",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none),
                        )),
                    SizedBox(
                      height: 7.sp,
                    ),
                    // if (icon.checkoutlist[0]['referal_points'].toString() !=
                    //     '0')
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(5.sp),
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
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.sp, horizontal: 8.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Txt(
                                  text: 'Referel Points:',
                                  fsize: 13,
                                  weight: FontWeight.w500,
                                ),
                                SizedBox(
                                  width: 10.sp,
                                ),
                                Container(
                                  height: 10.sp,
                                  width: 10.sp,
                                  child: Image.asset('assets/token.png'),
                                ),
                                SizedBox(
                                  width: 7.sp,
                                ),
                                Txt(
                                  text:
                                      '${icon.checkoutlist[0]['referal_points']} points',
                                  fsize: 12,
                                )
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                Get.dialog(Center(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: Container(
                                      width: Get.width * .8,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10.sp)),
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0.sp),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Txt(
                                              text: 'Alert!',
                                              color: Get.theme.primaryColor,
                                              fsize: 16,
                                              weight: FontWeight.bold,
                                            ),
                                            SizedBox(
                                              height: 10.sp,
                                            ),
                                            const Txt(
                                              text:
                                                  'Are you sure want to use your\n referel ponits for this order?',
                                              color: Colors.grey,
                                              iscenter: true,
                                              fsize: 10,
                                            ),
                                            SizedBox(
                                              height: 10.sp,
                                            ),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  shape: const StadiumBorder(),
                                                  primary:
                                                      Get.theme.primaryColor,
                                                ),
                                                onPressed: () {
                                                  Get.back();
                                                  // icon.deletaddress(
                                                  //     add['address_id']);
                                                },
                                                child: const Txt(
                                                  text: 'Apply',
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
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3.sp),
                                  color: Get.theme.primaryColor,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 2.sp, horizontal: 4.sp),
                                  child: const Txt(
                                    text: 'Use',
                                    color: Colors.white,
                                    fsize: 10,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(2.sp),
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
                      child: Padding(
                        padding: EdgeInsets.all(8.0.sp),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Txt(
                                  text: 'Delivery Charges',
                                  fsize: 12,
                                ),
                                Txt(
                                  text:
                                      ' :   ${icon.checkoutlist[0]['delivery_charged']}',
                                  fsize: 12,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8.sp,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Txt(
                                  text: 'New Can Deposit',
                                  fsize: 12,
                                ),
                                Txt(
                                  text:
                                      ' :   ${icon.checkoutlist[0]['new_can_deposit']}',
                                  fsize: 12,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8.sp,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Txt(
                                  text: 'GST',
                                  fsize: 12,
                                ),
                                Txt(
                                  text: ' :     ${icon.checkoutlist[0]['gst']}',
                                  fsize: 12,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8.sp,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Txt(
                                  text: 'Referel Points',
                                  fsize: 12,
                                ),
                                Row(
                                  children: [
                                    Container(
                                        height: 10.sp,
                                        width: 10.sp,
                                        child: Image.asset('assets/token.png')),
                                    SizedBox(
                                      width: 5.sp,
                                    ),
                                    Txt(
                                      text:
                                          ' x ${icon.checkoutlist[0]['referal_points']} ',
                                      fsize: 12,
                                    ),
                                    Txt(
                                      text: ' :   150',
                                      fsize: 12,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8.sp,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Txt(
                                  text:
                                      'Total : ₹${icon.checkoutlist[0]['total_pay']}',
                                  fsize: 12,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.sp,
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
                              icon.paynow(icon.checkoutlist[0]['total_pay'],
                                  cmnt.text.toString());
                            },
                            child: const Txt(
                              text: 'Proceed to Pay',
                              color: Colors.white,
                              defalutsize: true,
                            ))
                      ],
                    )
                  ],
                ),
        ));
  }
}
