import '../core/services/http_service.dart';
import '../models/inventory/inventory.dart';
import '../models/inventory/inventory_pagination.dart';

class InventoryRepository {
  final HttpService _httpService;

  InventoryRepository({HttpService? httpService})
      : _httpService = httpService ?? HttpService();

  Future<(List<Inventory>, InventoryPagination)> getInventoryItems({
    int page = 1,
    int limit = 10,
    String sortBy = 'createdAt',
    String order = 'desc',
  }) async {
    try {
      final response = await _httpService.request(
        '/v1/inventory',
        method: HttpMethod.get,
        // queryParameters: {
        //   'page': page,
        //   'limit': limit,
        //   'sortBy': sortBy,
        //   'order': order,
        // },
      );

      if (response.statusCode == 200) {
        final data = response.data['data'];
        final items = (data['items'] as List)
            .map((item) => Inventory.fromJson(item))
            .toList();
        final pagination = InventoryPagination.fromJson(data['pagination']);
        return (items, pagination);
      }

      throw Exception(response.data['message'] ?? 'Failed to fetch inventory');
    } catch (e) {
      throw Exception('Failed to fetch inventory: $e');
    }
  }
}
