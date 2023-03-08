import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class Txt extends StatelessWidget {
  final String text;
  final double fsize;
  final FontWeight weight;
  final int lines;
  final Color color;
  final bool defalutsize;
  final double dsize;
  final bool iscenter;
  const Txt(
      {Key? key,
      this.text = '',
      this.fsize = 16,
      this.iscenter = false,
      this.lines = 1000,
      this.dsize = 15,
      this.color = const Color(0xff104cf5),
      this.defalutsize = false,
      this.weight = FontWeight.normal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: lines,
      overflow: TextOverflow.ellipsis,
      textAlign: iscenter ? TextAlign.center : TextAlign.start,
      style: GoogleFonts.roboto(
          textStyle: TextStyle(
              fontSize: defalutsize ? dsize : fsize.sp,
              fontWeight: weight,
              color: color,
              height: 1.2,
              letterSpacing: .7)),
    );
  }
}
