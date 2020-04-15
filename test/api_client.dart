import 'package:dio/dio.dart';
import 'package:dio_ext/dio_ext_interceptors.dart';

import 'api_result.dart';


class ApiClient {
  static ApiClient _instance = ApiClient._internal();

  Dio _dio;

  Dio get dio => _dio;

  static ApiClient getInstance({String baseUrl}) {
    if (baseUrl != null &&
        baseUrl.isNotEmpty &&
        baseUrl != _instance._dio.options.baseUrl) {
      _instance._dio.options.baseUrl = baseUrl;
    }
    return _instance;
  }

  ApiClient._internal() {
    if (null == _dio) {

      _dio = new Dio(BaseOptions());
      _dio.interceptors.add(new DioLogInterceptor());
//      _dio.interceptors.add(new FMResponseInterceptor());
    }
  }

  ///通用的GET请求
  Future<ApiResult<T>> get<T>(String url, T convert(Object data),
      {Map<String, dynamic> queryParams}) async {
    try {
      Response response = await _dio
          .get(url, queryParameters: queryParams);
      if (response.data is Map) {
        return ApiResult.fromJson(response.data, convert);
      } else {
        return ApiResult.fromResponse(response)..data = convert(response.data);
      }
    } catch (e) {
      return ApiResult.fromError(e);
    }
  }
}
