import 'package:fats_amex_nartec/core/services/http_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/category/category.dart';

final categoriesProvider =
    StateNotifierProvider<CategoriesNotifier, AsyncValue<List<Category>>>(
        (ref) {
  return CategoriesNotifier();
});

class CategoriesNotifier extends StateNotifier<AsyncValue<List<Category>>> {
  final HttpService _httpService = HttpService();
  CategoriesNotifier() : super(const AsyncValue.loading());

  Future<void> fetchCategories({
    int page = 1,
    int limit = 10,
    String search = '',
  }) async {
    try {
      state = const AsyncValue.loading();

      final queryParameters = {
        'page': page,
        'limit': limit,
        'search': search,
      };

      final url =
          '/v1/fats-category?${queryParameters.entries.map((e) => '${e.key}=${e.value}').join('&')}';

      final response = await _httpService.request(
        url,
        method: HttpMethod.get,
      );
      final data = response.data['data']['categories'] as List;
      final categories = data.map((e) => Category.fromJson(e)).toList();
      state = AsyncValue.data(categories);
    } on HttpException catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
