import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../models/category/category.dart';
import '../../../../../repositories/categories_repository.dart';

final categoriesProvider =
    StateNotifierProvider<CategoriesNotifier, AsyncValue<List<Category>>>(
        (ref) {
  return CategoriesNotifier();
});

class CategoriesNotifier extends StateNotifier<AsyncValue<List<Category>>> {
  final CategoriesRepository _categoriesRepository;

  CategoriesNotifier({CategoriesRepository? categoriesRepository})
      : _categoriesRepository = categoriesRepository ?? CategoriesRepository(),
        super(const AsyncValue.loading());

  Future<void> fetchCategories({
    int page = 1,
    int limit = 10,
    String search = '',
  }) async {
    try {
      state = const AsyncValue.loading();

      final categories = await _categoriesRepository.getCategories(
        page: page,
        limit: limit,
        search: search,
      );

      state = AsyncValue.data(categories);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
