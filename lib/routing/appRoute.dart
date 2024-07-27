import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../ui/animation/CircularRevealPage.dart';
import '../ui/screen/about_us_page.dart';
import '../ui/screen/add_todo.dart';
import '../ui/screen/calendar/calendar.dart';
import '../ui/screen/home/home.dart';
import 'scaffold_with_nested_navigation.dart';

enum AppRoute {
  home,
  calendar,
  aboutUs,
  addTodo,
  ;

  static AppRoute find(String? name) {
    return values.firstWhere((e) => e.toString() == name);
  }
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'home');
final _calendarNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'calendar');

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/home',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _homeNavigatorKey,
            routes: [
              // Products
              GoRoute(
                path: '/home',
                name: AppRoute.home.name,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const Home(),
                ),
                routes: [
                  GoRoute(
                    path: 'aboutUs',
                    name: AppRoute.aboutUs.name,
                    pageBuilder: (context, state) {
                      return CustomTransitionPage(
                        key: state.pageKey,
                        child: AboutUsPage(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.easeInOut;
                          final tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          final offsetAnimation = animation.drive(tween);
                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                        transitionDuration:
                            const Duration(milliseconds: 300), // 애니메이션 속도 조절
                      );
                    },
                  )
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _calendarNavigatorKey,
            routes: [
              // Shopping Cart
              GoRoute(
                path: '/calendar',
                name: AppRoute.calendar.name,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const Calendar(),
                ),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/todo',
        name: AppRoute.addTodo.name,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const AddTodo(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              // 커브 애니메이션 설정
              final curvedAnimation = CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              );

              // 페이드 애니메이션을 위한 opacity
              final fadeAnimation = Tween<double>(
                begin: 0.0,
                end: 1.0,
              ).animate(curvedAnimation);

              return FadeTransition(
                opacity: fadeAnimation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 600),
          );
        },
      ),
    ],
  );
});
