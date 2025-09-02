import 'package:data_table_2/data_table_2.dart';
import 'package:fats_amex_nartec/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomDataTable<T> extends StatelessWidget {
  final List<DataColumn2> columns;
  final List<T> data;
  final DataRow2 Function(T item) buildRow;
  final void Function(int, bool)? onSort;
  final int? sortColumnIndex;
  final bool? sortAscending;
  final int? rowsPerPage;
  final double minWidth;

  const CustomDataTable({
    super.key,
    required this.columns,
    required this.data,
    required this.buildRow,
    this.onSort,
    this.sortColumnIndex,
    this.sortAscending,
    this.rowsPerPage = 10,
    this.minWidth = 800,
  });

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      columnSpacing: 12,
      horizontalMargin: 12,
      minWidth: minWidth,
      smRatio: 0.75,
      lmRatio: 1.5,
      sortColumnIndex: sortColumnIndex,
      sortAscending: sortAscending ?? true,
      columns: columns,
      rows: data.map(buildRow).toList(),
      border: TableBorder.all(
        color: AppColors.primaryBlue,
        width: 1,
      ),
    );
  }
}
