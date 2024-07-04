import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_diary/CommonService/common_text.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_diary/Screens/detail_screen.dart';

var CommonFab = FloatingActionButton.extended(
  icon: Icon(Icons.add_circle),
  backgroundColor: Color.fromARGB(255, 95, 159, 255),
  onPressed: (){
    Get.to(DetailScreen(from: 'fab', NotesArray: null,));
  }, 
  label: CommonText(
    label: 'Новая запись',
    colorT: Colors.white,
    fontWeightT: FontWeight.w600,
    size: 11.sp,
  ));

var CenterLoc = FloatingActionButtonLocation.centerFloat;