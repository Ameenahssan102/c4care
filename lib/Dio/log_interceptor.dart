// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LoggingInterceptor extends InterceptorsWrapper {
  int maxCharectersPerLine = 200;

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (kDebugMode) {
      print("--> ${options.method} ${options.path}");
    }
    if (kDebugMode) {
      print("Headers: ${options.method.toString()}");
    }
    if (kDebugMode) {
      print("<-- END HTTP");
    }

    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    if (kDebugMode) {
      print(
        "<-- ${response.statusCode} ${response.requestOptions.method} ${response.requestOptions.path}");
    }

    String responseAsString = response.data.toString();

    if (responseAsString.length > maxCharectersPerLine) {
      int iterations = (responseAsString.length / maxCharectersPerLine).floor();
      for (int i = 0; i <= iterations; i++) {
        int endingIndex = i * maxCharectersPerLine + maxCharectersPerLine;
        if (endingIndex > responseAsString.length) {
          endingIndex = responseAsString.length;
        }
        if (kDebugMode) {
          print(responseAsString.substring(i * maxCharectersPerLine,endingIndex));
        }
      }
    }else {
      if (kDebugMode) {
        print(response.data);
      }
    }
    return super.onResponse(response, handler);
      }

      @override
      Future onError(DioError err,ErrorInterceptorHandler handler)async {
        if(err.response?.statusCode == 401){
          if (kDebugMode) {
            print("401 LoggingInterceptor");
          }
        }

        if (kDebugMode) {
          print("ERROR[${err.response?.statusCode}] => PATH : ${err.requestOptions.path}");
        }
        return super.onError(err, handler);
      }
    }