import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/todo/list_of_todo_model.dart';
import '../utils/constants.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final sharedUtilityProvider = Provider<SharedUtility>((ref) {
  final _sharedPrefs = ref.watch(sharedPreferencesProvider);
  return SharedUtility(sharedPreferences: _sharedPrefs);
});

class SharedUtility {
  SharedUtility({
    required this.sharedPreferences,
  });

  final SharedPreferences sharedPreferences;

  ListOfTodoModel loadSharedTodoData() {
    final jsonString = sharedPreferences.getString(sharedPrefTodoListKey) ?? emptyJsonStringData;
    final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;

    return ListOfTodoModel.fromJson(jsonMap);
  }

  void saveSharedTodoData(ListOfTodoModel listOfTodoModel) {
    final jsonMap = listOfTodoModel.toJson();
    final jsonString = jsonEncode(jsonMap);

    sharedPreferences.setString(sharedPrefTodoListKey, jsonString);
  }

  bool isDarkModeEnabled() {
    return sharedPreferences.getBool(sharedDarkModeKey) ?? false;
  }

  void setDarkModeEnabled(bool value) {
    sharedPreferences.setBool(sharedDarkModeKey, value);
  }
}