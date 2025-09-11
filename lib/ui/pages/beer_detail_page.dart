import 'package:app_beers/api/beers_api.dart';
import 'package:app_beers/data_classes/beers.dart';
import 'package:app_beers/shared/app_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BeerDetailPage extends ConsumerWidget {
  final int beerId;
  final Beer? beer;

  const BeerDetailPage({super.key, required this.beerId, this.beer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageUrl = BeerApi.getImageUrl(beerId);

    return Scaffold(
      appBar: AppBar(
        title: Text(beer?.name ?? 'Beer Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => AppRouter.goToHome(context), // Use router instead of pop
        ),
      ),
      body: beer == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Beer Image
                  Center(
                    child: Container(
                      width: 200,
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amber.withValues(alpha: 0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.amber.shade100,
                            child: const Icon(
                              Icons.sports_bar,
                              size: 64,
                              color: Colors.amber,
                            ),
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Beer Name
                  Text(
                    beer!.name,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.brown.shade800,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Tagline
                  Text(
                    beer!.tagline,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: Colors.orange.shade700,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // First Brewed
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.brown.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 16,
                          color: Colors.brown.shade700,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'First Brewed: ${beer!.firstBrewed}',
                          style: TextStyle(
                            color: Colors.brown.shade700,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Description
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.brown.shade800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    beer!.description,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      height: 1.6,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
