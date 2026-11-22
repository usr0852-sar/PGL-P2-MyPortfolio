import 'package:go_router/go_router.dart';
import 'package:pgl_p2_myportfolio/widgets/portfolio.dart';
import 'package:pgl_p2_myportfolio/widgets/welcome.dart';
import 'package:pgl_p2_myportfolio/widgets/register_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/register', // Cambiado de '/' a '/register' para que la pantalla de registro sea la primera en mostrarse
  routes: [
    GoRoute(path: '/', builder: (context, state) => const Welcome()),
    GoRoute(path: '/portfolio', builder: (context, state) => const Portfolio()),
    GoRoute(path: '/register', builder: (context, state) => const RegisterScreen()),
    
  ],
);