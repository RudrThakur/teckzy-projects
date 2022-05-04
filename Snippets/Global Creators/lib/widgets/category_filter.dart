import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:global_creater/controller/init.dart';

import 'text.dart';
import 'package:sizer/sizer.dart';

class CategoryFilter extends StatefulWidget implements PreferredSizeWidget {

  const CategoryFilter(
      {Key? key,
      })
      : super(key: key);

  @override
  State<CategoryFilter> createState() => _CategoryFilterState();

  @override
  Size get preferredSize => throw UnimplementedError();
}

class _CategoryFilterState extends State<CategoryFilter> {
  final InitCon icon = Get.find();

  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  String selectedcategory = '';

  @override
  void initState() {
    super.initState();
  }

  oncategorychanged(category) {
    setState(() {
        selectedcategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
        height: 100,
        child:  Obx(() => ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: icon.categorylist.length,
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: 
                      icon.getcategory() == icon.categorylist[index]['category_id']  ?
                      Colors.greenAccent : Colors.white70,
                      borderRadius: BorderRadius.circular(2.sp),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 6,
                          offset:
                              const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: InkWell(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Txt(
                          text: icon.categorylist[index]['category_name'],
                          fsize: 12,
                          weight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      onTap: () {
                        oncategorychanged(icon.categorylist[index]['category_id']);
                        icon.setcategory(icon.categorylist[index]['category_id']);
                        icon.getproducts();
                      },
                    ),
                  ),
                );
              },
            ),
        ),
    );
  }
}