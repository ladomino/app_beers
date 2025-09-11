import 'package:app_beers/providers/beers_provider.dart';
import 'package:app_beers/providers/search_provider.dart';
import 'package:app_beers/shared/app_router.dart';
import 'package:app_beers/ui/pages/beers_card_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BeersListPage extends ConsumerStatefulWidget {
  const BeersListPage({super.key});

  @override
  ConsumerState<BeersListPage> createState() => _BeersListPageState();
}

class _BeersListPageState extends ConsumerState<BeersListPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      // Load more when user is 200 pixels from the bottom
      ref.read(beersProvider.notifier).loadMoreBeers();
    }
  }

  @override
  Widget build(BuildContext context) {
    final beersState = ref.watch(beersProvider);
    final filteredBeers = ref.watch(filteredBeersProvider);

    // Show error state
    if (beersState.error != null && beersState.beers.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Error loading beers',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              beersState.error!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.read(beersProvider.notifier).loadBeers();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    // Show loading state for initial load
    if (beersState.beers.isEmpty && beersState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // Show empty state
    if (beersState.beers.isEmpty && !beersState.isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.sentiment_dissatisfied,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            const Text('No beers available', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref.read(beersProvider.notifier).refresh(),
              child: const Text('Try Again'),
            ),
          ],
        ),
      );
    }

    // Calculate if we should show the loading indicator
    // Only show it if we have more jokes available AND we're not currently filtering
    final shouldShowLoadingIndicator = beersState.hasMore && 
                                    filteredBeers.length == beersState.beers.length;


    // Show list with data
    return RefreshIndicator(
      onRefresh: () => ref.read(beersProvider.notifier).refresh(),
      child: ListView.builder(
        controller: _scrollController,
        itemCount: filteredBeers.length + (shouldShowLoadingIndicator ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= filteredBeers.length) {
            // Show loading indicator at the bottom
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final beer = filteredBeers[index];
          return BeerListCard(
            beer: beer,
            onTap: () {
              AppRouter.goToBeerDetail(context, beer);

              // ScaffoldMessenger.of(
              //   context,
              // ).showSnackBar(SnackBar(content: Text('Tapped on ${beer.name}')));
            },
          );
        },
      ),
    );
  }
}
