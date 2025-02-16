// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InventoryImpl _$$InventoryImplFromJson(Map<String, dynamic> json) =>
    _$InventoryImpl(
      id: json['id'] as String,
      assetLocation: json['assetLocation'] as String,
      mainCatCode: json['mainCatCode'] as String,
      mainCatDesc: json['mainCatDesc'] as String,
      mainDesc: json['mainDesc'] as String,
      subCatCode: json['subCatCode'] as String,
      subCatDesc: json['subCatDesc'] as String,
      assetCategory: json['assetCategory'] as String,
      image: json['image'] as String,
      quantity: (json['quantity'] as num).toInt(),
      serial: json['serial'] as String,
      employeeId: json['employeeId'] as String,
      extNumber: json['extNumber'] as String,
      faNumber: json['faNumber'] as String,
      type: json['type'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$InventoryImplToJson(_$InventoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'assetLocation': instance.assetLocation,
      'mainCatCode': instance.mainCatCode,
      'mainCatDesc': instance.mainCatDesc,
      'mainDesc': instance.mainDesc,
      'subCatCode': instance.subCatCode,
      'subCatDesc': instance.subCatDesc,
      'assetCategory': instance.assetCategory,
      'image': instance.image,
      'quantity': instance.quantity,
      'serial': instance.serial,
      'employeeId': instance.employeeId,
      'extNumber': instance.extNumber,
      'faNumber': instance.faNumber,
      'type': instance.type,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
