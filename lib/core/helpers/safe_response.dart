// ignore_for_file: constant_identifier_names

import 'package:logger/logger.dart';

enum ResponseStatus { SUCCESS, ERROR }

final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 6,
    errorMethodCount: 8,
    lineLength: 120,
    colors: true,
    printEmojis: true,
    printTime: true,
  ),
);

class SafeResponse<T> {
  late final T? data;
  late final dynamic errorResponse;
  late final ResponseStatus status;

  bool get isSuccessful => status == ResponseStatus.SUCCESS;

  T get requiredData => isSuccessful ? data! : throw Exception(errorResponse);

  SafeResponse.success(this.data) {
    status = ResponseStatus.SUCCESS;
    errorResponse = null;
  }

  SafeResponse.error(this.errorResponse) {
    status = ResponseStatus.ERROR;
    data = null;
  }
}

Future<SafeResponse<T>> fetchSafety<T>(Future<T> Function() request) async {
  try {
    final T data = await request();
    logger.i(data.toString());
    return SafeResponse.success(data);
  } catch (errorResponse) {
    logger.e(errorResponse.toString());
    return SafeResponse.error(errorResponse);
  }
}
