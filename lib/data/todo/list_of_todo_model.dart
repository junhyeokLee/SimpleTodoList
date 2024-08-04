import 'package:freezed_annotation/freezed_annotation.dart';
import 'todo_model.dart';

part 'list_of_todo_model.freezed.dart';
part 'list_of_todo_model.g.dart';

@freezed
class ListOfTodoModel with _$ListOfTodoModel {
  const factory ListOfTodoModel({
    @Default([]) List<TodoModel> data,
  }) = _ListOfTodoModel;

  factory ListOfTodoModel.fromJson(Map<String, dynamic> json) => _$ListOfTodoModelFromJson(json);
}

ListOfTodoModel listOfTodoModelFromTodos(List<TodoModel> todos) {
  return ListOfTodoModel(data: todos);
}