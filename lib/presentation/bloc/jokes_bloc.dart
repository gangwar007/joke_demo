import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:joke_app/domain/entity/jokes.dart';
import 'package:joke_app/domain/usecase/get_jokes.dart';

part 'jokes_event.dart';
part 'jokes_state.dart';

class JokesBloc extends Bloc<JokesEvent, JokesState> {
  JokesBloc({
    required GetJokes getJokes,
  })  : _getJokes = getJokes,
        super(const JokesState()) {
    on<FetchNextJokeEvent>(_fetchNextJoke);
  }

  final GetJokes _getJokes;

  Future<void> _fetchNextJoke(event, emit) async {
    emit(state.copyWith(status: JokesPageStatus.loading));
    final list = await _getJokes();
    emit(
      state.copyWith(status: JokesPageStatus.success, jokes: list),
    );
  }
}
