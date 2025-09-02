import 'package:fats_amex_nartec/core/utils/date_format.dart';
import 'package:fats_amex_nartec/models/category/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/categories_provider.dart';

class CategoriesScreen extends ConsumerStatefulWidget {
  const CategoriesScreen({super.key});

  @override
  ConsumerState<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends ConsumerState<CategoriesScreen> {
  final _searchController = TextEditingController();
  static const _pageSize = 10;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(categoriesProvider.notifier).fetchCategories(
            page: 1,
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
              ],
            ),
            Expanded(
              child: categoriesState.when(
                data: (categories) => CategoriesDataTable(
                  categories: categories,
                  onPageChanged: (page) {
                    ref.read(categoriesProvider.notifier).fetchCategories(
                          page: page + 1,
                          limit: _pageSize,
                          search: _searchController.text,
                        );
                  },
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, stack) => Center(
                  child: Text('Error: $error'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoriesDataTable extends StatelessWidget {
  final List<Category> categories;
  final Function(int) onPageChanged;

  const CategoriesDataTable({
    super.key,
    required this.categories,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable(
      source: CategoriesDataSource(categories),
      header: Text('Categories (${categories.length})'),
      columns: const [
        DataColumn(label: Text('MAIN CATEGORY CODE')),
        DataColumn(label: Text('MAIN CATEGORY DESCRIPTION')),
        DataColumn(label: Text('MAIN DESCRIPTION')),
        DataColumn(label: Text('SUB CATEGORY CODE')),
        DataColumn(label: Text('SUB CATEGORY DESCRIPTION')),
        DataColumn(label: Text('COUNTER')),
        DataColumn(label: Text('CREATED AT')),
        DataColumn(label: Text('UPDATED AT')),
      ],
      onPageChanged: onPageChanged,
      rowsPerPage: 10,
    );
  }
}

class CategoriesDataSource extends DataTableSource {
  final List<Category> _categories;

  CategoriesDataSource(this._categories);

  @override
  DataRow getRow(int index) {
    final category = _categories[index];
    return DataRow(
      cells: [
        DataCell(Text(category.mainCatCode)),
        DataCell(Text(category.mainCategoryDesc)),
        DataCell(Text(category.mainDescription)),
        DataCell(Text(category.subCategoryCode)),
        DataCell(Text(category.subCategoryDesc)),
        DataCell(Text(category.counter.toString())),
        DataCell(Text(dateFormat(category.createdAt))),
        DataCell(Text(dateFormat(category.updatedAt))),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _categories.length;

  @override
  int get selectedRowCount => 0;
}
