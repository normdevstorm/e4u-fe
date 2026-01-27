import 'package:go_router/go_router.dart';
import 'package:e4u_application/app/route/route_define.dart';
import 'package:e4u_application/presentation/stats/ui/stats_screen.dart';

final statsRoute = GoRoute(
  name: RouteDefine.stats,
  path: '/stats',
  builder: (context, state) => const StatsScreen(),
);
