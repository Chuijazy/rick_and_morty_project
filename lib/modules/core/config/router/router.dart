import 'package:auto_route/auto_route.dart';
import 'package:rick_and_morty_project/modules/core/config/router/router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, initial: true),
    AutoRoute(page: CharactersListRoute.page),
    AutoRoute(page: CharactersInfoRoute.page),
    AutoRoute(page: CustomBottomNavigatorBarRoute.page),
    AutoRoute(page: FiltersRoute.page),
    AutoRoute(page: CharactersListViewRoute.page),
  ];
}
