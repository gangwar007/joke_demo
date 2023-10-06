import 'package:dio/dio.dart';
import 'package:joke_app/domain/entity/jokes.dart';

abstract class Api {
  Future<Jokes> loadJokes();
}

class ApiImpl implements Api {
  final dio = Dio();

  @override
  Future<Jokes> loadJokes() async {
    try {
      Response response;
      response = await dio
          .get('https://geek-jokes.sameerkumar.website/api?format=json');
      return Jokes(joke: response.data['joke']);
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.headers);
        print(e.response?.requestOptions);

        //  API responds with 404 when reached the end
        if (e.response?.statusCode == 404) return Jokes();
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }
    }

    return Jokes();
  }
}
