import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_todo_list/utils/styles/app_colors.dart';

import '../../providers/current_todo_provider.dart';
import '../../providers/todo_list_provider.dart';

class TodoItem extends HookConsumerWidget {
  const TodoItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todo = ref.watch(currentTodo);
    //hooks
    final itemFocusNode = useFocusNode();
    // listen to focus chances
    useListenable(itemFocusNode);
    final isFocused = itemFocusNode.hasFocus;
    final textEditingController = useTextEditingController();
    final textFieldFocusNode = useFocusNode();

    return Container(
      decoration: BoxDecoration(
        color: AppColors.noteColor2,
      ),
      child: Focus(
        focusNode: itemFocusNode,
        onFocusChange: (focused) {
          if (focused) {
            textEditingController.text = todo.description;
          } else {
            // Commit changes only when the textfield is unfocused, for performance
            ref
                .read(todoListProvider.notifier)
                .edit(id: todo.id, description: textEditingController.text);
          }
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: ListTile(
                onTap: () {
                  itemFocusNode.requestFocus();
                  textFieldFocusNode.requestFocus();
                },
                leading: GestureDetector(
                  onTap: () =>
                      ref.read(todoListProvider.notifier).toggle(todo.id),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: todo.isCompleted
                        ? Icon(CarbonIcons.checkmark_outline,
                            size: 32.0,
                            color: Colors.black)
                        : Icon(
                            CarbonIcons.radio_button,
                            size: 32.0,
                            color: Colors.black
                                .withOpacity(0.45),
                          ),
                  ),
                ),
                title: isFocused
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextField(
                            autofocus: true,
                            focusNode: textFieldFocusNode,
                            controller: textEditingController,
              
                            ///due to bug in indic keyboard . It fills suggestion automatically two times.
                            enableSuggestions: false,
                            cursorColor: Theme.of(context).colorScheme.secondary,
                            decoration:
                                const InputDecoration(labelText: 'Edit Task')),
                      )
                    : Text(
                        todo.description,
                        style: TextStyle(
                          color: Colors.black,
                          decoration: todo.isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                trailing: GestureDetector(
                  onTap: () =>
                      ref.read(todoListProvider.notifier).togglePinned(todo.id),
                  child: todo.isPinned
                      ? Icon(
                          CarbonIcons.pin_filled,
                          size: 24.0,
                          color: Colors.black,
                        )
                      : Icon(
                          CarbonIcons.pin,
                          size: 24.0,
                          color: Colors.black
                              .withOpacity(0.45), //
                        ),
                ),
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            const Divider(
              height: 1,
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }
}
