import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_creater/controller/init.dart';
import 'package:global_creater/screens/addressbook/add_address.dart';
import 'package:global_creater/widgets/appbar.dart';
import 'package:global_creater/widgets/text.dart';
import 'package:sizer/sizer.dart';

class AddressList extends StatelessWidget {
  final bool isadd, isgetcart;
  AddressList({Key? key, this.isadd = false, this.isgetcart = false})
      : super(key: key);
  final InitCon icon = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Get.theme.primaryColor,
            icon: Icon(Icons.add_circle),
            onPressed: () {
              Get.to(() => AddAddressView());
            },
            label: const Txt(
              text: 'Add Address',
              color: Colors.white,
              defalutsize: true,
            )),
        appBar: BaseAppBar(
          backicon: true,
          title: 'Address Book',
          carticon: true,
        ),
        body: Obx(
          () => icon.addresslist.isEmpty
              ? Center(
                  child: Txt(
                    text: 'No Address Found',
                    fsize: 12,
                  ),
                )
              : ListView.builder(
                  itemCount: icon.addresslist.length,
                  itemBuilder: (context, index) {
                    final add = icon.addresslist[index];
                    return Padding(
                      padding: EdgeInsets.all(4.0.sp),
                      child: Stack(
                        children: [
                          Card(
                            child: ListTile(
                              onTap: () {
                                if (isadd) {
                                  icon.addid.value = add['address_id'];
                                  icon.addname.value = add['name'];
                                  icon.addmobile.value = add['mobile'];
                                  icon.adddoor.value = add['door_no'];
                                  icon.addlandmark.value = add['landmark'];
                                  icon.addcity.value = add['location'];
                                  icon.addpincode.value = add['pincode'];
                                  icon.addarea.value = add['city'];
                                  icon.addstreet.value = add['street'];
                                  Get.back();
                                  if (isgetcart) {
                                    icon.getcheckout();
                                  }
                                }
                              },
                              minLeadingWidth: 0,
                              leading: isadd
                                  ? Container(
                                      height: 30,
                                      width: 30,
                                      child: Center(
                                        child: Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: icon.addlandmark.value ==
                                                        add['landmark'] ||
                                                    icon.addlandmark.value ==
                                                        add['location']
                                                ? Colors.black87
                                                : Colors.transparent,
                                          ),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            width: 2,
                                            color: Colors.black87,
                                          )),
                                    )
                                  : SizedBox(),
                              title: Txt(
                                text: add['name'] +
                                    '-' +
                                    add['mobile'] +
                                    '\n' +
                                    add['door_no'] +
                                    ',' +
                                    add['street'] +
                                    ',' +
                                    add['city'] +
                                    ',' +
                                    '\n' +
                                    'Landmark:' +
                                    add['landmark'] +
                                    '\n' +
                                    add['pincode'],
                                fsize: 12,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          if (icon.addresslist.length != 1)
                            Positioned(
                                top: 10,
                                right: 10,
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
                                              padding: EdgeInsets.all(8.0.sp),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Txt(
                                                    text: 'Alert!',
                                                    color:
                                                        Get.theme.primaryColor,
                                                    fsize: 16,
                                                    weight: FontWeight.bold,
                                                  ),
                                                  SizedBox(
                                                    height: 10.sp,
                                                  ),
                                                  Txt(
                                                    text:
                                                        'Are you sure want to delete\n this address',
                                                    color: Colors.grey,
                                                    iscenter: true,
                                                    fsize: 10,
                                                  ),
                                                  SizedBox(
                                                    height: 10.sp,
                                                  ),
                                                  ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        shape:
                                                            const StadiumBorder(),
                                                        primary: Get
                                                            .theme.primaryColor,
                                                      ),
                                                      onPressed: () {
                                                        Get.back();
                                                        icon.deletaddress(
                                                            add['address_id']);
                                                      },
                                                      child: const Txt(
                                                        text: 'OK',
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
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    )))
                        ],
                      ),
                    );
                  }),
        ));
  }
}
