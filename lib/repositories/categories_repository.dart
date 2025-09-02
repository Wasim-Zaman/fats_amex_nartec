import '../core/network/network_client.dart';
import '../models/category/category.dart';

class CategoriesRepository {
  final NetworkClient _networkClient;

  CategoriesRepository({NetworkClient? networkClient})
      : _networkClient = networkClient ?? NetworkClient.instance;

  Future<List<Category>> getCategories({
    int page = 1,
    int limit = 10,
    String search = '',
  }) async {
    try {
      final response = await _networkClient.get(
        '/v1/fats-category',
        queryParams: {
          'page': page.toString(),
          'limit': limit.toString(),
          'search': search,
        },
      );

      if (response.isSuccess && response.data != null) {
        final data = response.data['data']['categories'] as List;
        return data.map((e) => Category.fromJson(e)).toList();
      }

      throw Exception(response.errorMessage.isNotEmpty
          ? response.errorMessage
          : 'Failed to fetch categories');
    } catch (e) {
      throw Exception('Failed to fetch categories: $e');
    }
  }
}
