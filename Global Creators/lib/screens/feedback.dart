import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_creater/controller/init.dart';
import 'package:global_creater/widgets/appbar.dart';
import 'package:global_creater/widgets/text.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FeedBackView extends StatelessWidget {
  FeedBackView({Key? key}) : super(key: key);
  final InitCon icon = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        backicon: true,
        title: 'Feedback',
        carticon: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0.sp),
        child: ListView(
          children: [
            Card(
              elevation: 3,
              child: Padding(
                padding: EdgeInsets.all(8.0.sp),
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Txt(
                          text: 'Rate your experise with our service',
                          fsize: 12,
                          color: Colors.black87,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RatingBar.builder(
                          initialRating: 3,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0.sp),
                          itemBuilder: (context, _) => Container(
                            height: 20.sp,
                            width: 20.sp,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Get.theme.primaryColor.withOpacity(0.5)),
                            child: Center(
                              child: Icon(
                                Icons.star_rounded,
                                color: Get.theme.primaryColor,
                                size: 15.sp,
                              ),
                            ),
                          ),
                          onRatingUpdate: (rating) {
                            icon.rating.value = rating.toString();
                            print(rating);
                          },
                        ),
                        Obx(() => Txt(
                            text: icon.rating.value.toString() + ' rating',
                            fsize: 10,
                            color: Colors.black87))
                      ],
                    )
                  ],
                ),
              ),
            ),

              Card(
              elevation: 3,
              child: Padding(
                padding: EdgeInsets.all(8.0.sp),
                child: Column(
                  children: [
                    Row(
                      children: [
                         SizedBox(
                           width: MediaQuery.of(context).size.width * 0.80,
                           child: const Txt(
                            text: 'Rate your Experience with our Product Services',
                            fsize: 12,
                            color: Colors.black87,
                            ),
                         ),
                      ],
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RatingBar.builder(
                          initialRating: 3,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0.sp),
                          itemBuilder: (context, _) => Container(
                            height: 20.sp,
                            width: 20.sp,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Get.theme.primaryColor.withOpacity(0.5)),
                            child: Center(
                              child: Icon(
                                Icons.star_rounded,
                                color: Get.theme.primaryColor,
                                size: 15.sp,
                              ),
                            ),
                          ),
                          onRatingUpdate: (rating) {
                            icon.productservicerating.value = rating.toString();
                            print(rating);
                          },
                        ),
                        Obx(() => Txt(
                            text: icon.productservicerating.value.toString() + ' rating',
                            fsize: 10,
                            color: Colors.black87))
                      ],
                    )
                  ],
                ),
              ),
            ),

             Card(
              elevation: 3,
              child: Padding(
                padding: EdgeInsets.all(8.0.sp),
                child: Column(
                  children: [
                    Row(
                      children: [
                         SizedBox(
                           width: MediaQuery.of(context).size.width * 0.80,
                           child: const Txt(
                            text: 'Rate your Experience with our Delivery Person',
                            fsize: 12,
                            color: Colors.black87,
                            ),
                         ),
                      ],
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RatingBar.builder(
                          initialRating: 3,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0.sp),
                          itemBuilder: (context, _) => Container(
                            height: 20.sp,
                            width: 20.sp,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Get.theme.primaryColor.withOpacity(0.5)),
                            child: Center(
                              child: Icon(
                                Icons.star_rounded,
                                color: Get.theme.primaryColor,
                                size: 15.sp,
                              ),
                            ),
                          ),
                          onRatingUpdate: (rating) {
                            icon.deliveryservicerating.value = rating.toString();
                            print(rating);
                          },
                        ),
                        Obx(() => Txt(
                            text: icon.deliveryservicerating.value.toString() + ' rating',
                            fsize: 10,
                            color: Colors.black87))
                      ],
                    )
                  ],
                ),
              ),
            ),

            SizedBox(
              height: 10.sp,
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(8.0.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Txt(
                      text: 'Anything that can be improve',
                      fsize: 12,
                      color: Colors.black87,
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    Container(
                        padding: EdgeInsets.all(5.sp),
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          border: Border.all(
                              color: Get.theme.primaryColor, width: 1),
                          borderRadius: BorderRadius.circular(7.sp),
                        ),
                        child: TextField(
                          maxLines: 3,
                          controller: icon.feedcon,
                          decoration: InputDecoration(
                              hintText: "Your feedback (optional)",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none),
                        )),
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
                              icon.feedback();
                            },
                            child: const Txt(
                              text: '  Submit  ',
                              color: Colors.white,
                              defalutsize: true,
                            )),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
