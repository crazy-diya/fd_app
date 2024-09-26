import 'package:fd_app/features/presentation/views/dashboard/dashboard_view.dart';
import 'package:fd_app/features/presentation/views/notification/notification_view.dart';
import 'package:fd_app/features/presentation/views/splash/splash_view.dart';
import 'package:fd_app/features/presentation/views/user_details/user_details_view.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Routes {
  static const String kSplashView = "kSplashView";
  static const String kUserDetailsView = "kUserDetailsView";
  static const String kNotificationView = "kNotificationView";
  static const String kDashboardView = "kDashboardView";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.kSplashView:
        return PageTransition(
          child: const SplashView(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kSplashView),
        );
      case Routes.kUserDetailsView:
        return PageTransition(
          child: const UserDetailsView(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kUserDetailsView),
        );
      case Routes.kNotificationView:
        return PageTransition(
          child: const NotificationView(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kNotificationView),
        );
      case Routes.kDashboardView:
        return PageTransition(
          child: const DashboardView(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kDashboardView),
        );
      default:
        return PageTransition(
          type: PageTransitionType.fade,
          child: const Scaffold(
            body: Center(
              child: Text("Invalid Route"),
            ),
          ),
        );
    }
  }
}
