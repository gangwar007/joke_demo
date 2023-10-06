import 'package:joke_app/data/source/local/local_storage.dart';
import 'package:joke_app/data/source/network/api.dart';
import 'package:joke_app/domain/entity/jokes.dart';
import 'package:joke_app/domain/repository/joke_repository.dart';

class JokeRepositoryImpl implements JokeRepository {
  final Api _api;
  final LocalStorage _localStorage;
  int index = 0;

  JokeRepositoryImpl({
    required Api api,
    required LocalStorage localStorage,
  })  : _api = api,
        _localStorage = localStorage;

  @override
  Future<List<Jokes>> getJokes() async {
    List<Jokes> list = [];
    final fetchedList = await _api.loadJokes();
    final cachedList = _localStorage.loadJokes();

    if (cachedList.isNotEmpty) {
      if (cachedList.length >= 10) {
        cachedList.replaceRange(index, index + 1, [fetchedList]);
        ++index;
      } else {
        cachedList.add(fetchedList);
      }
      await _localStorage.saveJokesPage(list: cachedList);
      if (index > 9) {
        index = 0;
      }
      return cachedList;
    }
    list.add(fetchedList);
    await _localStorage.saveJokesPage(list: list);
    return list;
  }
}
