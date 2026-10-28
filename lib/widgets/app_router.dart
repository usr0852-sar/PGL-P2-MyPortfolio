import 'package:go_router/go_router.dart';
import 'package:pgl_p2_myportfolio/widgets/portfolio.dart';
import 'package:pgl_p2_myportfolio/widgets/welcome.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const Welcome()),
    GoRoute(path: '/portfolio', builder: (context, state) => const Portfolio()),
  ],
);