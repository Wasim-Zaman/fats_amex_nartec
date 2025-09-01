import 'dart:async';

import 'package:flutter/material.dart';

class CustomPaginatedTable<T> extends StatefulWidget {
  final List<T> items;
  final List<String> columnTitles;
  final List<Widget> Function(T item, void Function() onRefresh) rowBuilder;
  final Future<void> Function(String search) onSearch;
  final int totalItems;
  final bool isLoading;
  final String title;
  final String? searchHint;
  final Widget? headerAction;

  const CustomPaginatedTable({
    super.key,
    required this.items,
    required this.columnTitles,
    required this.rowBuilder,
    required this.onSearch,
    required this.totalItems,
    required this.title,
    this.isLoading = false,
    this.searchHint,
    this.headerAction,
  });

  @override
  State<CustomPaginatedTable<T>> createState() =>
      _CustomPaginatedTableState<T>();
}

class _CustomPaginatedTableState<T> extends State<CustomPaginatedTable<T>> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounceTimer;
  final ScrollController _horizontalScrollController = ScrollController();

  @override
  void dispose() {
    _searchController.dispose();
    _debounceTimer?.cancel();
    _horizontalScrollController.dispose();
    super.dispose();
  }

  void _onSearch(String value) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      widget.onSearch(value);
    });
  }

  void _refreshTable() {
    widget.onSearch(_searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       widget.title,
            //       style: Theme.of(context).textTheme.titleLarge?.copyWith(
            //             color: Colors.blue,
            //             fontWeight: FontWeight.bold,
            //           ),
            //     ),
            //     Row(
            //       children: [
            //         if (widget.searchHint != null)
            //           SizedBox(
            //             width: 200,
            //             child: TextField(
            //               controller: _searchController,
            //               decoration: InputDecoration(
            //                 hintText: widget.searchHint,
            //                 prefixIcon: const Icon(Icons.search),
            //                 border: OutlineInputBorder(
            //                   borderRadius: BorderRadius.circular(8),
            //                 ),
            //                 contentPadding: const EdgeInsets.symmetric(
            //                   horizontal: 16,
            //                   vertical: 8,
            //                 ),
            //               ),
            //               onChanged: _onSearch,
            //             ),
            //           ),
            //         if (widget.headerAction != null) ...[
            //           const SizedBox(width: 16),
            //           widget.headerAction!,
            //         ],
            //       ],
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 16),

            // Table
            Expanded(
              child: widget.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      controller: _horizontalScrollController,
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        headingRowColor:
                            WidgetStateProperty.all(Colors.grey.shade100),
                        columns: widget.columnTitles
                            .map((title) => DataColumn(
                                  label: Text(
                                    title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ))
                            .toList(),
                        rows: widget.items
                            .map(
                              (item) => DataRow(
                                cells: widget
                                    .rowBuilder(item, _refreshTable)
                                    .map((cell) => DataCell(cell))
                                    .toList(),
                              ),
                            )
                            .toList(),
                      ),
                    ),
            ),

            // Footer
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                'Total ${widget.totalItems} items',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TableColumn {
  final String label;
  final double? width;
  final bool? sortable;
  final TextAlign? align;

  const TableColumn({
    required this.label,
    this.width,
    this.sortable,
    this.align,
  });
}
