import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joke_app/presentation/views/jokes_item/jokes_list_item.dart';

import '../../domain/usecase/get_jokes.dart';
import '../bloc/jokes_bloc.dart';
import 'jokes_item/jokes_list_item_header.dart';

// -----------------------------------------------------------------------------
// Page
// -----------------------------------------------------------------------------
class JokesPage extends StatelessWidget {
  const JokesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => JokesBloc(
              getJokes: context.read<GetJokes>(),
            )..add(const FetchNextJokeEvent()),
        child: Container(
          color: Colors.white,
          child: const JokeView(),
        ));
  }
}

// -----------------------------------------------------------------------------
// View
// -----------------------------------------------------------------------------
class JokeView extends StatelessWidget {
  const JokeView({super.key});

  @override
  Widget build(BuildContext context) {
    final status = context.select((JokesBloc b) => b.state.status);
    return status == JokesPageStatus.initial
        ? const Center(child: CircularProgressIndicator())
        : const _Content();
  }
}

// -----------------------------------------------------------------------------
// Content
// -----------------------------------------------------------------------------
class _Content extends StatefulWidget {
  const _Content({super.key});

  @override
  State<_Content> createState() => __ContentState();
}

class __ContentState extends State<_Content> {
  Timer? mytimer;
  JokesBloc get pageBloc => context.read<JokesBloc>();

  @override
  void initState() {
    super.initState();
    mytimer = Timer.periodic(Duration(seconds: 5), (timer) {
      pageBloc.add(const FetchNextJokeEvent());
    });
  }

  @override
  Widget build(BuildContext ctx) {
    final list = ctx.select((JokesBloc b) => b.state.jokes);
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: ListView.builder(
        key: const ValueKey('joke_page_list_key'),
        //   controller: _scrollController,
        itemCount: list.length,
        itemBuilder: (context, index) {
          final item = list[index];
          return index == 0
              ? Column(
                  children: [
                    const JokesListItemHeader(titleText: 'All Jokes'),
                    JokesListItem(item),
                  ],
                )
              : JokesListItem(item);
        },
      ),
    );
  }

  @override
  void dispose() {
    mytimer?.cancel();
    super.dispose();
  }
}
