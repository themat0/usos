import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:usos/features/settingsScreen/cubit/settings_screen_cubit.dart';
import 'package:usos/generated/locale_keys.g.dart';

import '../../../core/widgets/koin_page.dart';

class SettingsScreenForm extends KoinPage<SettingsScreenCubit> {
  const SettingsScreenForm({super.key});

  @override
  Widget buildPage(BuildContext context) => Center(
      child: ElevatedButton(
          onPressed: BlocProvider.of<SettingsScreenCubit>(context).logout, child: Text(LocaleKeys.logout.tr())));
}
