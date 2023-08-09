part of 'global_ui_cubit.dart';

@immutable
abstract class GlobalUiState {}

class GlobalUiInitial extends GlobalUiState {}

class GlobalUiLoading extends GlobalUiState {}

class GlobalUiSnackBarError extends GlobalUiState {
  GlobalUiSnackBarError(this.message);

  final String message;
}

class GlobalUiAccessTokenError extends GlobalUiState {}
