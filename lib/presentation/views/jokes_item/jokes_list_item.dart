import 'package:flutter/material.dart';
import 'package:joke_app/domain/entity/jokes.dart';

class JokesListItem extends StatelessWidget {
  Jokes item;

  JokesListItem(this.item);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      children: [
        Card(elevation: 0, color: Colors.transparent, child: Text(item.joke)),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Divider(
            height: 1,
            color: cs.onSecondaryContainer.withOpacity(0.2),
          ),
        ),
      ],
    );
  }
}
