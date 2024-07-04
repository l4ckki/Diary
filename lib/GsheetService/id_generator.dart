import 'dart:math';

var _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz0123456789';

Random _rnd = Random();
String? ID;

UniqueGenerator()async{
  Random random = await new Random();
  int randomNum = await random.nextInt(100000000);

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt((_rnd.nextInt(_chars.length)))));
  ID = await '${randomNum}${getRandomString(10)}';
}