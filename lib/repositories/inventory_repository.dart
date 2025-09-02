import '../core/network/network_client.dart';
import '../models/inventory/inventory.dart';
import '../models/inventory/inventory_pagination.dart';

class InventoryRepository {
  final NetworkClient _networkClient;

  InventoryRepository({NetworkClient? networkClient})
      : _networkClient = networkClient ?? NetworkClient.instance;

  Future<(List<Inventory>, InventoryPagination)> getInventoryItems({
    int page = 1,
    int limit = 10,
    String sortBy = 'createdAt',
    String order = 'desc',
  }) async {
    try {
      final response = await _networkClient.get(
        '/v1/inventory',
        queryParams: {
          'page': page.toString(),
          'limit': limit.toString(),
          'sortBy': sortBy,
          'order': order,
        },
      );

      if (response.isSuccess && response.data != null) {
        final data = response.data['data'];
        final items = (data['items'] as List)
            .map((item) => Inventory.fromJson(item))
            .toList();
        final pagination = InventoryPagination.fromJson(data['pagination']);
        return (items, pagination);
      }

      throw Exception(response.errorMessage.isNotEmpty
          ? response.errorMessage
          : 'Failed to fetch inventory');
    } catch (e) {
      throw Exception('Failed to fetch inventory: $e');
    }
  }
}
