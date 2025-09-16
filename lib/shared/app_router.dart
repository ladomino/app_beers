import 'package:app_beers/data_classes/beers.dart';
import 'package:app_beers/main.dart';
import 'package:app_beers/ui/pages/beer_detail_page.dart';
import 'package:app_beers/ui/pages/beer_favorites_page.dart';
import 'package:app_beers/ui/pages/beers_list_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static const String home = '/';
  static const String favorites = '/favorites';
  static const String beerDetail = '/beer/:id';

  static final GoRouter router = 
  GoRouter(
    initialLocation: home,
    routes: [
     ShellRoute(
        builder: (context, state, child) => MyHomePage(child: child),
        routes: [
          GoRoute(
            path: home,
            name: 'home',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: BeersListPage(),
            ),
          ),
          GoRoute(
            path: favorites,
            name: 'favorites',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: FavoritesPage(),
            ),
          ),
        ],
      ),
      GoRoute(
        path: beerDetail,
        name: 'beer-detail',
        builder: (context, state) {
          final beerIdString = state.pathParameters['id']!;
          final beerId = int.parse(beerIdString);
          final beer = state.extra as Beer?;

          return BeerDetailPage(beerId: beerId, beer: beer);
        },
      ),
    ],
    
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Page not found: ${state.matchedLocation}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(home),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );

  // Helper methods for Details page - push
  static void goToBeerDetail(BuildContext context, Beer beer) {
    context.push('/beer/${beer.id}', extra: beer);
  }

  // Helper methods for navigation bar actions
  static void goToHome(BuildContext context) {
    context.go(home);
  }

  static void goToFavorites(BuildContext context) {
    print('Go to favorites page');
    context.go(favorites);
  }

}
