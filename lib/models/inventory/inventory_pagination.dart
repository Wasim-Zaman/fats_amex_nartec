import 'package:freezed_annotation/freezed_annotation.dart';

part 'inventory_pagination.freezed.dart';
part 'inventory_pagination.g.dart';

@freezed
class InventoryPagination with _$InventoryPagination {
  const factory InventoryPagination({
    required int total,
    required int page,
    required int totalPages,
    required bool hasMore,
  }) = _InventoryPagination;

  factory InventoryPagination.fromJson(Map<String, dynamic> json) =>
      _$InventoryPaginationFromJson(json);
}
