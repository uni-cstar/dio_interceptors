library dio_interceptors;

import 'package:dio/dio.dart';

class DioLogInterceptor extends InterceptorsWrapper {
  static const _keyExecutionTime = "_keyExecutionTime";

  String tag = "Http";

  /// 是否打印请求信息
  bool printRequest;

  bool printRequestHeader;

  /// 是否打印错误消息
  bool printError;

  /// 是否打印响应消息
  bool printResponse;

  bool printResponseHeader;

  /// 是否打印时间
  bool printTime;

  ///打印执行时间：请求和结束用去的时间
  bool printExecutionTime;

  DioLogInterceptor(
      {this.tag = "Http",
        this.printRequest = true,
        this.printRequestHeader = true,
        this.printResponse = true,
        this.printResponseHeader = false,
        this.printError = true,
        this.printTime = false,
        this.printExecutionTime = true});

  String _executionTime(int start) {
    if (!printExecutionTime) return "";

    return "(${DateTime.now().millisecondsSinceEpoch - start}ms)";
  }

  @override
  Future onRequest(RequestOptions options) async {
    if (printRequest) {
      print("$tag: --> ${options.method} ${options.uri.toString()}");
      if (printTime) print("$tag: Date:${DateTime.now().toString()}");
      print("$tag: Headers:${options.headers.toString()}");
      if (options.data != null) {
        print('Data:${options.data.toString()}');
      }
      print("$tag: --> END ${options.method}");
    }

    if (printExecutionTime) {
      options.extra[_keyExecutionTime] = DateTime.now().millisecondsSinceEpoch;
    }
    return options;
  }

  @override
  Future onError(DioError err) async {
    if (err.response != null) {
      print(
          "$tag: <-- ${err.response.statusCode} ${err.response.statusMessage} "
              "${err.request.uri.toString()} "
              "${_executionTime(err.request.extra[_keyExecutionTime] ?? 0)}");

      if (printResponseHeader) print("$tag: Headers:${err.response.headers}");
      if (printTime) print("$tag: Date:${DateTime.now().toString()}");
      print("$tag: ${err.response.toString()}");
    } else {
      print("$tag: <-- 请求错误 ${err.request.uri.toString()} "
          "${_executionTime(err.request.extra[_keyExecutionTime] ?? 0)}");
      print("$tag: ${err.toString()}");
    }
    print("$tag: <--  END HTTP");
    return err;
  }

  @override
  Future onResponse(Response response) async {
    print(
        "$tag: <-- ${response.statusCode} ${response.statusMessage} ${response.request.uri.toString()} "
            "${_executionTime(response.request.extra[_keyExecutionTime] ?? 0)}");
    if (printResponseHeader) print("$tag: Headers:${response.headers}");
    if (printTime) print("$tag: Date:${DateTime.now().toString()}");
    print("$tag: ${response.toString()}");
    print("$tag: <--  END HTTP");
    return response;
  }
}