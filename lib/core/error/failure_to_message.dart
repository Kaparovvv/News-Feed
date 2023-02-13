import 'package:news_feed/commons/names_helper.dart';
import 'package:news_feed/core/error/failure.dart';

class FailureToMessage {
  String mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return NamesHelper.serverFailureMessage;
      case CacheFailure:
        return NamesHelper.cacheFailureMessage;
      default:
        return 'Unexpected Error';
    }
  }
}
