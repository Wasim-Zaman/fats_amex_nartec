import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/utils/snack_util.dart';
import '../../../../../widgets/tables/custom_data_table.dart';
import '../../../../../widgets/tables/data_table_container.dart';

class AssetsLocationsScreen extends ConsumerStatefulWidget {
  const AssetsLocationsScreen({super.key});

  @override
  ConsumerState<AssetsLocationsScreen> createState() =>
      _AssetsLocationsScreenState();
}

class _AssetsLocationsScreenState extends ConsumerState<AssetsLocationsScreen> {
  bool _sortAscending = true;
  int _sortColumnIndex = 0;
  String _searchQuery = '';

  // Sample data - Replace with your actual data model and provider
  final List<Map<String, String>> _locations = [
    {
      'company': 'AMEX',
      'building': 'HO',
      'level': 'RF',
      'office': '00',
      'room': '00',
      'locationCode': 'AMEX-HO-RF-00-00',
    },
    {
      'company': 'AMEX',
      'building': 'HO',
      'level': '3F',
      'office': '01',
      'room': '00',
      'locationCode': 'AMEX-HO-3F-01-00',
    },
    // Add more sample data as needed
  ];

  List<Map<String, String>> get _filteredLocations {
    if (_searchQuery.isEmpty) return _locations;
    return _locations.where((location) {
      return location.values.any(
          (value) => value.toLowerCase().contains(_searchQuery.toLowerCase()));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Asset Locations'),
      ),
      body: SafeArea(
        child: DataTableContainer(
          title: 'Asset Locations',
          searchHint: 'Search locations...',
          onSearch: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
          onRefresh: () {
            SnackUtil.showSuccess(context, 'Refreshing data...');
            // TODO: Implement refresh functionality
          },
          child: CustomDataTable<Map<String, String>>(
            columns: _buildColumns(),
            data: _filteredLocations,
            buildRow: _buildRow,
            sortColumnIndex: _sortColumnIndex,
            sortAscending: _sortAscending,
            onSort: _sort,
          ),
        ),
      ),
    );
  }

  List<DataColumn2> _buildColumns() {
    return [
      DataColumn2(
        label: const Text('Company'),
        size: ColumnSize.S,
        onSort: (columnIndex, ascending) => _sort(columnIndex, ascending),
      ),
      DataColumn2(
        label: const Text('Building'),
        size: ColumnSize.S,
        onSort: (columnIndex, ascending) => _sort(columnIndex, ascending),
      ),
      DataColumn2(
        label: const Text('Level'),
        size: ColumnSize.S,
        onSort: (columnIndex, ascending) => _sort(columnIndex, ascending),
      ),
      DataColumn2(
        label: const Text('Office'),
        size: ColumnSize.S,
        onSort: (columnIndex, ascending) => _sort(columnIndex, ascending),
      ),
      DataColumn2(
        label: const Text('Room'),
        size: ColumnSize.S,
        onSort: (columnIndex, ascending) => _sort(columnIndex, ascending),
      ),
      DataColumn2(
        label: const Text('Location Code'),
        size: ColumnSize.L,
        onSort: (columnIndex, ascending) => _sort(columnIndex, ascending),
      ),
      const DataColumn2(
        label: Text('Actions'),
        size: ColumnSize.S,
        numeric: true,
      ),
    ];
  }

  DataRow2 _buildRow(Map<String, String> location) {
    return DataRow2(
      cells: [
        DataCell(Text(location['company'] ?? '')),
        DataCell(Text(location['building'] ?? '')),
        DataCell(Text(location['level'] ?? '')),
        DataCell(Text(location['office'] ?? '')),
        DataCell(Text(location['room'] ?? '')),
        DataCell(Text(location['locationCode'] ?? '')),
        DataCell(_buildActions(location)),
      ],
    );
  }

  Widget _buildActions(Map<String, String> location) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: IconButton(
            icon: const Icon(Icons.edit, size: 20),
            onPressed: () {
              // TODO: Implement edit functionality
              SnackUtil.showSuccess(
                  context, 'Editing ${location['locationCode']}...');
            },
          ),
        ),
        Expanded(
          child: IconButton(
            icon: const Icon(Icons.delete, size: 20),
            onPressed: () {
              // TODO: Implement delete functionality
              SnackUtil.showError(
                  context, 'Delete ${location['locationCode']}?');
            },
          ),
        ),
      ],
    );
  }

  void _sort(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;

      _locations.sort((a, b) {
        final aValue = a.values.elementAt(columnIndex);
        final bValue = b.values.elementAt(columnIndex);
        return ascending ? aValue.compareTo(bValue) : bValue.compareTo(aValue);
      });
    });
  }
}
