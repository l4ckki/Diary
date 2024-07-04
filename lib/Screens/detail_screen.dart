import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_diary/CommonService/common_alert.dart';
import 'package:smart_diary/CommonService/common_loader.dart';
import 'package:smart_diary/GsheetService/gsheet_crud.dart';
import 'package:smart_diary/Screens/home_screen.dart';
import 'package:get/get.dart';
import 'package:smart_diary/GsheetService/id_generator.dart';

class DetailScreen extends StatefulWidget {
  final from;
  final NotesArray;

  const DetailScreen({super.key, required this.from, required this.NotesArray});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  TextEditingController heading  = TextEditingController();
  TextEditingController details = TextEditingController();
  List colorsArray = ['0xff2196f3', '0x7FFF00f3', '0xBD33A4f3', '0xbd1234f3'];
  int colorIndex = 0;

  @override
  void initState() {
    AutoFillData();
    super.initState();
  }

  AutoFillData() async {
    if(widget.from == 'fab'){
      colorsArray[colorIndex] = '0xff2196f3';
    } else {
      heading.text = await widget.NotesArray['heading'];
      details.text = await widget.NotesArray['details'];
      colorsArray[colorIndex] = await widget.NotesArray['color'];
      setState(() {});
    }
  }
  
  CreateNewNotes() async {
    AlertLoader(color: Colors.white, context: context);
    await UniqueGenerator();
    await insertDataIntoSheet(
      id: ID, 
      heading: heading.text.toString(), 
      details: details.text.toString(), 
      color: colorsArray[colorIndex].toString(),
      time: '${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}');
    Get.back();
    CommonAlert(context: context, meesage: 'Данные сохранены');
  }

  UpdateNotes() async{
    AlertLoader(color: Colors.white, context: context);
    await updateDataFromSheet(
      IDFromNotes: widget.NotesArray['id'], 
      heading: heading.text.toString(), 
      details: details.text.toString(), 
      color: colorsArray[colorIndex].toString(),
      time: '${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}');
    Get.back();
    CommonAlert(context: context, meesage: 'Данные обновлены');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(int.parse(colorsArray[colorIndex])), 
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(1.5.h),
          width: 100.w,
          child: SingleChildScrollView(
            child: Column(
              children: [
                AppBarDetailScreen(), Heading(), Details(),
              ],)
          ),
        ),

      ),);
  }

  AppBarDetailScreen(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BackButton(
          color: Colors.white, 
          onPressed: () {
            Get.offAll(HomeScreen());
          },
        ),
        SizedBox(
          width: 50.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () async{
                  if(widget.from == 'fab'){
                    CreateNewNotes();
                  } else {
                    UpdateNotes();
                  }
                },
                child: Icon(Icons.save_rounded, color: Colors.white, size: 4.h),
              ),
              InkWell(
                onTap: () {
                  colorIndex++;
                  if (colorIndex == colorsArray.length - 1){
                    colorIndex = 0;
                  }
                  setState(() {
                    
                  });
                },
                child: Icon(Icons.color_lens, color: Colors.white, size: 4.h),
              ),
              InkWell(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: details.text));
                  CommonAlert(context: context, meesage: 'Запись скопирована');
                },
                child: Icon(Icons.copy_all_sharp, color: Colors.white, size: 4.h),
              ),
              InkWell(
                onTap: () async {
                  await deleteDataFromSheets(IDFromNotes: widget.NotesArray['id']);
                  CommonAlert(context: context, meesage: 'Запись удалена');
                  Get.to(HomeScreen());
                },
                child: Icon(Icons.delete, color: Colors.white, size: 4.h),
              ),
            ],
          ),
        ),
      ],);
  }
  Heading(){
    return SizedBox(
      width: 100.w, child: TextFormField(
        controller: heading, enableSuggestions: true, keyboardType: TextInputType.text, cursorColor: Colors.white, maxLines: 2,
        maxLength: 50,
        style: GoogleFonts.oxygen(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
          decoration: InputDecoration(
            hintText: 'Введите заголовок заметки', 
            hintStyle: GoogleFonts.oxygen(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
            contentPadding: EdgeInsets.all(2.h),
            counterText: '',
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 0.5),
              borderRadius: BorderRadius.circular(6),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 0.5),
              borderRadius: BorderRadius.circular(6),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 0.5),
              borderRadius: BorderRadius.circular(6),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 0.5),
              borderRadius: BorderRadius.circular(6),
            ),
            fillColor: Colors.transparent,
            filled: true,
          ),
        ),
      );
  }
  Details(){
    return SizedBox(
      width: 100.w, child: TextFormField(
        controller: details, enableSuggestions: true, keyboardType: TextInputType.text, cursorColor: Colors.white, maxLines: 2000,
        maxLength: 50,
        style: GoogleFonts.oxygen(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
          decoration: InputDecoration(
            hintText: 'Введите текст заметки', 
            hintStyle: GoogleFonts.oxygen(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
            contentPadding: EdgeInsets.all(2.h),
            counterText: '',
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 0.5),
              borderRadius: BorderRadius.circular(6),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 0.5),
              borderRadius: BorderRadius.circular(6),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 0.5),
              borderRadius: BorderRadius.circular(6),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 0.5),
              borderRadius: BorderRadius.circular(6),
            ),
            fillColor: Colors.transparent,
            filled: true,
          ),
        ),
      );  
  }
}