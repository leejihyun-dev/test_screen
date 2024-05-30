// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'layout_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LayoutType _$LayoutTypeFromJson(Map<String, dynamic> json) {
  return _LayoutType.fromJson(json);
}

/// @nodoc
mixin _$LayoutType {
  String? get code => throw _privateConstructorUsedError;
  String? get desc => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LayoutTypeCopyWith<LayoutType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LayoutTypeCopyWith<$Res> {
  factory $LayoutTypeCopyWith(
          LayoutType value, $Res Function(LayoutType) then) =
      _$LayoutTypeCopyWithImpl<$Res, LayoutType>;
  @useResult
  $Res call({String? code, String? desc});
}

/// @nodoc
class _$LayoutTypeCopyWithImpl<$Res, $Val extends LayoutType>
    implements $LayoutTypeCopyWith<$Res> {
  _$LayoutTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? desc = freezed,
  }) {
    return _then(_value.copyWith(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      desc: freezed == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LayoutTypeImplCopyWith<$Res>
    implements $LayoutTypeCopyWith<$Res> {
  factory _$$LayoutTypeImplCopyWith(
          _$LayoutTypeImpl value, $Res Function(_$LayoutTypeImpl) then) =
      __$$LayoutTypeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? code, String? desc});
}

/// @nodoc
class __$$LayoutTypeImplCopyWithImpl<$Res>
    extends _$LayoutTypeCopyWithImpl<$Res, _$LayoutTypeImpl>
    implements _$$LayoutTypeImplCopyWith<$Res> {
  __$$LayoutTypeImplCopyWithImpl(
      _$LayoutTypeImpl _value, $Res Function(_$LayoutTypeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? desc = freezed,
  }) {
    return _then(_$LayoutTypeImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      desc: freezed == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LayoutTypeImpl implements _LayoutType {
  _$LayoutTypeImpl({this.code, this.desc});

  factory _$LayoutTypeImpl.fromJson(Map<String, dynamic> json) =>
      _$$LayoutTypeImplFromJson(json);

  @override
  final String? code;
  @override
  final String? desc;

  @override
  String toString() {
    return 'LayoutType(code: $code, desc: $desc)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LayoutTypeImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.desc, desc) || other.desc == desc));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, desc);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LayoutTypeImplCopyWith<_$LayoutTypeImpl> get copyWith =>
      __$$LayoutTypeImplCopyWithImpl<_$LayoutTypeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LayoutTypeImplToJson(
      this,
    );
  }
}

abstract class _LayoutType implements LayoutType {
  factory _LayoutType({final String? code, final String? desc}) =
      _$LayoutTypeImpl;

  factory _LayoutType.fromJson(Map<String, dynamic> json) =
      _$LayoutTypeImpl.fromJson;

  @override
  String? get code;
  @override
  String? get desc;
  @override
  @JsonKey(ignore: true)
  _$$LayoutTypeImplCopyWith<_$LayoutTypeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
