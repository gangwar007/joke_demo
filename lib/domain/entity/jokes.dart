/// joke : "A man once claimed Chuck Norris kicked his ass twice, but it was promptly dismissed as false - no one could survive it the first time."

class Jokes {
  Jokes({
    String? joke,
  }) {
    _joke = joke ?? '';
  }

  Jokes.fromJson(dynamic json) {
    _joke = json['joke'];
  }
  String? _joke;
  Jokes copyWith({
    String? joke,
  }) =>
      Jokes(
        joke: joke ?? _joke,
      );
  String get joke => _joke ?? '';

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['joke'] = _joke;
    return map;
  }
}
