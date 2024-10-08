import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/todo/list_of_todo_model.dart';
import 'todo_filter_type_provider.dart';
import 'todo_list_provider.dart';

final filteredTodos = Provider<ListOfTodoModel>((ref) {
  final filter = ref.watch(todoFilterType.state);
  final todos = ref.watch(todoListProvider);

  switch (filter.state) {
    case TodoFilterType.completed:
      return ListOfTodoModel(
        data: todos.data.where((todo) => todo.isCompleted).toList(),
      );
    // case TodoFilterType.today:
    //   return ListOfTodoModel(
    //     data: todos.data.where((todo) => !todo.isCompleted).toList(),
    //   );
    case TodoFilterType.today:
      final today = DateTime.now();
      return ListOfTodoModel(
        data: todos.data.where((todo) =>
        !todo.isCompleted
            &&
            todo.date.year == today.year &&
            todo.date.month == today.month &&
            todo.date.day == today.day
        ).toList(),
      );
    case TodoFilterType.pinned:
      return ListOfTodoModel(
        data: todos.data.where((todo) => todo.isPinned).toList(),
      );
    case TodoFilterType.all:
      return todos;
  }
});
