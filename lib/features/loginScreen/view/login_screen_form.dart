import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:usos/generated/locale_keys.g.dart';
import 'package:usos/styles/images.dart';

import '../../../styles/dimensions.dart';
import '../cubit/login_screen_cubit.dart';

class LoginScreenForm extends StatelessWidget {
  const LoginScreenForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.circular), // Image border
                child: Image.asset(
                  UsosImages.logo,
                  scale: 5,
                ),
              ),
            ),
            CarouselSlider(
              options: CarouselOptions(height: MediaQuery.of(context).size.height * .25, autoPlay: true),
              items: [LocaleKeys.hero1.tr(), LocaleKeys.hero2.tr(), LocaleKeys.hero3.tr()].map((text) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: Dimensions.spanSmall),
                      child: Text(
                        text,
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            ElevatedButton(
                onPressed: () => BlocProvider.of<LoginScreenCubit>(context).auth(), child: Text(LocaleKeys.login.tr())),
          ],
        ),
      ),
    );
  }
}
