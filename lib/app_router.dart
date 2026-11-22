import 'package:go_router/go_router.dart';
import 'package:pgl_p2_myportfolio/widgets/portfolio.dart';
import 'package:pgl_p2_myportfolio/widgets/welcome.dart';
import 'package:pgl_p2_myportfolio/widgets/register_screen.dart';
import 'package:pgl_p2_myportfolio/widgets/login_screen.dart';
import 'package:pgl_p2_myportfolio/widgets/plate_management.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login', // Cambiado de '/' a '/login' para que la pantalla de inicio de sesión sea la primera en mostrarse
  routes: [
    GoRoute(path: '/', builder: (context, state) => const Welcome()),
    GoRoute(path: '/portfolio', builder: (context, state) => const Portfolio()),
    GoRoute(path: '/crud', builder: (context, state) => const PlateManagement()),
    GoRoute(path: '/register', builder: (context, state) => const RegisterScreen()),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),

  ],
);