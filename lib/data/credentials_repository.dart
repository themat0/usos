import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:oauth1/oauth1.dart';
import 'package:rxdart/rxdart.dart';

class CredentialsRepository {
  final _storage = const FlutterSecureStorage();
  final _credentials = BehaviorSubject<Credentials?>();

  Stream<Credentials?> get credentialsStream => _credentials.stream;

  Future<void> saveCredentials(Credentials credentials) async {
    final jsonString = json.encode(credentials.toJSON());
    await _storage.write(key: 'Credentials', value: jsonString);
    _credentials.add(credentials);
  }

  Future<Credentials?> getCredentials() async {
    final credentials = await _storage.read(key: 'Credentials');
    if(credentials == null) return null;
    final credentialsJson = jsonDecode(credentials);
    final credentialsDecode = Credentials(credentialsJson["oauth_token"], credentialsJson["oauth_token_secret"]);
    _credentials.add(credentialsDecode);
    return credentialsDecode;
  }

  Future<void> deleteCredentials() async {
    await _storage.delete(key: 'Credentials');
    _credentials.add(null);
  }

  void dispose() {
    _credentials.close();
  }
}
