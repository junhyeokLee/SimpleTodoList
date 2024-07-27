// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'list_of_todo_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ListOfTodoModel _$ListOfTodoModelFromJson(Map<String, dynamic> json) {
  return _ListOfTodoModel.fromJson(json);
}

/// @nodoc
mixin _$ListOfTodoModel {
  List<TodoModel> get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ListOfTodoModelCopyWith<ListOfTodoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListOfTodoModelCopyWith<$Res> {
  factory $ListOfTodoModelCopyWith(
          ListOfTodoModel value, $Res Function(ListOfTodoModel) then) =
      _$ListOfTodoModelCopyWithImpl<$Res, ListOfTodoModel>;
  @useResult
  $Res call({List<TodoModel> data});
}

/// @nodoc
class _$ListOfTodoModelCopyWithImpl<$Res, $Val extends ListOfTodoModel>
    implements $ListOfTodoModelCopyWith<$Res> {
  _$ListOfTodoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<TodoModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ListOfTodoModelImplCopyWith<$Res>
    implements $ListOfTodoModelCopyWith<$Res> {
  factory _$$ListOfTodoModelImplCopyWith(_$ListOfTodoModelImpl value,
          $Res Function(_$ListOfTodoModelImpl) then) =
      __$$ListOfTodoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<TodoModel> data});
}

/// @nodoc
class __$$ListOfTodoModelImplCopyWithImpl<$Res>
    extends _$ListOfTodoModelCopyWithImpl<$Res, _$ListOfTodoModelImpl>
    implements _$$ListOfTodoModelImplCopyWith<$Res> {
  __$$ListOfTodoModelImplCopyWithImpl(
      _$ListOfTodoModelImpl _value, $Res Function(_$ListOfTodoModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$ListOfTodoModelImpl(
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<TodoModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ListOfTodoModelImpl implements _ListOfTodoModel {
  const _$ListOfTodoModelImpl({final List<TodoModel> data = const []})
      : _data = data;

  factory _$ListOfTodoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ListOfTodoModelImplFromJson(json);

  final List<TodoModel> _data;
  @override
  @JsonKey()
  List<TodoModel> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'ListOfTodoModel(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListOfTodoModelImpl &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ListOfTodoModelImplCopyWith<_$ListOfTodoModelImpl> get copyWith =>
      __$$ListOfTodoModelImplCopyWithImpl<_$ListOfTodoModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ListOfTodoModelImplToJson(
      this,
    );
  }
}

abstract class _ListOfTodoModel implements ListOfTodoModel {
  const factory _ListOfTodoModel({final List<TodoModel> data}) =
      _$ListOfTodoModelImpl;

  factory _ListOfTodoModel.fromJson(Map<String, dynamic> json) =
      _$ListOfTodoModelImpl.fromJson;

  @override
  List<TodoModel> get data;
  @override
  @JsonKey(ignore: true)
  _$$ListOfTodoModelImplCopyWith<_$ListOfTodoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
