import 'package:app_beers/api/beers_api.dart';
import 'package:app_beers/data_classes/beers.dart';
import 'package:app_beers/shared/app_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BeerListCard extends StatelessWidget {
  final Beer beer;
  final VoidCallback? onTap;

  const BeerListCard({super.key, required this.beer, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      key: Key('Card_${beer.id}'),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.amber.shade50, Colors.orange.shade50],
          ),
        ),
        child: ListTile(
          key: Key('Tile_${beer.id}'),
          contentPadding: const EdgeInsets.all(16),
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.amber.shade600,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.amber.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              key: Key('Image_${beer.id}'),
              borderRadius: BorderRadius.circular(25),
              child: CachedNetworkImage(
              imageUrl: BeerApi.getImageUrl(beer.id),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
              width: 50,
              height: 50,
            ),
            ),
            
            //const Icon(Icons.sports_bar, color: Colors.white, size: 28),
          ),
          title: Text(
            beer.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.brown.shade800,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                beer.tagline,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.orange.shade700,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.brown.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'First Brewed: ${beer.firstBrewed}',
                  style: TextStyle(
                    color: Colors.brown.shade700,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                beer.description,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  color: Colors.grey.shade700,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
