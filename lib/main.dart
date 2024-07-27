import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'providers/shared_utility_provider.dart';
import 'providers/storage_provider.dart';
import 'providers/theme_provider.dart';
import 'routing/appRoute.dart';
import 'ui/screen/home/home.dart';
import 'utils/storage.dart';
import 'utils/styles/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final storage = LocalStorage();
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
        storageProvider.overrideWithValue(storage),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    final bool isDark = ref.watch(isDarkProvider).getTheme();
    return MaterialApp.router(
          routerConfig: goRouter,
          debugShowCheckedModeBanner: false,
          theme: isDark ? AppTheme.dark() : AppTheme.light(),
    );
  }
}
