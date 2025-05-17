import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_project/modules/core/config/router/router.dart';
import 'package:rick_and_morty_project/modules/data/repository/characters_list_repository.dart';
import 'package:rick_and_morty_project/modules/presentation/bloc/characters_bloc.dart';
import 'package:rick_and_morty_project/modules/presentation/bloc/characters_event.dart';

final appRouter = AppRouter();

void main() {
  runApp(
    BlocProvider(
      create:
          (context) =>
              CharactersBloc(CharactersListRepository())
                ..add(FetchCharacters()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Rick and Morty',
      routerConfig: appRouter.config(),
    );
  }
}
