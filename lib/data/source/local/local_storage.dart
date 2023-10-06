import 'dart:convert';

import 'package:joke_app/domain/entity/jokes.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorage {
  Future<bool> saveJokesPage({
    required List<Jokes> list,
  });

  List<Jokes> loadJokes();
}

class LocalStorageImpl implements LocalStorage {
  final SharedPreferences _sharedPref;

  LocalStorageImpl({
    required SharedPreferences sharedPreferences,
  }) : _sharedPref = sharedPreferences;

  @override
  List<Jokes> loadJokes() {
    final jsonData = _sharedPref.getString('jokes');
    if (jsonData != null) {
      List<Jokes> jsonList = List.from(json.decode(jsonData))
          .map((e) => Jokes.fromJson(e))
          .toList();
      return jsonList;
    }
    return [];
  }

  @override
  Future<bool> saveJokesPage({
    required List<Jokes> list,
  }) {
    return _sharedPref.setString('jokes', json.encode(list));
  }
}
