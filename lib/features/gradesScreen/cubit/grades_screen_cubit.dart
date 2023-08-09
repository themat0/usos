import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:usos/core/infrastructure/error_handler.dart';
import 'package:usos/data/usos_repository.dart';

import '../../../data/models/grade.dart';
import '../../../data/models/term.dart';

part 'grades_screen_state.dart';

class GradesScreenCubit extends Cubit<GradesScreenState> {
  GradesScreenCubit(this._repository, this._errorHandler) : super(GradesScreenInitial());

  final UsosRepository _repository;
  final ErrorHandler _errorHandler;

  void setTerm(Term newTerm) async {
    final stateGradesScreenLoading = state as GradesScreenLoading;
    emit(stateGradesScreenLoading.copyWith(selectedTerm: newTerm));
    final grades = await _repository.getGrades(newTerm);
    if (grades.isSuccessful) {
      emit(GradesScreenLoaded(stateGradesScreenLoading.terms, newTerm, grades.requiredData));
    } else {
      _errorHandler.getHandleError(grades.errorResponse);
    }
  }

  void init() async {
    final terms = await _repository.getTerms();
    if (terms.isSuccessful) {
      final grades = await _repository.getGrades(terms.requiredData.last);
      if (grades.isSuccessful) {
        emit(GradesScreenLoaded(terms.requiredData, terms.requiredData.last, grades.requiredData));
      } else {
        _errorHandler.getHandleError(grades.errorResponse);
      }
    } else {
      _errorHandler.getHandleError(terms.errorResponse);
    }
  }
}
