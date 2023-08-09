import 'package:easy_localization/easy_localization.dart';

import '../../generated/locale_keys.g.dart';
import '../helpers/rest_api_exception.dart';

class ErrorHandler {
  ErrorHandler();

  String getHandleError(error) {
    switch (error.runtimeType) {
      case String:
        return LocaleKeys.sthWentWrong.tr();
      case RestApiException:
        return _handleResponseError(error);
      default:
        return LocaleKeys.sthWentWrong.tr();
    }
  }

  String _handleResponseError(RestApiException error) {
    return LocaleKeys.sthWentWrong.tr();
  }
}
