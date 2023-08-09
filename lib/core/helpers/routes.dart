import 'package:flutter/material.dart';
import 'package:usos/features/homeScreen/view/home_screen_route.dart';

import '../../features/loginScreen/view/login_screen_route.dart';
import '../../features/splashScreen/view/splash_screen_route.dart';

final routes = <String, WidgetBuilder>{
  SplashScreenRoute.ROUTE_NAME: (_) => const SplashScreenRoute(),
};

Widget getGenerateRoutePage(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreenRoute.ROUTE_NAME:
      return const SplashScreenRoute();
    case LoginScreenRoute.ROUTE_NAME:
      return const LoginScreenRoute();
    case HomeScreenRoute.ROUTE_NAME:
      return const HomeScreenRoute();
    default:
      throw Exception("Not screen specified to route ${settings.name}");
  }
}
