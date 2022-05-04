import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:global_creater/controller/home.dart';
import 'package:global_creater/controller/init.dart';
import 'package:global_creater/screens/dashboard/check_out.dart';
import 'package:global_creater/widgets/appbar.dart';
import 'package:global_creater/widgets/text.dart';
import 'package:global_creater/widgets/category_filter.dart';
import 'package:sizer/sizer.dart';

import '../../api_endpoints.dart';

class ProductsView extends StatefulWidget {
  ProductsView({Key? key}) : super(key: key);

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  final InitCon icon = Get.find();
  final HomeCon hcon = Get.find();

  List<int> productcount = [];

  List<int> emptycount = [];

  _incrementCounter(int i) {
    setState(() {
      productcount[i]++;
      emptycount[i]++;
    });
  }

  _empincrementCounter(int i) {
    setState(() {
      if (productcount[i] != emptycount[i]) {
        emptycount[i]++;
      }
    });
  }

  _decrementCounter(int i) {
    if (productcount[i] <= 0) {
      productcount[i] = 0;
    } else {
      setState(() {
        productcount[i]--;
      });
    }
  }

  _empdecrementCounter(int i) {
    if (emptycount[i] <= 0) {
      emptycount[i] = 0;
    } else {
      setState(() {
        emptycount[i]--;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    icon.getproducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        backicon: true,
        title: icon.getcategoryname(),
        carticon: true,
      ),
      body: Obx(
        () => Stack(
          children: [
            Positioned.fill(
              child: ListView(
                padding: EdgeInsets.all(10.sp),
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0.sp),
                    child: Obx(() => GridView.builder(
                        itemCount: icon.productlist.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 20,
                                childAspectRatio: 0.7),
                        itemBuilder: (context, index) {
                          if (productcount.length < icon.productlist.length) {
                            productcount.add(0);
                          }
                          if (emptycount.length < icon.productlist.length) {
                            emptycount.add(0);
                          }
                          return Container(
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
                            child: Column(
                              children: [
                                Expanded(
                                    child: Stack(
                                  children: [
                                    Container(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10.sp)),
                                        child: Image.network(
                                          API().imgbaseurl +
                                              icon.productlist[index]
                                                  ['product_image'],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        right: 3.sp,
                                        top: 5.sp,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3.sp),
                                            color: Get.theme.primaryColor,
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 2.sp,
                                                vertical: 1.sp),
                                            child: Center(
                                              child: Txt(
                                                text: icon.productlist[index]
                                                            ['litre']
                                                        .toString() +
                                                    ' L',
                                                color: Colors.white,
                                                fsize: 8,
                                                weight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ))
                                  ],
                                )),
                                Padding(
                                  padding: EdgeInsets.all(4.sp),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Txt(
                                            text: icon.productlist[index]
                                                    ['product_name']
                                                .toString(),
                                            fsize: 9,
                                            weight: FontWeight.bold,
                                          ),
                                          Txt(
                                            text:
                                                '₹ ${icon.productlist[index]['price'].toString()}',
                                            fsize: 10,
                                            weight: FontWeight.bold,
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5.sp),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Txt(
                                              text: 'Quantity:    ',
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
                                                padding: EdgeInsets.all(2.0.sp),
                                                child: Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        _decrementCounter(
                                                            index);
                                                      },
                                                      child: Icon(
                                                        Icons.remove_circle,
                                                        color: Get
                                                            .theme.primaryColor,
                                                        size: 12.sp,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5.sp,
                                                    ),
                                                    Txt(
                                                      text: productcount[index]
                                                          .toString(),
                                                      fsize: 12,
                                                    ),
                                                    SizedBox(
                                                      width: 5.sp,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        _incrementCounter(
                                                            index);
                                                      },
                                                      child: Icon(
                                                        Icons.add_circle,
                                                        color: Get
                                                            .theme.primaryColor,
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
                                          const Txt(
                                            text: 'Empty Can:',
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
                                              padding: EdgeInsets.all(2.0.sp),
                                              child: Row(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      _empdecrementCounter(
                                                          index);
                                                    },
                                                    child: Icon(
                                                      Icons.remove_circle,
                                                      color: Get
                                                          .theme.primaryColor,
                                                      size: 12.sp,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5.sp,
                                                  ),
                                                  Txt(
                                                    text: emptycount[index]
                                                        .toString(),
                                                    fsize: 12,
                                                  ),
                                                  SizedBox(
                                                    width: 5.sp,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      _empincrementCounter(
                                                          index);
                                                    },
                                                    child: Icon(
                                                      Icons.add_circle,
                                                      color: Get
                                                          .theme.primaryColor,
                                                      size: 12.sp,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 4.sp),
                                        child: InkWell(
                                          onTap: () {
                                            Get.dialog(Center(
                                              child: Material(
                                                color: Colors.transparent,
                                                child: Container(
                                                  width: Get.width * .8,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.sp)),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0.sp),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Txt(
                                                          text: icon
                                                              .productlist[
                                                                  index][
                                                                  'product_name']
                                                              .toString(),
                                                          color: Get.theme
                                                              .primaryColor,
                                                          fsize: 16,
                                                          weight:
                                                              FontWeight.bold,
                                                        ),
                                                        SizedBox(
                                                          height: 10.sp,
                                                        ),
                                                        Txt(
                                                          text: icon
                                                              .productlist[
                                                                  index][
                                                                  'description']
                                                              .toString(),
                                                          color: Colors.grey,
                                                          fsize: 10,
                                                        ),
                                                        SizedBox(
                                                          height: 10.sp,
                                                        ),
                                                        ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              shape:
                                                                  const StadiumBorder(),
                                                              primary: Get.theme
                                                                  .primaryColor,
                                                            ),
                                                            onPressed: () =>
                                                                Get.back(),
                                                            child: const Txt(
                                                              text: 'OK',
                                                              color:
                                                                  Colors.white,
                                                              defalutsize: true,
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ));
                                          },
                                          child: const Txt(
                                            text: 'Want to know more',
                                            fsize: 9,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (productcount[index] == 0) {
                                            Fluttertoast.showToast(
                                              msg: 'Please Add Quantity',
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                            );
                                          } else {
                                            hcon.addtocart(
                                                productcount[index],
                                                emptycount[index],
                                                icon.productlist[index]
                                                    ['price'],
                                                icon.productlist[index]
                                                    ['product_id']);
                                          }
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(999),
                                              border: Border.all(
                                                  color: Get.theme.primaryColor,
                                                  width: .8)),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.sp,
                                                vertical: 1.sp),
                                            child: const Txt(
                                              text: 'Add',
                                              fsize: 12,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        })),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 2.sp,
              left: 0,
              right: 0,
              child: icon.totalitems.value != '0'
                  ? Padding(
                      padding: EdgeInsets.all(3.0.sp),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.sp),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                    )
                  : SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
