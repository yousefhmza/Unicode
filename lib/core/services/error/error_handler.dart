
import '../../../config/localization/l10n/l10n.dart';
import '../../../config/navigation/navigation.dart';
import 'failure.dart';

class ErrorHandler {
  late Failure failure;

  ErrorHandler.handle(Exception error) {
    failure = Failure(ResponseCode.unKnown, error.toString());
  }
}

enum ErrorType {
  noInternetConnection,
  unKnown,
}

extension ErrorTypeException on ErrorType {
  Failure getFailure() {
    switch (this) {
      case ErrorType.noInternetConnection:
        return Failure(ResponseCode.noInternetConnection, ResponseMessage.noInternetConnection);
      case ErrorType.unKnown:
        return Failure(ResponseCode.unKnown, ResponseMessage.unKnown);
    }
  }
}

class ResponseCode {
  static const int noInternetConnection = -1;
  static const int unKnown = -2;
}

class ResponseMessage {
  static  String get noInternetConnection => L10n.tr(NavigationService.navigationKey.currentContext!).pleaseCheckConnection;
  static  String get unKnown => L10n.tr(NavigationService.navigationKey.currentContext!).errorOccurred;
}
