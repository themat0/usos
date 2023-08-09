import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/koin_page.dart';
import '../../homeScreen/view/home_screen_route.dart';
import '../cubit/login_screen_cubit.dart';
import 'login_screen_form.dart';

class LoginScreenRoute extends KoinPage<LoginScreenCubit> {
  const LoginScreenRoute({super.key});

  static const ROUTE_NAME = 'LoginScreenRoute';

  void onLoginResult(BuildContext context, LoginScreenState state) {
    switch (state.runtimeType) {
      case LoginScreenSuccess:
        Navigator.of(context).pushReplacementNamed(HomeScreenRoute.ROUTE_NAME);
        break;
      default:
        return;
    }
  }

  @override
  Widget buildPage(BuildContext context) => BlocListener<LoginScreenCubit, LoginScreenState>(
        listener: onLoginResult,
        child: const LoginScreenForm(),
      );
}
