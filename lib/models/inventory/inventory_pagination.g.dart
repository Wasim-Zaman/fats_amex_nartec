// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InventoryPaginationImpl _$$InventoryPaginationImplFromJson(
        Map<String, dynamic> json) =>
    _$InventoryPaginationImpl(
      total: (json['total'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      hasMore: json['hasMore'] as bool,
    );

Map<String, dynamic> _$$InventoryPaginationImplToJson(
        _$InventoryPaginationImpl instance) =>
    <String, dynamic>{
      'total': instance.total,
      'page': instance.page,
      'totalPages': instance.totalPages,
      'hasMore': instance.hasMore,
    };
