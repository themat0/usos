import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:usos/data/usos_repository.dart';
import 'package:usos/features/globalUi/cubit/global_ui_cubit.dart';

part 'login_screen_state.dart';

class LoginScreenCubit extends Cubit<LoginScreenState> {
  LoginScreenCubit(this._repository, this._globalUiCubit) : super(LoginScreenInitial());

  final UsosRepository _repository;
  final GlobalUiCubit _globalUiCubit;

  void auth() async {
    _globalUiCubit.showLoading();
    final response = await _repository.getCredentials();
    _globalUiCubit.hideLoading();
    if (response.isSuccessful) {
      emit(LoginScreenSuccess());
    } else {
      _globalUiCubit.showSnackBarError(response.errorResponse);
    }
  }
}
