import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonText extends StatelessWidget {
  final size;
  final label;
  final Overflow;
  final maxline;
  final colorT;
  final fontWeightT;

  const CommonText({super.key, this.size, this.label, this.Overflow, this.maxline, this.colorT, this.fontWeightT});

  @override
  Widget build(BuildContext context) {
    return Text(label, style: GoogleFonts.oxygen(color: colorT, fontSize: size, fontWeight: fontWeightT), 
    maxLines: maxline, overflow: Overflow);
  }
}