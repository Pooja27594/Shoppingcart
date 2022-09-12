import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:intl/intl.dart';


class MyUtilClass {
  List<int> convertBase64ToImage(String _base64) {
    Uint8List bytes = base64.decode(_base64);
    return bytes;
  }

  String getCurrentDate() {
    DateTime now = new DateTime.now();

    String day = now.day.toString();
    String month = now.month.toString();
    String year = now.year.toString();

    if (day.length == 1) {
      day = "0" + day;
    }
    if (month.length == 1) {
      month = "0" + month;
    }
    String date = day + "/" + month + "/" + year;

    return date;
  }

  String getCurrentTime() {
    DateTime now = new DateTime.now();

    var formatter = new DateFormat('hh:mm a');
    String time = formatter.format(now);

    //String time = now.hour.toString() + ":" + now.minute.toString();
    print(time);
    return time;
  }

  String getCurrentTimeWithSeconds() {
    DateTime now = new DateTime.now();

    var formatter = new DateFormat('hh:mm:ss a');
    String time = formatter.format(now);

    //String time = now.hour.toString() + ":" + now.minute.toString();
    print(time);
    return time;
  }



  Future<bool> isInternetAvailable() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
        print('connected');
        return true;

    } on SocketException catch (_) {
      print('not connected');
      return false;
    }
  }
  String checkNull(String value) {
    if (value==null) {
      return "";
    } else {
      return value;
    }
  }

}

String capitalizeWord(String value) {
  if (value.length > 0) {
    return value[0].toUpperCase() + value.substring(1);
  } else {
    return value;
  }
}


