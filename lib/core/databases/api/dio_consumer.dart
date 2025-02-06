import 'package:dio/dio.dart';
import 'package:happytech_clean_architecture/core/databases/api/api_consumer.dart';
import 'package:happytech_clean_architecture/core/databases/api/end_points.dart';
import 'package:happytech_clean_architecture/core/errors/error_model.dart';
import 'package:happytech_clean_architecture/core/errors/expentions.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options.baseUrl = EndPoints.baserUrl;
    // print("Base URL: ${dio.options.baseUrl}"); // Debugging base URL

    // Add logging interceptor
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        print("Request to: ${options.uri}");
        print("Data Sent: ${options.data}");
        return handler.next(options);
      },
      onResponse: (response, handler) {
        print("Response Data: ${response.data}");
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        print("Dio Error: ${e.message}");
        return handler.next(e);
      },
    ));
  }

  //! POST
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
      print("Response Data: ${response.data}");
      return response.data;
    } on DioException catch (e) {
      handleDioException(e);
      throw ServerException((e.message ?? "Unknown Dio error")
          as ErrorModel); // Ensuring the error is thrown
    }
  }

  //! GET
  @override
  Future get(String path,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      var response =
          await dio.get(path, data: data, queryParameters: queryParameters);
      print("GET Response Data: ${response.data}"); // Debugging response
      return response.data;
    } on DioException catch (e) {
      handleDioException(e);
      throw ServerException((e.message ?? "Unknown Dio error") as ErrorModel);
    }
  }

  //! DELETE
  @override
  Future delete(String path,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      var response = await dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      print("DELETE Response Data: ${response.data}"); // Debugging response
      return response.data;
    } on DioException catch (e) {
      handleDioException(e);
      throw ServerException((e.message ?? "Unknown Dio error") as ErrorModel);
    }
  }

  //! PATCH
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
      print("PATCH Response Data: ${response.data}"); // Debugging response
      return response.data;
    } on DioException catch (e) {
      handleDioException(e);
      throw ServerException((e.message ?? "Unknown Dio error") as ErrorModel);
    }
  }

  //! Exception Handling
  void handleDioException(DioException e) {
    print("DioException: ${e.message}"); // Debugging error

    throw ServerException(
      ErrorModel(
        status:
            e.response?.statusCode ?? 500, // Default to 500 if no status code
        errorMessage:
            e.response?.data["message"] ?? e.message ?? "Unknown error",
      ),
    );
  }
}
