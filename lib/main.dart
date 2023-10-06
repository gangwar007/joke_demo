import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joke_app/data/joke_repository_impl.dart';
import 'package:joke_app/domain/usecase/get_jokes.dart';
import 'package:joke_app/presentation/views/jokes_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/source/local/local_storage.dart';
import 'data/source/network/api.dart';

late SharedPreferences sharedPref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    late GetJokes _getAllCharacters;
    final api = ApiImpl();
    final localStorage = LocalStorageImpl(sharedPreferences: sharedPref);
    final repo = JokeRepositoryImpl(api: api, localStorage: localStorage);

    _getAllCharacters = GetJokes(repository: repo);
    return MaterialApp(
        title: 'Joke Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: RepositoryProvider.value(
          value: _getAllCharacters,
          child: const AppView(),
        ));
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return const JokesPage();
  }
}
