import 'package:dio/dio.dart';
import 'package:happytech_clean_architecture/core/databases/api/api_consumer.dart';
import 'package:happytech_clean_architecture/core/databases/api/end_points.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options.baseUrl = EndPoints.baserUrl;

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        print("Request to: \${options.uri}");
        print("Data Sent: \${options.data}");
        return handler.next(options);
      },
      onResponse: (response, handler) {
        print("Response Data: \${response.data}");
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        print("Dio Error: \${e.message}");
        return handler.next(e);
      },
    ));
  }

  @override
  Future post(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      bool isFormData = false}) async {
    try {
      var response = await dio.post(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.message ?? "Unknown Dio error");
    }
  }

  @override
  Future get(String path,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      var response =
          await dio.get(path, data: data, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.message ?? "Unknown Dio error");
    }
  }

  @override
  Future delete(String path,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      var response = await dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.message ?? "Unknown Dio error");
    }
  }

  @override
  Future patch(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      bool isFormData = false}) async {
    try {
      var response = await dio.patch(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.message ?? "Unknown Dio error");
    }
  }
}
