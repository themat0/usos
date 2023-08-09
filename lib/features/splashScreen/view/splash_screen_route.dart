import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:usos/features/homeScreen/view/home_screen_route.dart';
import 'package:usos/features/splashScreen/view/splash_screen_form.dart';

import '../../../core/widgets/koin_page.dart';
import '../../loginScreen/view/login_screen_route.dart';
import '../cubit/splash_screen_cubit.dart';

class SplashScreenRoute extends KoinPage<SplashScreenCubit> {
  const SplashScreenRoute({super.key});

  static const ROUTE_NAME = 'SplashScreenRoute';

  @override
  void initBloc(bloc) => bloc.init();

  void onLoginResult(BuildContext context, SplashScreenState state) {
    switch (state) {
      case SplashScreenState.loggedIn:
        Navigator.of(context).pushReplacementNamed(HomeScreenRoute.ROUTE_NAME);
        break;
      case SplashScreenState.notLogged:
        Navigator.of(context).pushReplacementNamed(LoginScreenRoute.ROUTE_NAME);
        break;
      default:
        return;
    }
  }

  @override
  Widget buildPage(BuildContext context) => BlocListener<SplashScreenCubit, SplashScreenState>(
        listener: onLoginResult,
        child: const SplashScreenForm(),
      );
}
