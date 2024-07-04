import 'package:smart_diary/GsheetService/gsheet_setup.dart';


insertDataIntoSheet({id, heading, details, color, time}) async{
  List<Map<String, dynamic>> NotesDataList = await [ 
    {
      'id': id.toString(),
      'heading': heading.toString(),
      'details': details.toString(),
      'color': color.toString(),
      'time': time.toString(),
    },
  ];

  await GsheetCrudUserDetails!.values.map.appendRows(NotesDataList);
  print('Data stored');
}

List datafromSheet = [];
readDataFromSheet() async {
  try {
    datafromSheet = (await GsheetCrudUserDetails!.values.map.allRows())!;
    print('Data fetched');
  } catch (e) {
    datafromSheet = [];
    print(e);
  }
}

updateDataFromSheet({IDFromNotes, heading, details, color, time}) async{
  await GsheetCrudUserDetails!.values.map.insertRowByKey('${IDFromNotes}', {
    'heading': heading.toString(),
    'details': details.toString(),
    'color': color.toString(),
    'time': time.toString(),  
  });
  print('Data updated');
}

deleteDataFromSheets({IDFromNotes}) async{
  final index = await GsheetCrudUserDetails!.values.rowIndexOf('${IDFromNotes}');
  await GsheetCrudUserDetails!.deleteRow(index);
  print('Data deleted');
}