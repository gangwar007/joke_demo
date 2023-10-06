part of 'jokes_bloc.dart';

enum JokesPageStatus { initial, loading, success, failure }

class JokesState extends Equatable {
  const JokesState({
    this.status = JokesPageStatus.initial,
    this.jokes = const [],
  });

  final JokesPageStatus status;
  final List<Jokes> jokes;

  JokesState copyWith({
    JokesPageStatus? status,
    List<Jokes>? jokes,
    bool? hasReachedEnd,
    int? currentPage,
  }) {
    return JokesState(
      status: status ?? this.status,
      jokes: jokes ?? this.jokes,
    );
  }

  @override
  List<Object> get props => [status, jokes];
}
