import 'package:go_router/go_router.dart';
import 'package:newbly_flutter_website/screens/home/home_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
