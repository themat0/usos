import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koin_flutter/koin_flutter.dart';

/// abstract class for screen with bloc automatically injected from [koin]
abstract class KoinWithParamsPage<T extends BlocBase, P>
    extends StatelessWidget {
  const KoinWithParamsPage({super.key});

  P get params;

  T createBloc() {
    final bloc = getWithParam<T, P>(params);
    initBloc(bloc);
    return bloc;
  }

  Widget buildPage(BuildContext context);

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (ctx) => createBloc(),
    child: Builder(
      builder: (context) => buildPage(context),
    ),
  );

  void initBloc(T bloc) {}
}
