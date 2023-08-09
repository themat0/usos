import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/infrastructure/error_handler.dart';

part 'global_ui_state.dart';

class GlobalUiCubit extends Cubit<GlobalUiState> {
  GlobalUiCubit(this._errorHandler) : super(GlobalUiInitial());

  final ErrorHandler _errorHandler;

  void showSnackBarError(dynamic message) {
    emit(GlobalUiSnackBarError(_errorHandler.getHandleError(message)));
  }

  void showLoading() {
    emit(GlobalUiLoading());
  }

  void hideLoading() {
    emit(GlobalUiInitial());
  }

  void forceLogout() {
    emit(GlobalUiAccessTokenError());
  }
}
