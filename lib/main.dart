import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:smart_diary/GsheetService/gsheet_setup.dart';
import 'package:smart_diary/Screens/home_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GsheetInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (BuildContext context, Orientation orientation, DeviceType deviceType,){
      return GetMaterialApp(
        home: HomeScreen(), 
        debugShowCheckedModeBanner: false,
      );
    },);
  }
}

