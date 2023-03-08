// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:global_creater/controller/home.dart';
import 'package:global_creater/controller/init.dart';
import 'package:global_creater/screens/dashboard/products.dart';
import 'package:global_creater/widgets/text.dart';
import 'package:global_creater/widgets/category_filter.dart';
import 'package:sizer/sizer.dart';

import '../../api_endpoints.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final InitCon icon = Get.find();

  oncategoryclicked(dynamic category_id, String category_name) {
    icon.setcategory(category_id);
    icon.setcategoryname(category_name);
    Get.to(() => ProductsView());
  }

  Category makemodelfromobject(dynamic categorydata) {
    return Category(
      categorydata['category_name'],
      categorydata['description'],
      // categorydata['image'],
      // categorydata['bg']
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
            children: [
            Padding(
              padding: EdgeInsets.all(8.sp),
              child: Row(
              children: [
                  Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(right: 8.sp),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10.sp),
                        bottomLeft: Radius.circular(10.sp),
                      ),
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
                      padding: EdgeInsets.all(10.sp),
                      child: Column(
                        children: [
                          const Txt(
                            text: 'Total Referal Points',
                            iscenter: true,
                            fsize: 9,
                            weight: FontWeight.w500,
                          ),
                          SizedBox(
                            height: 5.sp,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 20.sp,
                                width: 20.sp,
                                child: Image.asset('assets/reward-card.png'),
                              ),
                              SizedBox(
                                width: 10.sp,
                              ),
                              Obx(() => Txt(
                                    text: icon.totalpoints.value,
                                    weight: FontWeight.bold,
                                    fsize: 15,
                                  )),
                              SizedBox(
                                width: 5.sp,
                              ),
                               SizedBox(
                                height: 20.sp,
                                width: 20.sp,
                                child: Image.asset('assets/token.png'),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(right: 8.sp),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10.sp),
                        bottomLeft: Radius.circular(10.sp),
                      ),
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
                      padding: EdgeInsets.all(10.sp),
                      child: Column(
                        children: [
                          const Txt(
                            text: 'Used Referal Points',
                            iscenter: true,
                            fsize: 9,
                            weight: FontWeight.w500,
                          ),
                          SizedBox(
                            height: 5.sp,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 20.sp,
                                width: 20.sp,
                                child: Image.asset('assets/reward-card.png'),
                              ),
                              SizedBox(
                                width: 10.sp,
                              ),
                              Obx(() => Txt(
                                    text: icon.totalpoints.value,
                                    weight: FontWeight.bold,
                                    fsize: 15,
                                  )),
                              SizedBox(
                                width: 5.sp,
                              ),
                               SizedBox(
                                height: 20.sp,
                                width: 20.sp,
                                child: Image.asset('assets/token.png'),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(right: 8.sp),
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
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10.sp),
                      child: Column(
                        children: [
                          const Txt(
                            text: 'Balance Referal Points',
                            iscenter: true,
                            fsize: 9,
                            weight: FontWeight.w500,
                          ),
                          SizedBox(
                            height: 5.sp,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 20.sp,
                                width: 20.sp,
                                child: Image.asset('assets/hand-gesture.png'),
                              ),
                              SizedBox(
                                width: 10.sp,
                              ),
                              Obx(() => Txt(
                                    text: icon.usedpoints.value,
                                    weight: FontWeight.bold,
                                    fsize: 15,
                                  )),
                              SizedBox(
                                width: 5.sp,
                              ),
                              Container(
                                height: 20.sp,
                                width: 20.sp,
                                child: Image.asset('assets/token.png'),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                ),
              ],
          ),
            ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
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
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Txt(
                      text: 'Cans In Hand',
                      fsize: 12,
                      weight: FontWeight.w500,
                    ),
                    Obx(
                      () => Txt(
                        text: icon.availablecan.value,
                        fsize: 12,
                        weight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Obx(() => icon.bannerlist.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    height: 20.h,
                    child: CarouselSlider(
                      options: CarouselOptions(autoPlay: true, height: 20.h),
                      items: icon.bannerlist.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                                width: MediaQuery.of(context).size.width,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
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
                                          offset: const Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: CachedNetworkImage(
                                        imageUrl: API().imgbaseurl +
                                            i['banner_image'],
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
                                ));
                          },
                        );
                      }).toList(),
                    ),
                  ),
                )
              : const SizedBox()),
              Padding(
                padding: EdgeInsets.fromLTRB(20.sp, 20.sp, 10.sp, 0.sp),
                child: Txt(
                  text: 'Select a Category',
                  fsize: 9.sp,
                ),
              ),
              Divider(indent: 20.sp, endIndent: 20.sp),
              Obx(() => icon.categorylist.isNotEmpty
              ? ListView.builder(
              itemCount: icon.categorylist.length,
              padding: EdgeInsets.all(10.sp),
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return 
                InkWell(
                  onTap: () => oncategoryclicked(icon.categorylist[index]['category_id'], 
                  icon.categorylist[index]['category_name']),
                  child: CategoryCard(category: makemodelfromobject(icon.categorylist[index])),
                );
              }
            )
            : const SizedBox()),
          ],),
    );
  }
}

class CategoryCard extends StatelessWidget {

  final Category category;

  const CategoryCard
  ({Key? key, required this.category}) 
  : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10.0),
        decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10.sp),
          bottomLeft: Radius.circular(10.sp),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and description here
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.sp, vertical: 1.sp),
                        child: Txt(
                            text: category.desc,
                            color: Colors.black,
                            fsize: 8,
                          ),
                      ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.sp, vertical: 1.sp),
                      child: Txt(
                          text: category.name,
                          color: Colors.black,
                          fsize: 12,
                          weight: FontWeight.bold,
                        ),
                    ),
              ],),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: 
            // Image here 
            SizedBox(
              width: 80,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.sp)),
                child: Image.asset(
                  'assets/multi_can.png',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Category {

  final name;
  final desc;

  Category(this.name, this.desc);

  // final image;
  // final bg;

  // Category(this.name, this.desc, this.image, this.bg);
}