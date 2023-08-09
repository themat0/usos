import 'package:koin/koin.dart';
import 'package:usos/data/credentials_repository.dart';
import 'package:usos/data/usos_api_service.dart';
import 'package:usos/data/usos_repository.dart';
import 'package:usos/features/gradesScreen/cubit/grades_screen_cubit.dart';
import 'package:usos/features/homeScreen/cubit/home_screen_cubit.dart';

import '../../features/globalUi/cubit/global_ui_cubit.dart';
import '../../features/loginScreen/cubit/login_screen_cubit.dart';
import '../../features/settingsScreen/cubit/settings_screen_cubit.dart';
import '../../features/splashScreen/cubit/splash_screen_cubit.dart';
import '../widgets/snackbar.dart';
import 'error_handler.dart';

final appModule = Module()
  ..single((scope) => SnackBarUtils())
  ..single((scope) => ErrorHandler())
  ..single((scope) => CredentialsRepository())
  ..single((scope) => UsosApiService(scope.get<CredentialsRepository>()))
  ..single((scope) => UsosRepository(scope.get<UsosApiService>()))
  ..single((scope) => GlobalUiCubit(scope.get<ErrorHandler>()))
  ..single((scope) => SplashScreenCubit(scope.get<CredentialsRepository>()))
  ..factory((scope) => LoginScreenCubit(scope.get<UsosRepository>(), scope.get<GlobalUiCubit>()))
  ..factory((scope) =>
      HomeScreenCubit(scope.get<UsosRepository>(), scope.get<GlobalUiCubit>(), scope.get<CredentialsRepository>()))
  ..factory((scope) => GradesScreenCubit(scope.get<UsosRepository>(), scope.get<ErrorHandler>()))
  ..factory((scope) => SettingsScreenCubit(scope.get<CredentialsRepository>(), scope.get<GlobalUiCubit>()));
