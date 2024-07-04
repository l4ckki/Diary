import 'package:gsheets/gsheets.dart';

var sheetId = '1YXr8GWj8gu9nMHKG9xipQTYOO3OqQi1mRYt2zVdSCro';
var credentials = r'''{
  "type": "service_account",
  "project_id": "my-notes-428322",
  "private_key_id": "f16e828e164750200c4033baa6a77b10fd0e5c32",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC0/1GH596MIvWD\ndJYy2bk5zqxgqWsoJTAlc1M/2Iz2o9TPBSN0eNiQaxCblf8CCIyInU4cCpxlEtaS\nH+X5cvxwStHO5W6mzaYOqzUzaTOObEWuIDhxf6mbuN5GVyZZnq5g1rZUhEKsubt7\nCw3JWCI3iUTVNoGYH3jtJmE1qMb3Ysyedk9yiWZPzW0lcXLi5rlcJLRe/R2P0Byw\n/Q7uBnoSOzsNWdPvSs9DFKAaY/vVHjrAopl0S2d3DAM/Jsn6w5c6Mn67uWYenU88\nARtQ71TAprKmnb37h1CF+u2bcWTM+DbjcmEBsAXQFIl0EVvlNxo5HuYiLdLal5IR\n5ZuNCIR3AgMBAAECggEALhH9BTxiW8Y8OvEumBPuP0YZf2MwSOAqYKX5rzsmKlNq\nRCWZMDjgWuY9rHSiG7jkWJO9wYp744hHgJtI9NUtZ0HMJL8miqO23G381TC2dE6f\n7+H4q/8kQ2Rrg3kEZHRtC24rq9ichg2iqH+YS0M5NmykziaZFwkPxUFrJfbnailX\nZeb9a0zb7QKh6kGCWKZr/3krsZjGy/CMqf02BXa9k9sq6NxfZ0TC7NicMqFI+IrC\nJea8pSnoVmrHmOQSHqWTHUw9xRMSfJR6KyswOBsNADvtzemF0GzZ+F2u3ekZDGWt\nIiq5gVJJ0XWwNFtzNXukx6sjhhwU4t1L5qSuSM0WVQKBgQD7e4BRl02Zh/uF0/OP\nAKbC3jaUDoYY51f/EtysiPb4L6YqrWGUrxRk3khuLCrzkTNkZ6t4UKh9bPfIgkRb\n1mv63ne+QGCDZVX3PVtiKbkKDG8dIvi8oy3m0OpOxiI7iOAZmbkl+in/t748rzj1\nNpNXk65zY3TMsVpxX/4OTGzBowKBgQC4P6z2DF5JkEvFIN43s/v0CcF7LQfZ1qYR\nl937BtxXjvLZW5lu7gPYr634QVyiXkVqiXoWNNqq3myvf3NUinoRJVwQXMOuDYH0\njFWruHn1uhaSztwQgBvt7ZNSWHuNFhr9ysH9nsurySRoCebHlHvuu0NTt/QRtcUl\nXHRuqtpnHQKBgBPL4gsKNRKb8MHVMHwWWgpHAdbf2dCGDZhHvNVcJszcu2Dqqx7Q\nNXPHR75cfbkUug3yVz4uY0UUWeEP2B++nltuPdDdMnvFc2H2E4aDsExJNEn/4cK/\nubJMydUPpcw39yQsxLVnnvzBUxll1b7/39NqDbaJor0mTO9V1iL8AyevAoGALJRz\nlAEAG0qHmsXOHqo0zyJBJz2JBcMy4VTeh+tsCt9ykPbh0/5Q/e/b5xJhiIPIxfNH\nj/Hv6qHwqDHtRMpQqK9ibC8VxZpNFE+UNv1mvPbumUzl4DQvDc2K9MSl+Egd9cRG\nVchDPWhon6etqCKcLfIvYyVCL7rMXbLWFSTPvV0CgYEAjgUIMGTik00nWR3R7BR3\n4I+tsDnyfRbh6Xt9jrGqDGeAiqd/Hq4BsWlj6P5Ki5iwmGroQo88gl1gPjjbLWFY\nhKj+fcpPIISbOp+Hx6jAt3QPCsywtmZNLwm0Mz1a1yrdrRi7PN/69C2p+ZNWwvsr\nqKVQ7oNgEzytussHa+ZZ7wo=\n-----END PRIVATE KEY-----\n",
  "client_email": "my-notes@my-notes-428322.iam.gserviceaccount.com",
  "client_id": "117751969616659765229",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/my-notes%40my-notes-428322.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
''';

final gsheetinit = GSheets(credentials);

var GsheetController;

Worksheet? GsheetCrudUserDetails;

GsheetInit() async {
  GsheetController = await gsheetinit.spreadsheet(sheetId);
  GsheetCrudUserDetails = await GsheetController.worksheetByTitle('My Notes');
  GsheetCrudUserDetails ??= await GsheetController.addWorksheet('My Notes');
}