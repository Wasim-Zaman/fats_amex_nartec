// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inventory.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Inventory _$InventoryFromJson(Map<String, dynamic> json) {
  return _Inventory.fromJson(json);
}

/// @nodoc
mixin _$Inventory {
  String get id => throw _privateConstructorUsedError;
  String get assetLocation => throw _privateConstructorUsedError;
  String get mainCatCode => throw _privateConstructorUsedError;
  String get mainCatDesc => throw _privateConstructorUsedError;
  String get mainDesc => throw _privateConstructorUsedError;
  String get subCatCode => throw _privateConstructorUsedError;
  String get subCatDesc => throw _privateConstructorUsedError;
  String get assetCategory => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  String get serial => throw _privateConstructorUsedError;
  String get employeeId => throw _privateConstructorUsedError;
  String get extNumber => throw _privateConstructorUsedError;
  String get faNumber => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Inventory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Inventory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InventoryCopyWith<Inventory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryCopyWith<$Res> {
  factory $InventoryCopyWith(Inventory value, $Res Function(Inventory) then) =
      _$InventoryCopyWithImpl<$Res, Inventory>;
  @useResult
  $Res call(
      {String id,
      String assetLocation,
      String mainCatCode,
      String mainCatDesc,
      String mainDesc,
      String subCatCode,
      String subCatDesc,
      String assetCategory,
      String image,
      int quantity,
      String serial,
      String employeeId,
      String extNumber,
      String faNumber,
      String type,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$InventoryCopyWithImpl<$Res, $Val extends Inventory>
    implements $InventoryCopyWith<$Res> {
  _$InventoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Inventory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? assetLocation = null,
    Object? mainCatCode = null,
    Object? mainCatDesc = null,
    Object? mainDesc = null,
    Object? subCatCode = null,
    Object? subCatDesc = null,
    Object? assetCategory = null,
    Object? image = null,
    Object? quantity = null,
    Object? serial = null,
    Object? employeeId = null,
    Object? extNumber = null,
    Object? faNumber = null,
    Object? type = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      assetLocation: null == assetLocation
          ? _value.assetLocation
          : assetLocation // ignore: cast_nullable_to_non_nullable
              as String,
      mainCatCode: null == mainCatCode
          ? _value.mainCatCode
          : mainCatCode // ignore: cast_nullable_to_non_nullable
              as String,
      mainCatDesc: null == mainCatDesc
          ? _value.mainCatDesc
          : mainCatDesc // ignore: cast_nullable_to_non_nullable
              as String,
      mainDesc: null == mainDesc
          ? _value.mainDesc
          : mainDesc // ignore: cast_nullable_to_non_nullable
              as String,
      subCatCode: null == subCatCode
          ? _value.subCatCode
          : subCatCode // ignore: cast_nullable_to_non_nullable
              as String,
      subCatDesc: null == subCatDesc
          ? _value.subCatDesc
          : subCatDesc // ignore: cast_nullable_to_non_nullable
              as String,
      assetCategory: null == assetCategory
          ? _value.assetCategory
          : assetCategory // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      serial: null == serial
          ? _value.serial
          : serial // ignore: cast_nullable_to_non_nullable
              as String,
      employeeId: null == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as String,
      extNumber: null == extNumber
          ? _value.extNumber
          : extNumber // ignore: cast_nullable_to_non_nullable
              as String,
      faNumber: null == faNumber
          ? _value.faNumber
          : faNumber // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InventoryImplCopyWith<$Res>
    implements $InventoryCopyWith<$Res> {
  factory _$$InventoryImplCopyWith(
          _$InventoryImpl value, $Res Function(_$InventoryImpl) then) =
      __$$InventoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String assetLocation,
      String mainCatCode,
      String mainCatDesc,
      String mainDesc,
      String subCatCode,
      String subCatDesc,
      String assetCategory,
      String image,
      int quantity,
      String serial,
      String employeeId,
      String extNumber,
      String faNumber,
      String type,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$InventoryImplCopyWithImpl<$Res>
    extends _$InventoryCopyWithImpl<$Res, _$InventoryImpl>
    implements _$$InventoryImplCopyWith<$Res> {
  __$$InventoryImplCopyWithImpl(
      _$InventoryImpl _value, $Res Function(_$InventoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of Inventory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? assetLocation = null,
    Object? mainCatCode = null,
    Object? mainCatDesc = null,
    Object? mainDesc = null,
    Object? subCatCode = null,
    Object? subCatDesc = null,
    Object? assetCategory = null,
    Object? image = null,
    Object? quantity = null,
    Object? serial = null,
    Object? employeeId = null,
    Object? extNumber = null,
    Object? faNumber = null,
    Object? type = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$InventoryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      assetLocation: null == assetLocation
          ? _value.assetLocation
          : assetLocation // ignore: cast_nullable_to_non_nullable
              as String,
      mainCatCode: null == mainCatCode
          ? _value.mainCatCode
          : mainCatCode // ignore: cast_nullable_to_non_nullable
              as String,
      mainCatDesc: null == mainCatDesc
          ? _value.mainCatDesc
          : mainCatDesc // ignore: cast_nullable_to_non_nullable
              as String,
      mainDesc: null == mainDesc
          ? _value.mainDesc
          : mainDesc // ignore: cast_nullable_to_non_nullable
              as String,
      subCatCode: null == subCatCode
          ? _value.subCatCode
          : subCatCode // ignore: cast_nullable_to_non_nullable
              as String,
      subCatDesc: null == subCatDesc
          ? _value.subCatDesc
          : subCatDesc // ignore: cast_nullable_to_non_nullable
              as String,
      assetCategory: null == assetCategory
          ? _value.assetCategory
          : assetCategory // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      serial: null == serial
          ? _value.serial
          : serial // ignore: cast_nullable_to_non_nullable
              as String,
      employeeId: null == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as String,
      extNumber: null == extNumber
          ? _value.extNumber
          : extNumber // ignore: cast_nullable_to_non_nullable
              as String,
      faNumber: null == faNumber
          ? _value.faNumber
          : faNumber // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InventoryImpl implements _Inventory {
  const _$InventoryImpl(
      {required this.id,
      required this.assetLocation,
      required this.mainCatCode,
      required this.mainCatDesc,
      required this.mainDesc,
      required this.subCatCode,
      required this.subCatDesc,
      required this.assetCategory,
      required this.image,
      required this.quantity,
      required this.serial,
      required this.employeeId,
      required this.extNumber,
      required this.faNumber,
      required this.type,
      required this.createdAt,
      required this.updatedAt});

  factory _$InventoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$InventoryImplFromJson(json);

  @override
  final String id;
  @override
  final String assetLocation;
  @override
  final String mainCatCode;
  @override
  final String mainCatDesc;
  @override
  final String mainDesc;
  @override
  final String subCatCode;
  @override
  final String subCatDesc;
  @override
  final String assetCategory;
  @override
  final String image;
  @override
  final int quantity;
  @override
  final String serial;
  @override
  final String employeeId;
  @override
  final String extNumber;
  @override
  final String faNumber;
  @override
  final String type;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Inventory(id: $id, assetLocation: $assetLocation, mainCatCode: $mainCatCode, mainCatDesc: $mainCatDesc, mainDesc: $mainDesc, subCatCode: $subCatCode, subCatDesc: $subCatDesc, assetCategory: $assetCategory, image: $image, quantity: $quantity, serial: $serial, employeeId: $employeeId, extNumber: $extNumber, faNumber: $faNumber, type: $type, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.assetLocation, assetLocation) ||
                other.assetLocation == assetLocation) &&
            (identical(other.mainCatCode, mainCatCode) ||
                other.mainCatCode == mainCatCode) &&
            (identical(other.mainCatDesc, mainCatDesc) ||
                other.mainCatDesc == mainCatDesc) &&
            (identical(other.mainDesc, mainDesc) ||
                other.mainDesc == mainDesc) &&
            (identical(other.subCatCode, subCatCode) ||
                other.subCatCode == subCatCode) &&
            (identical(other.subCatDesc, subCatDesc) ||
                other.subCatDesc == subCatDesc) &&
            (identical(other.assetCategory, assetCategory) ||
                other.assetCategory == assetCategory) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.serial, serial) || other.serial == serial) &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.extNumber, extNumber) ||
                other.extNumber == extNumber) &&
            (identical(other.faNumber, faNumber) ||
                other.faNumber == faNumber) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      assetLocation,
      mainCatCode,
      mainCatDesc,
      mainDesc,
      subCatCode,
      subCatDesc,
      assetCategory,
      image,
      quantity,
      serial,
      employeeId,
      extNumber,
      faNumber,
      type,
      createdAt,
      updatedAt);

  /// Create a copy of Inventory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryImplCopyWith<_$InventoryImpl> get copyWith =>
      __$$InventoryImplCopyWithImpl<_$InventoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InventoryImplToJson(
      this,
    );
  }
}

abstract class _Inventory implements Inventory {
  const factory _Inventory(
      {required final String id,
      required final String assetLocation,
      required final String mainCatCode,
      required final String mainCatDesc,
      required final String mainDesc,
      required final String subCatCode,
      required final String subCatDesc,
      required final String assetCategory,
      required final String image,
      required final int quantity,
      required final String serial,
      required final String employeeId,
      required final String extNumber,
      required final String faNumber,
      required final String type,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$InventoryImpl;

  factory _Inventory.fromJson(Map<String, dynamic> json) =
      _$InventoryImpl.fromJson;

  @override
  String get id;
  @override
  String get assetLocation;
  @override
  String get mainCatCode;
  @override
  String get mainCatDesc;
  @override
  String get mainDesc;
  @override
  String get subCatCode;
  @override
  String get subCatDesc;
  @override
  String get assetCategory;
  @override
  String get image;
  @override
  int get quantity;
  @override
  String get serial;
  @override
  String get employeeId;
  @override
  String get extNumber;
  @override
  String get faNumber;
  @override
  String get type;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of Inventory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InventoryImplCopyWith<_$InventoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
