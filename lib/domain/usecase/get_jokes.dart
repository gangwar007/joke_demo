import 'package:joke_app/domain/entity/jokes.dart';
import 'package:joke_app/domain/repository/joke_repository.dart';

class GetJokes {
  GetJokes({
    required JokeRepository repository,
  }) : _repository = repository;

  final JokeRepository _repository;

  Future<List<Jokes>> call() async {
    final list = await _repository.getJokes();
    return list;
  }
}
