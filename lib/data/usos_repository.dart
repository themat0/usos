import 'package:usos/data/models/grade.dart';
import 'package:usos/data/models/term.dart';
import 'package:usos/data/usos_api_service.dart';

import '../core/helpers/safe_response.dart';

class UsosRepository {
  UsosRepository(this._apiService);

  final UsosApiService _apiService;

  Future<SafeResponse<void>> getCredentials() => fetchSafety(() async => await _apiService.getCredentials());

  Future<SafeResponse<String>> getName() => fetchSafety(() async => await _apiService.getName());

  Future<SafeResponse<List<Grade>>> getGrades(Term term) => fetchSafety(() async => await _apiService.getGrades(term));

  Future<SafeResponse<List<Term>>> getTerms() => fetchSafety(() async => await _apiService.getTerms());
}
