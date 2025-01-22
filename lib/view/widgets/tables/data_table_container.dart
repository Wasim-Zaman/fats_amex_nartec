import 'package:flutter/material.dart';

import '../search/custom_search_bar.dart';

class DataTableContainer extends StatelessWidget {
  final Widget child;
  final String searchHint;
  final ValueChanged<String>? onSearch;
  final VoidCallback? onRefresh;
  final String title;

  const DataTableContainer({
    super.key,
    required this.child,
    required this.title,
    this.searchHint = 'Search...',
    this.onSearch,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomSearchBar(
                    hintText: searchHint,
                    onChanged: onSearch,
                  ),
                ),
                if (onRefresh != null) ...[
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: onRefresh,
                  ),
                ],
              ],
            ),
            const SizedBox(height: 16),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
