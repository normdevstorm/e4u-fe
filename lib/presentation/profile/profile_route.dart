import 'package:go_router/go_router.dart';
import 'package:e4u_application/app/route/route_define.dart';
import 'package:e4u_application/presentation/profile/ui/profile_screen.dart';

final profileRoute = GoRoute(
  name: RouteDefine.profile,
  path: '/profile',
  builder: (context, state) => const ProfileScreen(),
);
