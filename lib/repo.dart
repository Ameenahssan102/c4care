import 'package:C4CARE/values/values.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Dio/api_response.dart';
import 'Dio/dio_client.dart';
import 'package:C4CARE/Utils/connectionstatus.dart';

import 'Dio/error_handler.dart';

class Repo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;
  Repo({required this.dioClient, required this.sharedPreferences});
  Future<ApiResponse> postData(String url, {data}) async {
    initNoInternetListener();
    try {
      final response =
          await dioClient.post(StringConst.baseUrl + url, data: data);

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getData(String url, {data}) async {
    initNoInternetListener();
    try {
      final response =
          await dioClient.get(StringConst.baseUrl + url, queryParameters: data);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> patchData(String url, {queryParameters, data}) async {
    var connection = await Connectivity().checkConnectivity();
    if (connection != ConnectivityResult.none) {
      try {
        final response = await dioClient.patch(StringConst.baseUrl + url,
            queryParameters: queryParameters, data: data);
        return ApiResponse.withSuccess(response);
      } catch (e) {
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    } else {
      return networkConnectivity.network();
    }
  }
}
