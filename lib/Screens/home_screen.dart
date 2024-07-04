import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_diary/CommonService/common_alert.dart';
import 'package:smart_diary/CommonService/common_loader.dart';
import 'package:smart_diary/CommonService/fab.dart';
import 'package:smart_diary/CommonService/common_text.dart';
import 'package:get/get.dart';
import 'package:smart_diary/GsheetService/gsheet_crud.dart';
import 'package:smart_diary/Screens/detail_screen.dart';

class HomeScreen extends StatefulWidget {
	const HomeScreen({super.key});

	@override
	State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

	@override
  void initState() {
    fetchData();
    super.initState();
  }

	fetchData() async {
		
		await Future.delayed(Duration(seconds: 1), () {
			AlertLoader(color: Colors.black, context: context);
		});
		await readDataFromSheet();
		Get.back();
		setState((){});
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold( 
			floatingActionButton: CommonFab,
			floatingActionButtonLocation: CenterLoc,
			body: SafeArea(child: Container(
				height: 100.h, 
				width: 100.w,
				padding: EdgeInsets.all(2.h),
				child: SingleChildScrollView(
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
							Row(
								mainAxisAlignment: MainAxisAlignment.spaceBetween,
								children: [
									CommonText(
										label: 'Мои записи',
										colorT: Colors.black,
										fontWeightT: FontWeight.w900,
										size: 16.sp,
									),
									InkWell(
										onTap: () {
											fetchData();
										},
										child: 
											Icon(Icons.refresh_rounded, color: Colors.black, size: 4.h),
									)
								],
							),
							datafromSheet.isEmpty? NoNotesFound():
							Wrap(
								children: [
									for(var index = 0; index < datafromSheet.length; index++)
									GestureDetector(
										onTap: () {
											Get.to(DetailScreen(from: 'notes', NotesArray: datafromSheet[index],));
										},
									child: Container(
										height: 32.h,
										width:  43.w,
										margin: EdgeInsets.only(top: 2.h, right: 2.w),
										padding: EdgeInsets.all(2.h), 
										decoration: BoxDecoration(
											borderRadius: BorderRadius.circular(16), 
											boxShadow: [ 
												BoxShadow(
																	blurRadius: 1, 
																	color: Colors.black12, 
																	spreadRadius: 2, 
																	offset: Offset(0, 2))
																 ],
												color: Color(int.parse(datafromSheet[index]['color']))), 
												child: Column( children: [SizedBox(height: 6.2.h, 
																				child: CommonText(
																													label: '${datafromSheet[index]['heading']}',
																													colorT: Colors.white,
																													fontWeightT: FontWeight.w900,
																													size: 16.sp,
																													),
																				),
																				Expanded(child: Container(
																									margin: EdgeInsets.symmetric(vertical: 1.h),
																									child: CommonText(
																													label: '${datafromSheet[index]['details']}',
																													colorT: Colors.white,
																													fontWeightT: FontWeight.w600,
																													size: 12.sp,
																													),
																									), 
																								),
																								Row(
																									mainAxisAlignment: MainAxisAlignment.spaceBetween,
																									children: [
																													SizedBox(
																													width: 20.w, 
																													child: CommonText(
																													label: 'Изменено ${'${datafromSheet[index]['time']}'}',
																													colorT: Colors.white,
																													fontWeightT: FontWeight.w600,
																													size: 7.5.sp,
																													),
																													),
																													InkWell(
																													onTap: () async {
																														AlertLoader(color: Colors.black, context: context);
																														await deleteDataFromSheets(IDFromNotes: datafromSheet[index]['id']);
																														await readDataFromSheet();
																														Get.back();
																														setState((){});
																														CommonAlert(context: context, meesage: 'Данные удалены');
																													},
																													child: 
																														Icon(Icons.delete, color: Colors.white, size: 4.h),
																													)
																												],
																								)
																				]
																			),
												
															 
										),
									),
								],
							),
						],
					),
				),
			)),
		);

	}
	NoNotesFound(){
		return Center(
			heightFactor: 3.h,
		  child: 
		    CommonText(
		    	label: 'Нет записей',
		    	colorT: Colors.black,
		    	fontWeightT: FontWeight.w600,
		    	size: 15.sp,
		    ),
		);
	}
}