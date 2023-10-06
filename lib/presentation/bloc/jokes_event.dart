part of 'jokes_bloc.dart';

sealed class JokesEvent extends Equatable {
  const JokesEvent();

  @override
  List<Object?> get props => [];
}

final class FetchNextJokeEvent extends JokesEvent {
  const FetchNextJokeEvent();

  @override
  List<Object?> get props => [];
}
