import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

AlertLoader({context, color}){
  return showDialog(context: context, barrierDismissible: false, barrierColor: Colors.transparent, builder: (BuildContext context){
    return AlertDialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: Padding(
        padding: EdgeInsets.symmetric(horizontal: 27.w),
        child: CircularProgressIndicator(color: color, strokeWidth: 2),
      ),
    );
  },);

  
}