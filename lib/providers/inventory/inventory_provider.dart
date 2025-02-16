import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../repositories/inventory_repository.dart';
import 'inventory_state.dart';

final inventoryRepositoryProvider = Provider((ref) => InventoryRepository());

final inventoryProvider =
    StateNotifierProvider<InventoryNotifier, InventoryState>((ref) {
  return InventoryNotifier(ref.watch(inventoryRepositoryProvider));
});

class InventoryNotifier extends StateNotifier<InventoryState> {
  final InventoryRepository _repository;

  InventoryNotifier(this._repository) : super(const InventoryState.initial());

  Future<void> getInventoryItems({
    int page = 1,
    int limit = 10,
    String sortBy = 'createdAt',
    String order = 'desc',
  }) async {
    state = const InventoryState.loading();

    try {
      final (items, pagination) = await _repository.getInventoryItems(
        page: page,
        limit: limit,
        sortBy: sortBy,
        order: order,
      );
      state = InventoryState.success(items: items, pagination: pagination);
    } catch (e) {
      state = InventoryState.error(e.toString());
    }
  }
}
