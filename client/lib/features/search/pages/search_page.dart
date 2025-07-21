import 'package:client/cor/theme/app_pallete.dart';
import 'package:client/features/search/widgets/search_app_bar.dart';
import 'package:client/features/search/widgets/search_empty_state.dart';
import 'package:client/features/search/widgets/search_results.dart';
import 'package:client/features/search/widgets/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query.trim();
      _isSearching = query.trim().isNotEmpty;
    });
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _searchQuery = '';
      _isSearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.backgroundColor,
      appBar: const SearchAppBar(),
      body: Column(
        children: [
          //search input
          SearchTextField(
            controller: _searchController,
            searchQuery: _searchQuery,
            isSearching: _isSearching,
            onSeachChanged: _onSearchChanged,
            onClear: _clearSearch,
          ),
          //search Result
          Expanded(
            child: _searchQuery.isEmpty
                ? const SearchEmptyState()
                : SearchResults(searchQuery: _searchQuery),
          )
        ],
      ),
    );
  }
}
