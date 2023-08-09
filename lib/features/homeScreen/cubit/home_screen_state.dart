part of 'home_screen_cubit.dart';

class HomeScreenState extends Equatable {
  const HomeScreenState({this.index = 0, this.name = ""});

  final int index;
  final String name;

  @override
  List<Object> get props => [index, name];

  HomeScreenState copyWith({int? index, String? name}) {
    return HomeScreenState(index: index ?? this.index, name: name ?? this.name);
  }
}

class HomeScreenForceLogoutState extends HomeScreenState {
  const HomeScreenForceLogoutState({required super.index, required super.name});
}
