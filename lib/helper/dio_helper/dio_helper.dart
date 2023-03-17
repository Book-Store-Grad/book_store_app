import 'package:book_store/Const/API/Url.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


class DioHelper {
  static Dio? dio;

  static init() {
    debugPrint('dio helper run');
    dio = Dio(BaseOptions(
      validateStatus: (_) => true,
      baseUrl: ApiUrl.base,
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> postData({
    bool isJsonContentType = true,
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio!.options.headers = {
      'Authorization': 'Bearer $token',
    };
    print("This is data:$data");
    return dio!
        .post(
      url,
      data: data,
      queryParameters: query,
      options: Options(
          contentType: isJsonContentType
              ? Headers.jsonContentType
              : Headers.formUrlEncodedContentType,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          }),
    )
        .catchError((error) {
    //  print(error.toString());

      // Get.snackbar("Error", "",
      //     messageText: Text(
      //       "Please connect to server!",
      //       style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12.sp),
      //     ),
      //     icon: const Icon(
      //       Icons.error,
      //       color: Colors.red,
      //       size: 30,
      //     ),
      //     margin: EdgeInsets.symmetric(vertical: .1.sh, horizontal: .1.sw));
    });
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio!.options.headers = {
      'Authorization': 'Basic $token',
    };
    return await dio!
        .get(
      url,
      queryParameters: query,
      options: Options(
          contentType: Headers.jsonContentType,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          }),
    )
        .catchError((error) {
      print(error.toString());
      // Get.snackbar("Error", "",
      //     messageText: Text(
      //       "Please connect to server!",
      //       style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12.sp),
      //     ),
      //     icon: const Icon(
      //       Icons.error,
      //       color: Colors.red,
      //       size: 30,
      //     ),
      //     margin: EdgeInsets.symmetric(vertical: .1.sh, horizontal: .1.sw));
    });
  }

  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String? token,
  }) async {
    dio!.options.headers = {
      'Authorization': 'Basic $token',
    };
    return await dio!
        .delete(
      url,
      queryParameters: query,
      data: data,
      options: Options(
          contentType: Headers.jsonContentType,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          }),
    )
        .catchError((error) {
      print(error.toString());
      // Get.snackbar("Error", "",
      //     messageText: Text(
      //       "Please connect to server!",
      //       style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12.sp),
      //     ),
      //     icon: const Icon(
      //       Icons.error,
      //       color: Colors.red,
      //       size: 30,
      //     ),
      //     margin: EdgeInsets.symmetric(vertical: .1.sh, horizontal: .1.sw));
    });
  }

  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String? token,
  }) async {
    dio!.options.headers = {
      'Authorization': 'Basic $token',
    };
    return await dio!
        .put(
      url,
      queryParameters: query,
      data: data,
      options: Options(
          contentType: Headers.jsonContentType,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          }),
    )
        .catchError((error) {
      // Get.snackbar("Error", "",
      //     messageText: Text(
      //       "Please connect to server!",
      //       style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12.sp),
      //     ),
      //     icon: const Icon(
      //       Icons.error,
      //       color: Colors.red,
      //       size: 30,
      //     ),
      //     margin: EdgeInsets.symmetric(vertical: .1.sh, horizontal: .1.sw));
    });
  }
}
