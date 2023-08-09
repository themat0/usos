import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:oauth1/oauth1.dart';
import 'package:usos/data/credentials_repository.dart';
import 'package:usos/data/usos_repository.dart';

import '../../globalUi/cubit/global_ui_cubit.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit(this._repository, this._globalUiCubit, this._credentialsRepository) : super(const HomeScreenState());

  final UsosRepository _repository;
  final CredentialsRepository _credentialsRepository;
  final GlobalUiCubit _globalUiCubit;
  late final StreamSubscription<Credentials?> _credentialsStreamSubscription;

  Future<void> init() async {
    final name = await _repository.getName();
    if(name.isSuccessful){
      emit(state.copyWith(name: name.requiredData));
    } else {
      _globalUiCubit.showSnackBarError(name.errorResponse);
    }
    _credentialsStreamSubscription = _credentialsRepository.credentialsStream.listen((value) {
      if (value == null) emit(HomeScreenForceLogoutState(index: state.index,name: state.name,));
    });
  }

  void changeScreen(int index){
    emit(state.copyWith(index: index));
  }

  @override
  Future<void> close() {
    _credentialsStreamSubscription.cancel();
    return super.close();
  }
}
