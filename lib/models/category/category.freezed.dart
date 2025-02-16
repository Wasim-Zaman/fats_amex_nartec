// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return _Category.fromJson(json);
}

/// @nodoc
mixin _$Category {
  String get id => throw _privateConstructorUsedError;
  String get mainCatCode => throw _privateConstructorUsedError;
  String get mainCategoryDesc => throw _privateConstructorUsedError;
  String get mainDescription => throw _privateConstructorUsedError;
  String get subCategoryCode => throw _privateConstructorUsedError;
  String get subCategoryDesc => throw _privateConstructorUsedError;
  int get counter => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Category to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Category
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CategoryCopyWith<Category> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryCopyWith<$Res> {
  factory $CategoryCopyWith(Category value, $Res Function(Category) then) =
      _$CategoryCopyWithImpl<$Res, Category>;
  @useResult
  $Res call(
      {String id,
      String mainCatCode,
      String mainCategoryDesc,
      String mainDescription,
      String subCategoryCode,
      String subCategoryDesc,
      int counter,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$CategoryCopyWithImpl<$Res, $Val extends Category>
    implements $CategoryCopyWith<$Res> {
  _$CategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Category
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? mainCatCode = null,
    Object? mainCategoryDesc = null,
    Object? mainDescription = null,
    Object? subCategoryCode = null,
    Object? subCategoryDesc = null,
    Object? counter = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      mainCatCode: null == mainCatCode
          ? _value.mainCatCode
          : mainCatCode // ignore: cast_nullable_to_non_nullable
              as String,
      mainCategoryDesc: null == mainCategoryDesc
          ? _value.mainCategoryDesc
          : mainCategoryDesc // ignore: cast_nullable_to_non_nullable
              as String,
      mainDescription: null == mainDescription
          ? _value.mainDescription
          : mainDescription // ignore: cast_nullable_to_non_nullable
              as String,
      subCategoryCode: null == subCategoryCode
          ? _value.subCategoryCode
          : subCategoryCode // ignore: cast_nullable_to_non_nullable
              as String,
      subCategoryDesc: null == subCategoryDesc
          ? _value.subCategoryDesc
          : subCategoryDesc // ignore: cast_nullable_to_non_nullable
              as String,
      counter: null == counter
          ? _value.counter
          : counter // ignore: cast_nullable_to_non_nullable
              as int,
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
abstract class _$$CategoryImplCopyWith<$Res>
    implements $CategoryCopyWith<$Res> {
  factory _$$CategoryImplCopyWith(
          _$CategoryImpl value, $Res Function(_$CategoryImpl) then) =
      __$$CategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String mainCatCode,
      String mainCategoryDesc,
      String mainDescription,
      String subCategoryCode,
      String subCategoryDesc,
      int counter,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$CategoryImplCopyWithImpl<$Res>
    extends _$CategoryCopyWithImpl<$Res, _$CategoryImpl>
    implements _$$CategoryImplCopyWith<$Res> {
  __$$CategoryImplCopyWithImpl(
      _$CategoryImpl _value, $Res Function(_$CategoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of Category
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? mainCatCode = null,
    Object? mainCategoryDesc = null,
    Object? mainDescription = null,
    Object? subCategoryCode = null,
    Object? subCategoryDesc = null,
    Object? counter = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$CategoryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      mainCatCode: null == mainCatCode
          ? _value.mainCatCode
          : mainCatCode // ignore: cast_nullable_to_non_nullable
              as String,
      mainCategoryDesc: null == mainCategoryDesc
          ? _value.mainCategoryDesc
          : mainCategoryDesc // ignore: cast_nullable_to_non_nullable
              as String,
      mainDescription: null == mainDescription
          ? _value.mainDescription
          : mainDescription // ignore: cast_nullable_to_non_nullable
              as String,
      subCategoryCode: null == subCategoryCode
          ? _value.subCategoryCode
          : subCategoryCode // ignore: cast_nullable_to_non_nullable
              as String,
      subCategoryDesc: null == subCategoryDesc
          ? _value.subCategoryDesc
          : subCategoryDesc // ignore: cast_nullable_to_non_nullable
              as String,
      counter: null == counter
          ? _value.counter
          : counter // ignore: cast_nullable_to_non_nullable
              as int,
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
class _$CategoryImpl implements _Category {
  const _$CategoryImpl(
      {required this.id,
      required this.mainCatCode,
      required this.mainCategoryDesc,
      required this.mainDescription,
      required this.subCategoryCode,
      required this.subCategoryDesc,
      required this.counter,
      required this.createdAt,
      required this.updatedAt});

  factory _$CategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$CategoryImplFromJson(json);

  @override
  final String id;
  @override
  final String mainCatCode;
  @override
  final String mainCategoryDesc;
  @override
  final String mainDescription;
  @override
  final String subCategoryCode;
  @override
  final String subCategoryDesc;
  @override
  final int counter;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Category(id: $id, mainCatCode: $mainCatCode, mainCategoryDesc: $mainCategoryDesc, mainDescription: $mainDescription, subCategoryCode: $subCategoryCode, subCategoryDesc: $subCategoryDesc, counter: $counter, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.mainCatCode, mainCatCode) ||
                other.mainCatCode == mainCatCode) &&
            (identical(other.mainCategoryDesc, mainCategoryDesc) ||
                other.mainCategoryDesc == mainCategoryDesc) &&
            (identical(other.mainDescription, mainDescription) ||
                other.mainDescription == mainDescription) &&
            (identical(other.subCategoryCode, subCategoryCode) ||
                other.subCategoryCode == subCategoryCode) &&
            (identical(other.subCategoryDesc, subCategoryDesc) ||
                other.subCategoryDesc == subCategoryDesc) &&
            (identical(other.counter, counter) || other.counter == counter) &&
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
      mainCatCode,
      mainCategoryDesc,
      mainDescription,
      subCategoryCode,
      subCategoryDesc,
      counter,
      createdAt,
      updatedAt);

  /// Create a copy of Category
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoryImplCopyWith<_$CategoryImpl> get copyWith =>
      __$$CategoryImplCopyWithImpl<_$CategoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CategoryImplToJson(
      this,
    );
  }
}

abstract class _Category implements Category {
  const factory _Category(
      {required final String id,
      required final String mainCatCode,
      required final String mainCategoryDesc,
      required final String mainDescription,
      required final String subCategoryCode,
      required final String subCategoryDesc,
      required final int counter,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$CategoryImpl;

  factory _Category.fromJson(Map<String, dynamic> json) =
      _$CategoryImpl.fromJson;

  @override
  String get id;
  @override
  String get mainCatCode;
  @override
  String get mainCategoryDesc;
  @override
  String get mainDescription;
  @override
  String get subCategoryCode;
  @override
  String get subCategoryDesc;
  @override
  int get counter;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of Category
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CategoryImplCopyWith<_$CategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
