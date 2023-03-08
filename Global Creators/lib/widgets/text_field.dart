import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class CTextField extends StatelessWidget {
  final String hint, prefix, label;
  final int max;
  final bool suffixicon;
  final bool enabled;
  final TextInputType keyboard;
  final bool isprefix;
  final bool ispreicon;
  final IconData preicon;
  final bool ispass;
  final bool isvisible;
  final bool istheme;
  final double padd;
  final bool obs;
  final bool islabel;

  final VoidCallback passontap;
  final ValueChanged onchage;
  final TextEditingController controller;
  static _defaultFunction() {}
  static _onchageFunction(o) {}
  const CTextField(
      {Key? key,
      this.hint = '',
      this.prefix = '',
      this.padd = 12,
      this.obs = false,
      this.enabled = true,
      this.suffixicon = false,
      this.istheme = false,
      this.label = '',
      this.ispass = false,
      this.isvisible = false,
      this.passontap = _defaultFunction,
      this.onchage = _onchageFunction,
      this.preicon = Icons.person,
      this.ispreicon = false,
      this.isprefix = false,
      this.islabel = false,
      this.max = 500,
      required this.controller,
      this.keyboard = TextInputType.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obs ? true : false,
      focusNode: enabled ? FocusNode() : AlwaysDisabledFocusNode(),
      controller: controller,
      keyboardType: keyboard,
      inputFormatters: <TextInputFormatter>[
        if (max == 10 || max == 6 || max == 3)
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      maxLength: max,
      cursorColor: Get.theme.primaryColor,
      cursorWidth: 2,
      onChanged: _onchageFunction,
      style: GoogleFonts.openSans(
          textStyle: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
              letterSpacing: .8)),
      decoration: InputDecoration(
        suffixIcon: ispass
            ? InkWell(
                onTap: passontap,
                child: Icon(
                  !isvisible ? Icons.visibility_off : Icons.visibility,
                  size: 16.sp,
                ))
            : null,
        counterText: '',
        label: Text(
          hint,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontSize: 12.sp, color: Colors.grey, letterSpacing: .8)),
        ),
        fillColor: Colors.white,
        filled: true,
        floatingLabelBehavior:
            islabel ? FloatingLabelBehavior.always : FloatingLabelBehavior.auto,
        labelStyle: GoogleFonts.poppins(
            textStyle: TextStyle(
                fontSize: 12.sp, color: Colors.black, letterSpacing: .8)),
        hintStyle: GoogleFonts.poppins(
            textStyle: TextStyle(
                fontSize: 12.sp, color: Colors.grey, letterSpacing: .8)),
        hintText: label,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
              color: istheme ? Get.theme.primaryColor : Colors.black,
              width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
        contentPadding: EdgeInsets.all(padd.sp),
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
