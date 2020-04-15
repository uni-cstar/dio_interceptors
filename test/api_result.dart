import 'package:dio/dio.dart';

class ApiResult<T> {
  int code;

  String message;

  T data;

  /// 成功时是对应Response  失败时是对应的Exception
  dynamic extra;

  ApiResult(this.code, {this.message, this.data, this.extra});

  factory ApiResult.fromJson(
      Map<String, dynamic> json, T convert(Object data)) {
    return ApiResult<T>(json['code'] as int,
        message: json['message'] as String,
        extra: json['extra'],
        data: convert(json['data']));
  }

  Map<String, dynamic> toJson(dynamic covert(T data)) => <String, dynamic>{
        'code': code,
        'message': message,
        'extra': extra,
        'data': covert(data)
      };

  factory ApiResult.fromResponse(Response response) {
    return new ApiResult<T>(response.statusCode,
        message: response.statusMessage, extra: response);
  }

  factory ApiResult.fromError(Exception e) {
    if (e is DioError && e.response != null) {
      return ApiResult.fromResponse(e.response)..extra = e;
    } else {
      return new ApiResult<T>(900, message: e.toString(), extra: e);
    }
  }
}
