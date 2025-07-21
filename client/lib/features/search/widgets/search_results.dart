import 'package:client/cor/widgets/loader.dart';
import 'package:client/features/home/viewmodel/home_viewmodel.dart';
import 'package:client/features/search/widgets/search_error_state.dart';
import 'package:client/features/search/widgets/search_no_results.dart';
import 'package:client/features/search/widgets/song_search_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchResults extends ConsumerWidget {
  final String searchQuery;
  const SearchResults({
    super.key,
    required this.searchQuery,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getSearchSongsProvider(searchQuery)).when(
        data: (songs) {
          if(songs.isEmpty){
            return const SearchNoResults();
          }
          return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: songs.length,
              itemBuilder: (context,index) {
                final song = songs[index];
                return SongSearchTile(song: song);
              }
          );
        },
        error: (error, stackTrace) => SearchErrorState(error: error.toString()),
        loading: () => const Loader());
  }
}
