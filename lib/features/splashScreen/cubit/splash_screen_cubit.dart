import 'package:bloc/bloc.dart';
import 'package:usos/data/credentials_repository.dart';

part 'splash_screen_state.dart';

class SplashScreenCubit extends Cubit<SplashScreenState> {
  SplashScreenCubit(this._credentialsRepository) : super(SplashScreenState.initial);

  final CredentialsRepository _credentialsRepository;

  void init() async {
    await Future.delayed(const Duration(seconds: 1));
    if (await _credentialsRepository.getCredentials() != null) {
      emit(SplashScreenState.loggedIn);
    } else {
      emit(SplashScreenState.notLogged);
    }
  }
}
