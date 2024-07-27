import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_todo_list/utils/styles/app_colors.dart';

import '../../providers/theme_provider.dart';
import '../../providers/todo_list_provider.dart';

class AddTodo extends HookConsumerWidget {
  const AddTodo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newTodoController = TextEditingController();
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.spaceBetween,
      backgroundColor: AppColors.noteColor,
      contentPadding: const EdgeInsets.all(16.0),
      content: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.maxFinite,
                height: 300.0,
                child: TextField(
                  key: Key('addTodoField'),
                  controller: newTodoController,
                  style: const TextStyle(color: Colors.black87, fontSize: 16.0),
                  cursorColor: Colors.black87,
                  decoration: const InputDecoration(
                    labelText: 'MEMO',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                    alignLabelWithHint: true,
                    labelStyle: TextStyle(color: Colors.black38, fontSize: 14.0),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                  ),
                  expands: true,
                  maxLines: null,
                  textAlignVertical: TextAlignVertical.top,
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      ref.read(todoListProvider.notifier).add(value);
                      newTodoController.clear();
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Exit', style: TextStyle(color: Colors.red)),
        ),
        TextButton(
          onPressed: () {
            if (newTodoController.text.isNotEmpty) {
              ref.read(todoListProvider.notifier).add(newTodoController.text);
              newTodoController.clear();
              Navigator.of(context).pop();
            }
          },
          child: const Text('Save', style: TextStyle(color: Colors.blue)),
        ),
      ],
    );
  }
}