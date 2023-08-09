import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:usos/features/homeScreen/cubit/home_screen_cubit.dart';
import 'package:usos/generated/locale_keys.g.dart';

import '../../../core/widgets/koin_page.dart';
import '../../gradesScreen/view/grades_screen_form.dart';
import '../../loginScreen/view/login_screen_route.dart';
import '../../settingsScreen/view/settings_screen_form.dart';

class HomeScreenRoute extends KoinPage<HomeScreenCubit> {
  const HomeScreenRoute({super.key});

  // ignore: constant_identifier_names
  static const ROUTE_NAME = 'homeRoute';

  @override
  void initBloc(HomeScreenCubit bloc) {
    super.initBloc(bloc);
    bloc.init();
  }

  void _onItemTapped(int index, BuildContext context) {
    BlocProvider.of<HomeScreenCubit>(context).changeScreen(index);
    Navigator.pop(context);
  }

  Widget _pageNavigation(HomeScreenState state) => [
        const GradesScreenForm(),
        const SettingsScreenForm(),
      ].elementAt(state.index);

  @override
  Widget buildPage(BuildContext context) {
    return BlocConsumer<HomeScreenCubit, HomeScreenState>(
      listener: (context, state) {
        if (state is HomeScreenForceLogoutState) {
          Navigator.of(context).pushReplacementNamed(LoginScreenRoute.ROUTE_NAME);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "USOS",
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Text(state.name, style: Theme.of(context).textTheme.displayMedium),
                ),
                ListTile(
                  selected: state.index == 0,
                  leading: const Icon(FontAwesomeIcons.graduationCap),
                  title: Text(LocaleKeys.allGrades.tr()),
                  onTap: () => _onItemTapped(0, context),
                ),
                ListTile(
                  selected: state.index == 1,
                  leading: const Icon(FontAwesomeIcons.gears),
                  title: Text(LocaleKeys.settings.tr()),
                  onTap: () => _onItemTapped(1, context),
                ),
              ],
            ),
          ),
          body: _pageNavigation(state),
        );
      },
    );
  }
}
