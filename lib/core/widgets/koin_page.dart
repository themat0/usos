import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koin_flutter/koin_flutter.dart';

/// abstract class for screen with bloc automatically injected from [koin]
abstract class KoinPage<T extends BlocBase> extends StatelessWidget {
  const KoinPage({super.key});

  T createBloc(){
    final bloc = get<T>();
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
