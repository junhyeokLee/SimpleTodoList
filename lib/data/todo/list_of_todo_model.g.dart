// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_of_todo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ListOfTodoModelImpl _$$ListOfTodoModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ListOfTodoModelImpl(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => TodoModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ListOfTodoModelImplToJson(
        _$ListOfTodoModelImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
