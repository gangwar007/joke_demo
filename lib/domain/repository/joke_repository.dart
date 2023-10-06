import 'package:joke_app/domain/entity/jokes.dart';

abstract class JokeRepository {
  Future<List<Jokes>> getJokes();
}
