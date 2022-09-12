// import 'dart:convert';
// import 'dart:developer';
//
//
//
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:custom_progress_dialog/custom_progress_dialog.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:pworld/Utils/MyUtilClass.dart';
//
//
// class Request {
//
//    bool progressDialog1 = false;
//
//   ProgressDialog _progressDialog = ProgressDialog();
//
//   Future<Map?> requestPost({required String url, required String parameters, context}) async {
//     try {
//       if (progressDialog1 == false) {
//         progressDialog1 = true;
//         _progressDialog.showProgressDialog(context,
//             textToBeDisplayed: 'Please wait...');
//       }
//
//       print(url);
//       print(parameters);
//
//
//       bool flagNet = await new MyUtilClass().isInternetAvailable();
//       if (flagNet) {
//         Uri uri = Uri.parse(url);
//
//         final results = await http.post(uri,
//             body: parameters, headers: {"Content-Type": "application/json"});
//
//         // log("Resultss "+json.decode(results.toString()));
//         // _progressDialog.dismissProgressDialog(context);
//         // progressDialog = false;
//
//         if (results.statusCode == 200) {
//           final jsonObject = json.decode(results.body);
//           // log(json.decode(results.body));
//           // print("insuccess");
//
//           progressDialog1 = false;
//           _progressDialog.dismissProgressDialog(context);
//
//           return jsonObject;
//         } else if (results.statusCode == 403) {
//           print("inelse of success");
//           progressDialog1 = false;
//           _progressDialog.dismissProgressDialog(context);
//           return null;
//         }
//       } else {
//         print("inelse of internet connection");
//         progressDialog1 = false;
//         _progressDialog.dismissProgressDialog(context);
//         return null;
//       }
//     }catch(Exception){
//       log(Exception.toString());
//     }
//
//   }
// }

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:shoppingcart/Utils/MyUtilClass.dart';

class Request {

  // bool progressDialog1 = false;

  // late ProgressDialog _progressDialog;

  Future<Map?> requestPost({String? url, String? parameters, context}) async {


    // if (isProgressDialogShowing == false) {
    //   isProgressDialogShowing = true;
    //   await _progressDialog.show();
    // }
    // print(url);
    // print(parameters);
    // debugPrint(parameters, wrapWidth: 1024);


    bool flagNet = await new MyUtilClass().isInternetAvailable();
    if (flagNet) {
      Uri uri = Uri.parse(url!);

      final results = await http.post(uri,
          body: parameters, headers: {"Content-Type": "application/json"});
      log("Resultss "+results.toString());
      log("statusCode login "+results.statusCode .toString());

      if (results.statusCode == 200) {
        final jsonObject = json.decode(results.body);
        print(jsonObject);
        return jsonObject;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
  Future<Map?> requestPostWithToken({String? url, String? parameters, context, String? token}) async {


    // if (isProgressDialogShowing == false) {
    //   isProgressDialogShowing = true;
    //   await _progressDialog.show();
    // }
    print(url);
    print(parameters);
    debugPrint(parameters, wrapWidth: 1024);
    print(token);
    bool flagNet = await new MyUtilClass().isInternetAvailable();
    if (flagNet) {
      Uri uri = Uri.parse(url!);

      final results = await http.post(uri,
          body: parameters, headers: {
          // 'Authorization': 'Bearer '+token,
          // 'Au': 'Bearer '+token,
          'Content-Type': 'application/json'
          });
      log("Resultss "+results.toString());
      log("Resultss "+results.statusCode.toString());

      if (results.statusCode == 200) {
        final jsonObject = json.decode(results.body);
        print(jsonObject);
        return jsonObject;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
  Future<Map?> requestGetWithToken({String? url,  context, token}) async {

    print(url);
    print(token);
    bool flagNet = await new MyUtilClass().isInternetAvailable();
    if (flagNet) {
      Uri uri = Uri.parse(url!);

      final results = await http.get(uri,
         headers: {
         /* 'Authorization': 'Bearer '+token,
          'Au': 'Bearer '+token,*/
          'Content-Type': 'application/json'
          });
      log("Resultss "+results.toString());

      if (results.statusCode == 200) {
        final jsonObject = json.decode(results.body);
        print(jsonObject);
        return jsonObject;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}