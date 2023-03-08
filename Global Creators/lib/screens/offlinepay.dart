import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_creater/controller/init.dart';
import 'package:global_creater/widgets/appbar.dart';
import 'package:global_creater/widgets/text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class OfflinePayment extends StatelessWidget {
  OfflinePayment({Key? key}) : super(key: key);
  final InitCon icon = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          icon: GetBuilder<InitCon>(builder: (value) {
            return Icon(value.payimage != null ? Icons.check : Icons.camera);
          }),
          backgroundColor: Get.theme.primaryColor,
          onPressed: () {
            Get.dialog(Center(
              child: Material(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 130,
                  width: 220,
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {
                          icon.getpayimage(ImageSource.camera);
                        },
                        title: const Txt(
                          text: 'Camera',
                          defalutsize: true,
                          color: Colors.black,
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        onTap: () {
                          icon.getpayimage(ImageSource.gallery);
                        },
                        title: const Txt(
                          text: 'Gallery',
                          defalutsize: true,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
          },
          label: GetBuilder<InitCon>(builder: (value) {
            return Txt(
              text: value.payimage != null ? 'Upload' : 'Take picture',
              dsize: 16,
              color: Colors.white,
              defalutsize: true,
            );
          })),
      appBar: BaseAppBar(
        title: 'Offline Payment',
        backicon: true,
        carticon: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const Txt(
              text:
                  'Note: press (Take picture) to upload your payment cheque or bill.',
              color: Colors.black,
              iscenter: true,
              fsize: 12,
            ),
            SizedBox(
              height: 29.sp,
            ),
            GetBuilder<InitCon>(builder: (value) {
              return value.payimage != null
                  ? Container(
                      height: 200.sp,
                      width: 200.sp,
                      child: Image.file(value.payimage))
                  : SizedBox();
            }),
          ],
        ),
      ),
    );
  }
}
