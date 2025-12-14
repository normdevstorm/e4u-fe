import 'package:go_router/go_router.dart';
import 'package:health_management/app/route/route_define.dart';
import 'package:health_management/presentation/home/ui/home_screen.dart';

// part 'home_route.g.dart'; // Generated file - will be created by build_runner

// Using regular GoRoute instead of TypedGoRoute for base structure
// Can be converted to TypedShellRoute after running build_runner
final homeRoute = GoRoute(
  name: RouteDefine.homeScreen,
  path: '/home',
  builder: (context, state) => const HomeScreen(),
);
