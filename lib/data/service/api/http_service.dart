import 'dart:io';
import 'package:dio/dio.dart';
import 'package:native_dio_adapter/native_dio_adapter.dart';

import '../locals/storage_service.dart';
import 'api_error_handle.dart';

class Response {
  Map<String, dynamic>? data = {};
  bool success;
  String? error;
  int? statusCode;

  Response({this.data, this.error, required this.success, this.statusCode});

  factory Response.fromData({
    required Map<String, dynamic> data,
    int? statusCode,
  }) {
    return Response(
      success: true,
      data: data,
      error: null,
      statusCode: statusCode,
    );
  }

  factory Response.fromError({required String error, int? statusCode}) {
    return Response(
      success: false,
      data: null,
      error: error,
      statusCode: statusCode,
    );
  }
}

class HttpService {
  static final Dio _dio =
      Dio()
        ..options = BaseOptions(
          contentType: 'application/json',
          responseType: ResponseType.json,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 30),
        )
        ..httpClientAdapter = NativeAdapter();

  /// Getter for the Dio instance
  static Dio get dio => _dio;

  static Future<Map<String, String>> _getAuthHeaders({
    bool withAuth = true,
  }) async {
    if (!withAuth) return {};

    String authToken = await StorageService.getAuthToken();
    return {"Authorization": "Bearer $authToken"};
  }

  static Future<Response> postImage(
    String url, {
    required File imageFile,
    Map<String, String>? fields,
    Map<String, String> headers = const {},
    bool withAuth = true,
  }) async {
    try {
      var authHeaders = await _getAuthHeaders(withAuth: withAuth);
      var allHeaders = {...authHeaders, ...headers};

      FormData formData = FormData();

      if (fields != null) {
        fields.forEach((key, value) {
          formData.fields.add(MapEntry(key, value));
        });
      }

      formData.files.add(
        MapEntry(
          'file',
          await MultipartFile.fromFile(
            imageFile.path,
            filename: imageFile.path.split('/').last,
          ),
        ),
      );

      var response = await _dio.post(
        url,
        data: formData,
        options: Options(headers: allHeaders),
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return Response.fromData(
          data: response.data,
          statusCode: response.statusCode,
        );
      } else {
        return Response.fromError(
          error: ApiErrorHandler.extractErrorMessage(
            response.data,
            response.statusCode,
          ),
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      return Response.fromError(
        error: DioExceptionHandler.handleException(e),
        statusCode: e.response?.statusCode,
      );
    } catch (error) {
      return Response.fromError(error: error.toString());
    }
  }

  static Future<Response> get(
    String url, {
    Map<String, String> headers = const {},
    bool withAuth = true,
  }) async {
    try {
      var authHeaders = await _getAuthHeaders(withAuth: withAuth);
      var allHeaders = {...authHeaders, ...headers};

      var response = await _dio.get(url, options: Options(headers: allHeaders));

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return Response.fromData(
          data: response.data,
          statusCode: response.statusCode,
        );
      } else {
        return Response.fromError(
          error: ApiErrorHandler.extractErrorMessage(
            response.data,
            response.statusCode,
          ),
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      return Response.fromError(
        error: DioExceptionHandler.handleException(e),
        statusCode: e.response?.statusCode,
      );
    } catch (error) {
      return Response.fromError(error: error.toString());
    }
  }

  static Future<ListResponse> getList(
    String url, {
    Map<String, String> headers = const {},
    bool withAuth = true,
  }) async {
    try {
      var authHeaders = await _getAuthHeaders(withAuth: withAuth);
      var allHeaders = {...authHeaders, ...headers};

      var response = await _dio.get(url, options: Options(headers: allHeaders));

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return ListResponse.fromData(
          data: response.data,
          statusCode: response.statusCode,
        );
      } else {
        return ListResponse.fromError(
          error: ApiErrorHandler.extractErrorMessage(
            response.data,
            response.statusCode,
          ),
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      return ListResponse.fromError(
        error: DioExceptionHandler.handleException(e),
        statusCode: e.response?.statusCode,
      );
    } catch (error) {
      print(" Error in getList: $error ");
      return ListResponse.fromError(error: error.toString());
    }
  }

  static Future<Response> post(
    String url, {
    required Map<String, dynamic> data,
    Map<String, String> headers = const {},
    bool withAuth = true,
  }) async {
    try {
      var authHeaders = await _getAuthHeaders(withAuth: withAuth);
      var allHeaders = {...authHeaders, ...headers};

      var response = await _dio.post(
        url,
        data: data,
        options: Options(headers: allHeaders),
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return Response.fromData(
          data: response.data,
          statusCode: response.statusCode,
        );
      } else {
        return Response.fromError(
          error: ApiErrorHandler.extractErrorMessage(
            response.data,
            response.statusCode,
          ),
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      return Response.fromError(
        error: DioExceptionHandler.handleException(e),
        statusCode: e.response?.statusCode,
      );
    } catch (error) {
      return Response.fromError(error: error.toString());
    }
  }

  static Future<Response> delete(
    String url, {
    Map<String, dynamic> data = const {},
    Map<String, String> headers = const {},
    bool withAuth = true,
  }) async {
    try {
      var authHeaders = await _getAuthHeaders(withAuth: withAuth);
      var allHeaders = {...authHeaders, ...headers};

      var response = await _dio.delete(
        url,
        data: data,
        options: Options(headers: allHeaders),
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return Response.fromData(
          data: response.data,
          statusCode: response.statusCode,
        );
      } else {
        return Response.fromError(
          error: ApiErrorHandler.extractErrorMessage(
            response.data,
            response.statusCode,
          ),
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      return Response.fromError(
        error: DioExceptionHandler.handleException(e),
        statusCode: e.response?.statusCode,
      );
    } catch (error) {
      return Response.fromError(error: error.toString());
    }
  }

  static Future<Response> put(
    String url, {
    required Map<String, dynamic> data,
    Map<String, String> headers = const {},
    bool withAuth = true,
  }) async {
    try {
      var authHeaders = await _getAuthHeaders(withAuth: withAuth);
      var allHeaders = {...authHeaders, ...headers};

      var response = await _dio.put(
        url,
        data: data,
        options: Options(headers: allHeaders),
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return Response.fromData(
          data: response.data,
          statusCode: response.statusCode,
        );
      } else {
        return Response.fromError(
          error: ApiErrorHandler.extractErrorMessage(
            response.data,
            response.statusCode,
          ),
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      return Response.fromError(
        error: DioExceptionHandler.handleException(e),
        statusCode: e.response?.statusCode,
      );
    } catch (error) {
      return Response.fromError(error: error.toString());
    }
  }

  static Future<Response> patch(
    String url, {
    Map<String, dynamic>? data,
    Map<String, String> headers = const {},
    bool withAuth = true,
  }) async {
    try {
      var authHeaders = await _getAuthHeaders(withAuth: withAuth);
      var allHeaders = {...authHeaders, ...headers};

      var response = await _dio.patch(
        url,
        data: data,
        options: Options(headers: allHeaders),
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return Response.fromData(
          data: response.data,
          statusCode: response.statusCode,
        );
      } else {
        return Response.fromError(
          error: ApiErrorHandler.extractErrorMessage(
            response.data,
            response.statusCode,
          ),
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      return Response.fromError(
        error: DioExceptionHandler.handleException(e),
        statusCode: e.response?.statusCode,
      );
    } catch (error) {
      return Response.fromError(error: error.toString());
    }
  }

  static Future<ListResponse> postList(
    String url, {
    required Map<String, dynamic> data,
    Map<String, String> headers = const {},
    bool withAuth = true,
  }) async {
    try {
      var authHeaders = await _getAuthHeaders(withAuth: withAuth);
      var allHeaders = {...authHeaders, ...headers};

      var response = await _dio.post(
        url,
        data: data,
        options: Options(headers: allHeaders),
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return ListResponse.fromData(
          data: response.data,
          statusCode: response.statusCode,
        );
      } else {
        return ListResponse.fromError(
          error: ApiErrorHandler.extractErrorMessage(
            response.data,
            response.statusCode,
          ),
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      return ListResponse.fromError(
        error: DioExceptionHandler.handleException(e),
        statusCode: e.response?.statusCode,
      );
    } catch (error) {
      return ListResponse.fromError(error: error.toString());
    }
  }

  static Future<UploadResponse> postImageUpload(
    String url, {
    required File imageFile,
    Map<String, String>? fields,
    Map<String, String> headers = const {},
    bool withAuth = true,
  }) async {
    try {
      var authHeaders = await _getAuthHeaders(withAuth: withAuth);
      var allHeaders = {...authHeaders, ...headers};

      FormData formData = FormData();

      if (fields != null) {
        fields.forEach((key, value) {
          formData.fields.add(MapEntry(key, value));
        });
      }

      formData.files.add(
        MapEntry(
          'file',
          await MultipartFile.fromFile(
            imageFile.path,
            filename: imageFile.path.split('/').last,
          ),
        ),
      );

      var response = await _dio.post(
        url,
        data: formData,
        options: Options(headers: allHeaders),
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return UploadResponse.fromSuccess(statusCode: response.statusCode);
      } else {
        return UploadResponse.fromError(
          error: ApiErrorHandler.extractErrorMessage(
            response.data,
            response.statusCode,
          ),
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      return UploadResponse.fromError(
        error: DioExceptionHandler.handleException(e),
        statusCode: e.response?.statusCode,
      );
    } catch (error) {
      return UploadResponse.fromError(error: error.toString());
    }
  }
}

class ListResponse {
  List<dynamic>? data;
  bool success;
  String? error;
  int? statusCode;

  ListResponse({this.data, this.error, required this.success, this.statusCode});

  factory ListResponse.fromData({required dynamic data, int? statusCode}) {
    if (data is List) {
      return ListResponse(
        success: true,
        data: data,
        error: null,
        statusCode: statusCode,
      );
    } else {
      return ListResponse.fromError(
        error: "Expected List but got ${data.runtimeType}",
      );
    }
  }

  factory ListResponse.fromError({required String error, int? statusCode}) {
    return ListResponse(
      success: false,
      data: null,
      error: error,
      statusCode: statusCode,
    );
  }
}

class UploadResponse {
  bool success;
  String? error;
  int? statusCode;

  UploadResponse({required this.success, this.error, this.statusCode});

  factory UploadResponse.fromSuccess({int? statusCode}) {
    return UploadResponse(success: true, error: null, statusCode: statusCode);
  }

  factory UploadResponse.fromError({required String error, int? statusCode}) {
    return UploadResponse(success: false, error: error, statusCode: statusCode);
  }
}
