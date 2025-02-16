import 'package:fats_amex_nartec/models/inventory/inventory.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../providers/inventory/inventory_provider.dart';

class VerifiedAssetsScreen extends ConsumerStatefulWidget {
  const VerifiedAssetsScreen({super.key});

  @override
  ConsumerState<VerifiedAssetsScreen> createState() =>
      _VerifiedAssetsScreenState();
}

class _VerifiedAssetsScreenState extends ConsumerState<VerifiedAssetsScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch initial data after the widget tree is built
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ref.read(inventoryProvider.notifier).getInventoryItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    final inventoryState = ref.watch(inventoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verified Assets'),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(
                'Qty: ${inventoryState.maybeWhen(
                  success: (items, pagination) => pagination.total,
                  orElse: () => 0,
                )}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
        ],
      ),
      body: inventoryState.when(
        initial: () => const Center(child: Text('No data')),
        loading: () => const Center(child: CircularProgressIndicator()),
        success: (items, pagination) => Column(
          children: [
            Expanded(
              child: SfDataGrid(
                source: InventoryDataSource(items),
                allowSorting: true,
                allowFiltering: true,
                allowMultiColumnSorting: true,
                selectionMode: SelectionMode.multiple,
                navigationMode: GridNavigationMode.cell,
                columns: [
                  GridColumn(
                    columnName: 'assetLocation',
                    label: const Center(child: Text('Location')),
                    width: 200,
                  ),
                  GridColumn(
                    columnName: 'mainCatCode',
                    label: const Center(child: Text('Main Cat Code')),
                    width: 200,
                  ),
                  GridColumn(
                    columnName: 'mainCatDesc',
                    label: const Center(child: Text('Main Cat Desc')),
                    width: 200,
                  ),
                  GridColumn(
                    columnName: 'mainDesc',
                    label: const Center(child: Text('Main Desc')),
                    width: 200,
                  ),
                  GridColumn(
                    columnName: 'subCatCode',
                    label: const Center(child: Text('Sub Cat Code')),
                    width: 200,
                  ),
                  GridColumn(
                    columnName: 'subCatDesc',
                    label: const Center(child: Text('Sub Cat Desc')),
                    width: 200,
                  ),
                  GridColumn(
                    columnName: 'assetCategory',
                    label: const Center(child: Text('Asset Category')),
                    width: 200,
                  ),
                  GridColumn(
                    columnName: 'image',
                    label: const Center(child: Text('Image')),
                    width: 200,
                  ),
                  GridColumn(
                    columnName: 'quantity',
                    label: const Center(child: Text('Qty')),
                    width: 200,
                  ),
                  GridColumn(
                    columnName: 'serial',
                    label: const Center(child: Text('Serial')),
                    width: 100,
                  ),
                  GridColumn(
                    columnName: 'employeeId',
                    label: const Center(child: Text('Employee ID')),
                    width: 200,
                  ),
                  GridColumn(
                    columnName: 'extNumber',
                    label: const Center(child: Text('Ext Number')),
                    width: 200,
                  ),
                  GridColumn(
                    columnName: 'faNumber',
                    label: const Center(child: Text('FA Number')),
                    width: 200,
                  ),
                  GridColumn(
                    columnName: 'type',
                    label: const Center(child: Text('Type')),
                    width: 200,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Handle preview/print tag action
                },
                child: const Text('Preview/Print Tag'),
              ),
            ),
          ],
        ),
        error: (message) => Center(child: Text('Error: $message')),
      ),
    );
  }
}

class InventoryDataSource extends DataGridSource {
  InventoryDataSource(List<Inventory> inventoryItems) {
    dataGridRows = inventoryItems.map<DataGridRow>((item) {
      return DataGridRow(cells: [
        DataGridCell(columnName: 'assetLocation', value: item.assetLocation),
        DataGridCell(columnName: 'mainCatCode', value: item.mainCatCode),
        DataGridCell(columnName: 'mainCatDesc', value: item.mainCatDesc),
        DataGridCell(columnName: 'mainDesc', value: item.mainDesc),
        DataGridCell(columnName: 'subCatCode', value: item.subCatCode),
        DataGridCell(columnName: 'subCatDesc', value: item.subCatDesc),
        DataGridCell(columnName: 'assetCategory', value: item.assetCategory),
        DataGridCell(columnName: 'image', value: item.image),
        DataGridCell(columnName: 'quantity', value: item.quantity),
        DataGridCell(columnName: 'serial', value: item.serial),
        DataGridCell(columnName: 'employeeId', value: item.employeeId),
        DataGridCell(columnName: 'extNumber', value: item.extNumber),
        DataGridCell(columnName: 'faNumber', value: item.faNumber),
        DataGridCell(columnName: 'type', value: item.type),
      ]);
    }).toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((cell) {
        if (cell.columnName == 'image') {
          return Container(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              cell.value.toString(),
              width: 40,
              height: 40,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.image_not_supported);
              },
            ),
          );
        }
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: Text(
            cell.value.toString(),
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
    );
  }
}
