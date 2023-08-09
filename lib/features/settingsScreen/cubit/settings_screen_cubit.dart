import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:usos/data/credentials_repository.dart';
import 'package:usos/features/globalUi/cubit/global_ui_cubit.dart';

part 'settings_screen_state.dart';

class SettingsScreenCubit extends Cubit<SettingsScreenState> {
  SettingsScreenCubit(this._repository,this._globalUiCubit) : super(SettingsScreenInitial());

  final CredentialsRepository _repository;
  final GlobalUiCubit _globalUiCubit;

  void logout() {
    _globalUiCubit.showLoading();
    _repository.deleteCredentials();
    _globalUiCubit.hideLoading();
  }
}
