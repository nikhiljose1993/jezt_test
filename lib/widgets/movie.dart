import 'package:flutter/material.dart';
import 'package:test/model/movie_data_modal.dart';

class MovieWidget extends StatelessWidget {
  const MovieWidget(this.movie, {super.key});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = TextStyle(
      color: theme.colorScheme.onSecondary,
      overflow: TextOverflow.ellipsis,
    );
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.onTertiaryContainer.withOpacity(0.6),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.only(top: 8),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(2),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: AspectRatio(
                  aspectRatio: 9 / 14,
                  child: Image.network(
                    movie.poster,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    semanticLabel: movie.title,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(movie.title, style: textStyle),
          Text('(${movie.year})', style: textStyle),
        ],
      ),
    );
  }
}
