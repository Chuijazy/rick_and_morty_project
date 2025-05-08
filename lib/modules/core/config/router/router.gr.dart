// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;
import 'package:flutter/material.dart';
import 'package:rick_and_morty_project/modules/domain/entities/characters_entity.dart'
    as _i9;
import 'package:rick_and_morty_project/modules/presentation/screens/characters_info_screen.dart'
    as _i1;
import 'package:rick_and_morty_project/modules/presentation/screens/characters_list_screen.dart'
    as _i2;
import 'package:rick_and_morty_project/modules/presentation/screens/episodes_screen.dart'
    as _i4;
import 'package:rick_and_morty_project/modules/presentation/screens/filters_screen.dart'
    as _i5;
import 'package:rick_and_morty_project/modules/presentation/screens/home_screen.dart'
    as _i6;
import 'package:rick_and_morty_project/modules/presentation/screens/main_screens_details/characters_list_view_screen.dart';
import 'package:rick_and_morty_project/modules/presentation/screens/main_screens_details/custom_bottom_navigator_bar_screen.dart'
    as _i3;

/// generated route for
/// [_i1.CharactersInfoScreen]
class CharactersInfoRoute extends _i7.PageRouteInfo<CharactersInfoRouteArgs> {
  CharactersInfoRoute({
    _i8.Key? key,
    required _i9.CharactersEntity character,
    List<_i7.PageRouteInfo>? children,
  }) : super(
         CharactersInfoRoute.name,
         args: CharactersInfoRouteArgs(key: key, character: character),
         initialChildren: children,
       );

  static const String name = 'CharactersInfoRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CharactersInfoRouteArgs>();
      return _i1.CharactersInfoScreen(key: args.key, character: args.character);
    },
  );
}

class CharactersInfoRouteArgs {
  const CharactersInfoRouteArgs({this.key, required this.character});

  final _i8.Key? key;

  final _i9.CharactersEntity character;

  @override
  String toString() {
    return 'CharactersInfoRouteArgs{key: $key, character: $character}';
  }
}

/// generated route for
/// [_i2.CharactersListScreen]
class CharactersListRoute extends _i7.PageRouteInfo<void> {
  const CharactersListRoute({List<_i7.PageRouteInfo>? children})
    : super(CharactersListRoute.name, initialChildren: children);

  static const String name = 'CharactersListRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i2.CharactersListScreen();
    },
  );
}

/// generated route for
/// [CharactersListViewScreen]
class CharactersListViewRoute
    extends _i7.PageRouteInfo<CharactersListViewRouteArgs> {
  CharactersListViewRoute({
    Key? key,
    required List<_i9.CharactersEntity> characters,
    required String searchQuery,
    required bool isLoading,
    required ScrollController scrollController,
    List<_i7.PageRouteInfo>? children,
  }) : super(
         CharactersListViewRoute.name,
         args: CharactersListViewRouteArgs(
           key: key,
           characters: characters,
           searchQuery: searchQuery,
           isLoading: isLoading,
           scrollController: scrollController,
         ),
         initialChildren: children,
       );

  static const String name = 'CharactersListViewRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CharactersListViewRouteArgs>();
      return CharactersListViewScreen(
        key: args.key,
        characters: args.characters,
        searchQuery: args.searchQuery,
        isLoading: args.isLoading,
        scrollController: args.scrollController,
      );
    },
  );
}

class CharactersListViewRouteArgs {
  const CharactersListViewRouteArgs({
    this.key,
    required this.characters,
    required this.searchQuery,
    required this.isLoading,
    required this.scrollController,
  });

  final Key? key;

  final List<_i9.CharactersEntity> characters;

  final String searchQuery;

  final bool isLoading;

  final ScrollController scrollController;

  @override
  String toString() {
    return 'CharactersListViewRouteArgs{key: $key, characters: $characters, searchQuery: $searchQuery, isLoading: $isLoading, scrollController: $scrollController}';
  }
}

/// generated route for
/// [_i3.CustomBottomNavigatorBarScreen]
class CustomBottomNavigatorBarRoute extends _i7.PageRouteInfo<void> {
  const CustomBottomNavigatorBarRoute({List<_i7.PageRouteInfo>? children})
    : super(CustomBottomNavigatorBarRoute.name, initialChildren: children);

  static const String name = 'CustomBottomNavigatorBarRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i3.CustomBottomNavigatorBarScreen();
    },
  );
}

/// generated route for
/// [_i4.EpisodesScreen]
class EpisodesRoute extends _i7.PageRouteInfo<void> {
  const EpisodesRoute({List<_i7.PageRouteInfo>? children})
    : super(EpisodesRoute.name, initialChildren: children);

  static const String name = 'EpisodesRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i4.EpisodesScreen();
    },
  );
}

/// generated route for
/// [_i5.FiltersScreen]
class FiltersRoute extends _i7.PageRouteInfo<FiltersRouteArgs> {
  FiltersRoute({
    _i8.Key? key,
    String? selectedStatus,
    String? selectedGender,
    List<_i7.PageRouteInfo>? children,
  }) : super(
         FiltersRoute.name,
         args: FiltersRouteArgs(
           key: key,
           selectedStatus: selectedStatus,
           selectedGender: selectedGender,
         ),
         initialChildren: children,
       );

  static const String name = 'FiltersRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FiltersRouteArgs>(
        orElse: () => const FiltersRouteArgs(),
      );
      return _i5.FiltersScreen(
        key: args.key,
        selectedStatus: args.selectedStatus,
        selectedGender: args.selectedGender,
      );
    },
  );
}

class FiltersRouteArgs {
  const FiltersRouteArgs({this.key, this.selectedStatus, this.selectedGender});

  final _i8.Key? key;

  final String? selectedStatus;

  final String? selectedGender;

  @override
  String toString() {
    return 'FiltersRouteArgs{key: $key, selectedStatus: $selectedStatus, selectedGender: $selectedGender}';
  }
}

/// generated route for
/// [_i6.HomeScreen]
class HomeRoute extends _i7.PageRouteInfo<void> {
  const HomeRoute({List<_i7.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i6.HomeScreen();
    },
  );
}
