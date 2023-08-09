import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:usos/features/gradesScreen/cubit/grades_screen_cubit.dart';
import 'package:usos/features/gradesScreen/view/widgets/drop_down_terms.dart';
import 'package:usos/features/gradesScreen/view/widgets/grade_widget.dart';

import '../../../core/widgets/koin_page.dart';
import '../../../styles/colors.dart';

class GradesScreenForm extends KoinPage<GradesScreenCubit> {
  const GradesScreenForm({super.key});

  @override
  void initBloc(GradesScreenCubit bloc) {
    super.initBloc(bloc);
    bloc.init();
  }

  @override
  Widget buildPage(BuildContext context) =>
      BlocBuilder<GradesScreenCubit, GradesScreenState>(builder: (context, state) {
        return state is GradesScreenLoading
            ? Column(
                children: [
                  DropDownTerms(
                    state.terms,
                    BlocProvider.of<GradesScreenCubit>(context).setTerm,
                  ),
                  state is GradesScreenLoaded
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: state.grades.length,
                            itemBuilder: (context, index) {
                              return GradeWidget(state.grades[index]);
                            },
                          ),
                        )
                      : const Center(child: CircularProgressIndicator(color: UsosColors.primaryColor)),
                ],
              )
            : const Center(child: CircularProgressIndicator(color: UsosColors.primaryColor));
      });
}
