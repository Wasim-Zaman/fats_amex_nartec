// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inventory_pagination.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

InventoryPagination _$InventoryPaginationFromJson(Map<String, dynamic> json) {
  return _InventoryPagination.fromJson(json);
}

/// @nodoc
mixin _$InventoryPagination {
  int get total => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  int get totalPages => throw _privateConstructorUsedError;
  bool get hasMore => throw _privateConstructorUsedError;

  /// Serializes this InventoryPagination to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InventoryPagination
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InventoryPaginationCopyWith<InventoryPagination> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryPaginationCopyWith<$Res> {
  factory $InventoryPaginationCopyWith(
          InventoryPagination value, $Res Function(InventoryPagination) then) =
      _$InventoryPaginationCopyWithImpl<$Res, InventoryPagination>;
  @useResult
  $Res call({int total, int page, int totalPages, bool hasMore});
}

/// @nodoc
class _$InventoryPaginationCopyWithImpl<$Res, $Val extends InventoryPagination>
    implements $InventoryPaginationCopyWith<$Res> {
  _$InventoryPaginationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InventoryPagination
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? page = null,
    Object? totalPages = null,
    Object? hasMore = null,
  }) {
    return _then(_value.copyWith(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InventoryPaginationImplCopyWith<$Res>
    implements $InventoryPaginationCopyWith<$Res> {
  factory _$$InventoryPaginationImplCopyWith(_$InventoryPaginationImpl value,
          $Res Function(_$InventoryPaginationImpl) then) =
      __$$InventoryPaginationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int total, int page, int totalPages, bool hasMore});
}

/// @nodoc
class __$$InventoryPaginationImplCopyWithImpl<$Res>
    extends _$InventoryPaginationCopyWithImpl<$Res, _$InventoryPaginationImpl>
    implements _$$InventoryPaginationImplCopyWith<$Res> {
  __$$InventoryPaginationImplCopyWithImpl(_$InventoryPaginationImpl _value,
      $Res Function(_$InventoryPaginationImpl) _then)
      : super(_value, _then);

  /// Create a copy of InventoryPagination
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? page = null,
    Object? totalPages = null,
    Object? hasMore = null,
  }) {
    return _then(_$InventoryPaginationImpl(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InventoryPaginationImpl implements _InventoryPagination {
  const _$InventoryPaginationImpl(
      {required this.total,
      required this.page,
      required this.totalPages,
      required this.hasMore});

  factory _$InventoryPaginationImpl.fromJson(Map<String, dynamic> json) =>
      _$$InventoryPaginationImplFromJson(json);

  @override
  final int total;
  @override
  final int page;
  @override
  final int totalPages;
  @override
  final bool hasMore;

  @override
  String toString() {
    return 'InventoryPagination(total: $total, page: $page, totalPages: $totalPages, hasMore: $hasMore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryPaginationImpl &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, total, page, totalPages, hasMore);

  /// Create a copy of InventoryPagination
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryPaginationImplCopyWith<_$InventoryPaginationImpl> get copyWith =>
      __$$InventoryPaginationImplCopyWithImpl<_$InventoryPaginationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InventoryPaginationImplToJson(
      this,
    );
  }
}

abstract class _InventoryPagination implements InventoryPagination {
  const factory _InventoryPagination(
      {required final int total,
      required final int page,
      required final int totalPages,
      required final bool hasMore}) = _$InventoryPaginationImpl;

  factory _InventoryPagination.fromJson(Map<String, dynamic> json) =
      _$InventoryPaginationImpl.fromJson;

  @override
  int get total;
  @override
  int get page;
  @override
  int get totalPages;
  @override
  bool get hasMore;

  /// Create a copy of InventoryPagination
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InventoryPaginationImplCopyWith<_$InventoryPaginationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
