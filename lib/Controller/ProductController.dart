import 'dart:io';


import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shoppingcart/RequestResponseModel/ListRequest.dart';
import 'package:shoppingcart/RequestResponseModel/ListResponse.dart';
import 'package:shoppingcart/http/request.dart';

import '../http/url.dart';


class ProductController extends GetxController {
  var errorMsg;
  late Function refreshPage;
  var productList = <Data>[].obs;


  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
  @override
  void onReady(){

  }
  GetProductList() async {
    productList.clear();

    ListRequest requestModel = new ListRequest(
      page: 1,
      perPage: 5//userid.value.toString(),
    );

    final results = await new Request().requestPostWithToken(
        url: list_api,
        parameters: json.encode(requestModel),
        // token: token.value,
        context: Get.context);
    Get.back();
    if (results != null) {
      try {
        ListResponse responseModel = ListResponse.fromJson(results);
        log("response result " + results.toString());

        if (responseModel.status == true) {
          if(responseModel.data!=null) {
              productList.addAll(responseModel.data!);

          }
          if (productList.length > 0) {
            print("fsdsfjskdfjksdjf " + productList[0].title!);
          }
          refreshPage.call();
        } else if (responseModel.status == false) {
          ScaffoldMessenger.of(Get.context!).showSnackBar(
            const SnackBar(
              content: Text('something went wrong'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(
            content: Text('something went wrong please try after some time'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          content: Text('Something Went Wrong please try again later'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
