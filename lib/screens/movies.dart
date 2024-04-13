import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:test/model/movie_data_modal.dart';
import 'package:test/providers/movies_provider.dart';
import 'package:test/widgets/movie.dart';
import 'package:test/widgets/movie_skelton.dart';

class MovieScreen extends ConsumerStatefulWidget {
  const MovieScreen({super.key});

  @override
  ConsumerState<MovieScreen> createState() {
    return _MovieScreenState();
  }
}

class _MovieScreenState extends ConsumerState<MovieScreen> {
  bool _isLoading = false;
  bool _notResult = false;
  TextEditingController _searchController = TextEditingController();

  Future<void> _fetchMovieData(String str) async {
    setState(() {
      _isLoading = true;
      _notResult = false;
    });
    final String response =
        await ref.read(movieProvider.notifier).fetchMovies(str);
    if (response == 'Success' || response == 'false') {
      setState(() {
        _isLoading = false;
      });
      if (response == 'false') {
        setState(() {
          _notResult = true;
        });
        print(_notResult);
      }
    }
  }

  @override
  void initState() {
    _fetchMovieData('man');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Movie> movies = ref.watch(movieProvider);
    final theme = Theme.of(context);

    return Flexible(
      child: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextFormField(
                      controller: _searchController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color: theme.colorScheme.onPrimaryContainer
                                  .withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: theme.colorScheme.tertiary,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        isDense: true,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search, size: 40),
                  color: theme.colorScheme.tertiary,
                  splashColor: theme.colorScheme.tertiaryContainer,
                  onPressed: () {
                    _fetchMovieData(_searchController.value.text.trim());
                    FocusScopeNode currentFocus = FocusScope.of(context);

                    if (!currentFocus.hasPrimaryFocus &&
                        currentFocus.focusedChild != null) {
                      currentFocus.focusedChild!.unfocus();
                    }
                  },
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
          Flexible(
            child: _notResult
                ? Center(
                    child: Text(
                      'No movies found...',
                      style: TextStyle(
                          color: theme.colorScheme.tertiary, fontSize: 20),
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.only(left: 8, right: 8),
                    child: _isLoading
                        ? Shimmer.fromColors(
                            baseColor: Colors.white,
                            highlightColor: Colors.transparent,
                            direction: ShimmerDirection.ltr,
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8.0,
                                mainAxisSpacing: 8.0,
                                childAspectRatio: 0.5,
                              ),
                              itemBuilder: (context, index) =>
                                  const MovieSkelton(),
                            ),
                          )
                        : GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8.0,
                              childAspectRatio: 0.6,
                            ),
                            itemCount: movies.length,
                            itemBuilder: (context, index) {
                              return MovieWidget(movies[index]);
                            },
                          ),
                  ),
          ),
        ],
      ),
    );
  }
}
