import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:logger/logger.dart';
import 'package:oauth1/oauth1.dart' as oauth1;
import 'package:usos/data/credentials_repository.dart';
import 'package:usos/data/models/course.dart';

import 'models/grade.dart';
import 'models/term.dart';

class UsosApiService {
  UsosApiService(this._credentialsRepository);

  final CredentialsRepository _credentialsRepository;
  static const usosApi = "https://usosapi.polsl.pl/";
  final platform = oauth1.Platform(
    '${usosApi}services/oauth/request_token?scopes=grades|studies|offline_access', // temporary credentials request
    '${usosApi}services/oauth/authorize', // resource owner authorization
    '${usosApi}services/oauth/access_token', // token credentials request
    oauth1.SignatureMethods.hmacSha1, // signature method
  );
  final clientCredentials = oauth1.ClientCredentials(
    dotenv.env['USOS_KEY'] ?? '', //Api_Key
    dotenv.env['USOS_SECRET'] ?? '', // Api Secret
  );
  late final auth = oauth1.Authorization(clientCredentials, platform);

  Future<void> getCredentials() async {
    final res = await auth.requestTemporaryCredentials('com.bereta.usos://');
    final url = auth.getResourceOwnerAuthorizationURI(res.credentials.token);
    final response = await FlutterWebAuth.authenticate(url: url, callbackUrlScheme: 'com.bereta.usos');
    final pin = Uri.parse(response).queryParameters['oauth_verifier']!;
    final credentials = (await auth.requestTokenCredentials(res.credentials, pin)).credentials;
    await _credentialsRepository.saveCredentials(credentials);
  }

  Future<oauth1.Client> getClient() async {
    final credentials = await _credentialsRepository.getCredentials();
    return oauth1.Client(platform.signatureMethod, clientCredentials, credentials!);
  }

  Future<String> getName() async {
    final client = await getClient();
    final response = await client.get(Uri.parse('${usosApi}services/users/user?fields=first_name|last_name'));
    Logger().i(response.body.toString());
    return "${jsonDecode(response.body)['first_name']} ${jsonDecode(response.body)['last_name']}";
  }

  Future<String> getLatestGrades(int days) async {
    final client = await getClient();
    final response = await client.get(Uri.parse('${usosApi}services/grades/latest?days=$days&fields=course_edition'));
    Logger().i(response.body.toString());
    return response.toString();
  }

  Future<List<Course>> getCourses(Term term) async {
    final client = await getClient();
    final response = await client.get(Uri.parse('${usosApi}services/courses/user'));
    Logger().i(response.body.toString());
    final responseDecoded = jsonDecode(response.body);
    return responseDecoded['course_editions'][term.termId].map<Course>((entry) => Course.fromJson(entry)).toList();
  }

  Future<List<Grade>> getGrades(Term term) async {
    final client = await getClient();
    final responseGrades = jsonDecode(
        (await client.get(Uri.parse('${usosApi}services/grades/terms2?term_ids=${term.termId}&fields=value_symbol')))
            .body);
    final courses = await getCourses(term);

    final responseECTS = await getECTS(term.termId);
    final parsedResponse = courses
        .map<Grade>((course) => Grade.fromJson(
        course, responseGrades[term.termId][course.courseId], responseECTS != null ? responseECTS[course.courseId] : null))
        .toList();

    return parsedResponse;
  }

  Future<List<Term>> getTerms() async {
    final client = await getClient();
    final response = await client.get(Uri.parse('${usosApi}services/courses/user?fields=terms'));
    return jsonDecode(response.body)["terms"].map<Term>((entry) => Term.fromJson(entry)).toList();
  }

  Future<Map<String, dynamic>?> getECTS(String termId) async {
    final client = await getClient();
    final response = await client.get(Uri.parse('${usosApi}services/courses/user_ects_points'));
    Logger().i(jsonDecode(response.body)[termId].toString());
    return jsonDecode(response.body)[termId];
  }
}
