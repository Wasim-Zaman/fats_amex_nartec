import 'package:freezed_annotation/freezed_annotation.dart';

part 'inventory.freezed.dart';
part 'inventory.g.dart';

@freezed
class Inventory with _$Inventory {
  const factory Inventory({
    required String id,
    required String assetLocation,
    required String mainCatCode,
    required String mainCatDesc,
    required String mainDesc,
    required String subCatCode,
    required String subCatDesc,
    required String assetCategory,
    required String image,
    required int quantity,
    required String serial,
    required String employeeId,
    required String extNumber,
    required String faNumber,
    required String type,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Inventory;

  factory Inventory.fromJson(Map<String, dynamic> json) =>
      _$InventoryFromJson(json);
}
