// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CategoryImpl _$$CategoryImplFromJson(Map<String, dynamic> json) =>
    _$CategoryImpl(
      id: json['id'] as String,
      mainCatCode: json['mainCatCode'] as String,
      mainCategoryDesc: json['mainCategoryDesc'] as String,
      mainDescription: json['mainDescription'] as String,
      subCategoryCode: json['subCategoryCode'] as String,
      subCategoryDesc: json['subCategoryDesc'] as String,
      counter: (json['counter'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$CategoryImplToJson(_$CategoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mainCatCode': instance.mainCatCode,
      'mainCategoryDesc': instance.mainCategoryDesc,
      'mainDescription': instance.mainDescription,
      'subCategoryCode': instance.subCategoryCode,
      'subCategoryDesc': instance.subCategoryDesc,
      'counter': instance.counter,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
