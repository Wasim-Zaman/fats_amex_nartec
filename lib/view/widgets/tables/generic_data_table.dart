import 'dart:async';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../search/custom_search_bar.dart';

class GenericDataTable<T> extends StatefulWidget {
  final List<T> data;
  final List<DataColumn2> columns;
  final DataRow2 Function(T item) buildRow;
  final Future<void> Function(String)? onSearch;
  final String title;
  final bool isLoading;
  final Widget? headerAction;
  final String searchHint;
  final VoidCallback? onRefresh;
  final int? rowsPerPage;
  final double minWidth;

  const GenericDataTable({
    super.key,
    required this.data,
    required this.columns,
    required this.buildRow,
    required this.title,
    this.onSearch,
    this.isLoading = false,
    this.headerAction,
    this.searchHint = 'Search...',
    this.onRefresh,
    this.rowsPerPage = 10,
    this.minWidth = 800,
  });

  @override
  State<GenericDataTable<T>> createState() => _GenericDataTableState<T>();
}

class _GenericDataTableState<T> extends State<GenericDataTable<T>> {
  final ScrollController _horizontalScrollController = ScrollController();
  Timer? _debounceTimer;

  void _onSearch(String value) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      widget.onSearch?.call(value);
    });
  }

  @override
  void dispose() {
    _horizontalScrollController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Card(
        margin: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header with search and actions
              Row(
                children: [
                  if (widget.onSearch != null)
                    Expanded(
                      child: CustomSearchBar(
                        hintText: widget.searchHint,
                        onChanged: _onSearch,
                      ),
                    ),
                  if (widget.headerAction != null) ...[
                    const SizedBox(width: 16),
                    widget.headerAction!,
                  ],
                  if (widget.onRefresh != null) ...[
                    const SizedBox(width: 16),
                    IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: widget.onRefresh,
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 16),

              // Data table
              Expanded(
                child: widget.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        controller: _horizontalScrollController,
                        scrollDirection: Axis.horizontal,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: widget.minWidth,
                            maxWidth: MediaQuery.of(context).size.width - 64,
                          ),
                          child: DataTable2(
                            columnSpacing: 12,
                            horizontalMargin: 12,
                            minWidth: widget.minWidth,
                            smRatio: 0.75,
                            lmRatio: 1.5,
                            columns: widget.columns,
                            rows: widget.data.map(widget.buildRow).toList(),
                            border: TableBorder.all(
                              color: AppColors.primaryBlue,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
              ),

              // Footer with total items count
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  'Total ${widget.data.length} items',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
