import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_todo_list/providers/todo_calendar_provider.dart';
import 'package:simple_todo_list/utils/styles/app_colors.dart';
import 'package:simple_todo_list/utils/unique_keys.dart';

import '../../providers/bottom_nav_providers.dart';
import '../../providers/theme_provider.dart';
import '../../providers/todo_list_provider.dart';

class AddTodo extends HookConsumerWidget {
  const AddTodo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newTodoController = TextEditingController();
    final selectedDate = ref.watch(selectedDateProvider);
    final isDark = ref.watch(isDarkProvider).getTheme();
    final currentIndex = ref.watch(currentIndexProvider);

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0), // 여기서 모서리를 둥글게 만듭니다.
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      backgroundColor: isDark ? Colors.white : AppColors.noteColor2,
      content: SingleChildScrollView(
        child: Container(
          // constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.maxFinite,
                height: 300.0,
                child: TextField(
                  key: addTodoKey,
                  controller: newTodoController,
                  style: const TextStyle(color: Colors.black87, fontSize: 16.0),
                  cursorColor: Colors.black87,
                  decoration: const InputDecoration(
                    labelText: ' MEMO',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                    alignLabelWithHint: true,
                    labelStyle: TextStyle(color: Colors.black38, fontSize: 14.0),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(6.0)), // 여기서 반지름을 설정
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(6.0)), // 여기서 반지름을 설정
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(6.0)), // 여기서 반지름을 설정
                    ),
                  ),
                  expands: true,
                  maxLines: null,
                  textAlignVertical: TextAlignVertical.top,
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      if(currentIndex == 0){
                        ref.read(todoListProvider.notifier).add(value,DateTime.now());
                      } else {
                        ref.read(todoListProvider.notifier).add(value,selectedDate!);
                      }
                      newTodoController.clear();
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
              if (currentIndex == 0) {
                ref.read(todoListProvider.notifier).add(newTodoController.text, DateTime.now());
                Navigator.of(context).pop(); // Add after saving
              } else {
                if (selectedDate != null) {
                  ref.read(todoListProvider.notifier).add(newTodoController.text, selectedDate!);
                  Navigator.of(context).pop(); // Add after saving
                } else {
                  debugPrint("날짜 선택 프린트 - showDialog 실행");
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("메모 저장"),
                      titleTextStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                      content: const Text("날짜를 선택해주세요."),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text("확인"),
                        ),
                      ],
                    ),
                  );
                }
              }
              newTodoController.clear();
            }
          },
          child: const Text('Save', style: TextStyle(color: Colors.blue)),
        ),
      ],
    );
  }
}