import 'package:auto_route/auto_route.dart';

import 'app_auto_routes.gr.dart';

@AutoRouterConfig()
class AppAutoRouter extends $AppAutoRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: ContactRoute.page,
          path: '/contact',
          initial: true,
        ),
        AutoRoute(
          page: ContactManageRoute.page,
          path: '/contact-manage',
        ),
      ];
}
