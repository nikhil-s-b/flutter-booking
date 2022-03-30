import 'package:go_router/go_router.dart';
import '../features/detail/detail_screen.dart';
import '../features/list/list_screen.dart';
import '../features/login/login_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      name: LoginScreen.name,
      path: LoginScreen.path,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
        name: ListScreen.name,
        path: ListScreen.path,
        builder: (context, state) => const ListScreen(),
        routes: [
          GoRoute(
            name: DetailScreen.name,
            path: DetailScreen.path,
            builder: (context, state) {
              return const DetailScreen();
            },
          ),
        ]),
  ],
);
