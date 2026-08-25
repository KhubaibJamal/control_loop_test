import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioExceptionHandler {
  static String handleException(DioException e) {
    final statusCode = e.response?.statusCode;
    final responseData = e.response?.data;

    if (kDebugMode) {
      print("STATUS CODEr: $statusCode");
      print("RESPONSE DATAr: $responseData");
    }

    if (responseData != null) {
      final errorMessage = ApiErrorHandler.extractErrorMessage(
        responseData,
        statusCode,
      );
      if (errorMessage.isNotEmpty) return errorMessage;
    }

    return _getExceptionTypeMessage(e, statusCode);
  }

  static String _getExceptionTypeMessage(DioException e, int? statusCode) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout. Please check your internet connection';

      case DioExceptionType.sendTimeout:
        return 'Send timeout. Please try again';

      case DioExceptionType.receiveTimeout:
        return 'Receive timeout. Server is taking too long to respond';

      case DioExceptionType.badResponse:
        return StatusCodeErrorHandler.getErrorMessage(statusCode);

      case DioExceptionType.cancel:
        return 'Request was cancelled';

      case DioExceptionType.connectionError:
        return 'Connection error. Please check your internet connection';

      case DioExceptionType.badCertificate:
        return 'Security certificate error. Unable to verify server';

      case DioExceptionType.unknown:
        return e.message ?? 'An unknown error occurred';
      case DioExceptionType.transformTimeout:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }
}

class ApiErrorHandler {
  static String extractErrorMessage(dynamic responseData, int? statusCode) {
    final backendMessage = _extractBackendMessage(responseData);
    if (backendMessage != null) {
      return backendMessage;
    }

    return StatusCodeErrorHandler.getErrorMessage(statusCode);
  }

  static String? _extractBackendMessage(dynamic responseData) {
    if (responseData is Map<String, dynamic>) {
      if (responseData.containsKey('message') &&
          responseData['message'] != null &&
          responseData['message'].toString().isNotEmpty) {
        return responseData['message'].toString();
      }

      if (responseData.containsKey('error') &&
          responseData['error'] != null &&
          responseData['error'].toString().isNotEmpty) {
        return responseData['error'].toString();
      }
    }

    return null;
  }
}

class StatusCodeErrorHandler {
  static String getErrorMessage(int? statusCode) {
    if (statusCode == null) return 'Unknown error occurred';

    switch (statusCode) {
      case 400:
        return 'Bad request. Please check your input';
      case 401:
        return 'Unauthorized. Please login again';
      case 403:
        return 'Access forbidden';
      case 404:
        return 'Resource not found';
      case 405:
        return 'Method not allowed';
      case 408:
        return 'Request timeout';
      case 409:
        return 'Conflict occurred';
      case 410:
        return 'Resource no longer available';
      case 413:
        return 'Request entity too large';
      case 415:
        return 'Unsupported media type';
      case 422:
        return 'Validation error. Please check your data';
      case 429:
        return 'Too many requests. Please try again later';

      case 500:
        return 'Internal server error';
      case 501:
        return 'Not implemented';
      case 502:
        return 'Bad gateway';
      case 503:
        return 'Service unavailable';
      case 504:
        return 'Gateway timeout';

      default:
        if (statusCode >= 400 && statusCode < 500) {
          return 'Client error occurred (Code: $statusCode)';
        } else if (statusCode >= 500) {
          return 'Server error occurred (Code: $statusCode)';
        }
        return 'Unknown error occurred (Code: $statusCode)';
    }
  }
}
