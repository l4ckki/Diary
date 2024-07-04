import 'package:sizer/sizer.dart';
import 'package:smart_diary/CommonService/common_text.dart';
import 'package:flutter/material.dart';

CommonAlert({meesage, context}){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: Duration(seconds: 2),
    content: CommonText(label: '$meesage',
    colorT: Colors.white, 
    size: 11.sp, 
    fontWeightT: FontWeight.w700,
  )));
}