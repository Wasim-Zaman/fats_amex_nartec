import 'package:fats_amex_nartec/models/inventory/inventory_pagination.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/inventory/inventory.dart';

part 'inventory_state.freezed.dart';

@freezed
class InventoryState with _$InventoryState {
  const factory InventoryState.initial() = _Initial;
  const factory InventoryState.loading() = _Loading;
  const factory InventoryState.success({
    required List<Inventory> items,
    required InventoryPagination pagination,
  }) = _Success;
  const factory InventoryState.error(String message) = _Error;
}
