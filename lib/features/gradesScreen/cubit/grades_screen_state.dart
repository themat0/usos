part of 'grades_screen_cubit.dart';

abstract class GradesScreenState extends Equatable {
  const GradesScreenState();
}

class GradesScreenInitial extends GradesScreenState {
  @override
  List<Object> get props => [];
}

class GradesScreenLoading extends GradesScreenState {
  const GradesScreenLoading(this.terms, this.selectedTerm);

  final List<Term> terms;
  final Term selectedTerm;

  @override
  List<Object> get props => [terms, selectedTerm];

  GradesScreenLoading copyWith({List<Term>? terms, Term? selectedTerm}) {
    return GradesScreenLoading(terms ?? this.terms, selectedTerm ?? this.selectedTerm);
  }
}

class GradesScreenLoaded extends GradesScreenLoading {
  const GradesScreenLoaded(super.terms, super.selectedTerm, this.grades);

  final List<Grade> grades;

  @override
  List<Object> get props => [terms, selectedTerm, grades];
}
