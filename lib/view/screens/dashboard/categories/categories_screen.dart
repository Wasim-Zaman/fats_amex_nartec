import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/categories/categories_provider.dart';

class CategoriesScreen extends ConsumerStatefulWidget {
  const CategoriesScreen({super.key});

  @override
  ConsumerState<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends ConsumerState<CategoriesScreen> {
  final _searchController = TextEditingController();
  int _currentPage = 1;
  static const _pageSize = 10;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(categoriesProvider.notifier).fetchCategories(
            page: _currentPage,
            limit: _pageSize,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final categoriesState = ref.watch(categoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories Management'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              spacing: 8.0,
              children: [
                Flexible(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search categories...',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      ref.read(categoriesProvider.notifier).fetchCategories(
                            search: value,
                            page: 1,
                            limit: _pageSize,
                          );
                    },
                  ),
                ),
                // Flexible(
                //   child: ElevatedButton(
                //     onPressed: () {
                //       // TODO: Implement add category
                //     },
                //     child: const Text('Add Category'),
                //   ),
                // ),
              ],
            ),
            Expanded(
              child: categoriesState.when(
                data: (categories) => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('MAIN CATEGORY CODE')),
                        DataColumn(label: Text('MAIN CATEGORY DESCRIPTION')),
                        DataColumn(label: Text('MAIN DESCRIPTION')),
                        DataColumn(label: Text('SUB CATEGORY CODE')),
                        DataColumn(label: Text('SUB CATEGORY DESCRIPTION')),
                        DataColumn(label: Text('COUNTER')),
                        DataColumn(label: Text('ACTIONS')),
                      ],
                      rows: categories.map((category) {
                        return DataRow(
                          cells: [
                            DataCell(Text(category.mainCatCode)),
                            DataCell(Text(category.mainCategoryDesc)),
                            DataCell(Text(category.mainDescription)),
                            DataCell(Text(category.subCategoryCode)),
                            DataCell(Text(category.subCategoryDesc)),
                            DataCell(Text(category.counter.toString())),
                            DataCell(Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    // TODO: Implement edit
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  color: Colors.red,
                                  onPressed: () {
                                    // TODO: Implement delete
                                  },
                                ),
                              ],
                            )),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, stack) => Center(
                  child: Text('Error: $error'),
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total ${categoriesState.whenOrNull(
                          data: (categories) => categories.length,
                        ) ?? 0} categories',
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.chevron_left),
                        onPressed: _currentPage > 1
                            ? () {
                                setState(() {
                                  _currentPage--;
                                });
                                _fetchCategories();
                              }
                            : null,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          _currentPage.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.chevron_right),
                        onPressed: categoriesState.whenOrNull(
                                  data: (categories) =>
                                      categories.length >= _pageSize,
                                ) ??
                                false
                            ? () {
                                setState(() {
                                  _currentPage++;
                                });
                                _fetchCategories();
                              }
                            : null,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _fetchCategories() {
    ref.read(categoriesProvider.notifier).fetchCategories(
          page: _currentPage,
          limit: _pageSize,
        );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
