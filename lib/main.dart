import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:koin/koin.dart';
import 'package:koin_flutter/koin_flutter.dart';
import 'package:usos/styles/theme.dart';

import 'core/helpers/routes.dart';
import 'core/infrastructure/app_module.dart';
import 'core/widgets/snackbar.dart';
import 'features/globalUi/cubit/global_ui_cubit.dart';
import 'features/globalUi/view/widgets/block_ui_progress_indicator.dart';
import 'features/splashScreen/view/splash_screen_route.dart';

Future<void> main() async {
  MyApp.run();
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  static late final koin;

  static void initKoin() {
    koin = startKoin((app) => app.modules([appModule])).koin;
  }

  static Future run() async {
    initKoin();
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
    await dotenv.load(fileName: ".env");

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
          (value) => runApp(
        EasyLocalization(
          useOnlyLangCode: true,
          supportedLocales: const [
            Locale('pl'),
            Locale('en'),
          ],
          path: 'assets/translations',
          useFallbackTranslations: true,
          fallbackLocale: const Locale('en'),
          child: MyApp(),
        ),
      ),
    );
  }

  late final SnackBarUtils _snackBarUtils = get();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => get<GlobalUiCubit>(),
      child: MaterialApp(
        title: 'USOS',
        theme: createTheme(context),
        routes: routes,
        initialRoute: SplashScreenRoute.ROUTE_NAME,
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        builder: (context, child) {
          return Scaffold(
            body: BlocConsumer<GlobalUiCubit, GlobalUiState>(
              listener: (context, state) {
                if (state is GlobalUiSnackBarError) {
                  _snackBarUtils.showErrorSnackBar(context, state.message);
                } else if (state is GlobalUiAccessTokenError) {
                  //Navigator.of(context)
                  //    .pushReplacementNamed(LoginScreenRoute.ROUTE_NAME);
                }
              },
              builder: (context, state) {
                return Stack(
                  children: [
                    child ?? Container(),
                    if (state is GlobalUiLoading)
                      const BlockUiProgressIndicator(),
                  ],
                );
              },
            ),
          );
        },
        onGenerateRoute: (RouteSettings settings) => MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              return getGenerateRoutePage(settings);
            }),
      ),
    );
  }
}
