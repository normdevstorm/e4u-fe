import 'package:go_router/go_router.dart';
import 'package:health_management/app/route/route_define.dart';
import 'package:health_management/presentation/auth/ui/login_screen.dart';
import 'package:health_management/presentation/auth/ui/register_screen.dart';

// part 'auth_route.g.dart'; // Generated file - will be created by build_runner

// Using regular GoRoute instead of TypedGoRoute for base structure
// Can be converted to TypedGoRoute after running build_runner
final loginRoute = GoRoute(
  name: RouteDefine.login,
  path: '/login',
  builder: (context, state) => const LoginScreen(),
);

final registerRoute = GoRoute(
  name: RouteDefine.register,
  path: '/register',
  builder: (context, state) => RegisterScreen(),
);
