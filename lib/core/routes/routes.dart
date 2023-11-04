import 'dart:developer';

import 'package:ayman_package/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final navigatorKey = GlobalKey<NavigatorState>();
final goRouter = GoRouter(
  errorBuilder: (context, state) {
    return const Scaffold();
  },

  debugLogDiagnostics: true, // for log routes
  initialLocation: HomePage.path,

  navigatorKey: navigatorKey,
  routes: [
    GoRoute(
      path: HomePage.path,
      name: HomePage.path,
      pageBuilder: (context, state) =>
          const MaterialPage(child: HomePage(), fullscreenDialog: true),
      onExit: (context) async {
        log("On Exist");
        return true;
      },
      // redirect: (context, state) async {
      //   if (state.fullPath == HomePage.path) {
      //     log("yes");
      //   }
      //   return "";
      // },
    ),
    GoRoute(
      path: DashboardPage.path,
      name: DashboardPage.path,
      pageBuilder: (context, state) {
        return const MaterialPage(child: DashboardPage());
      },
    ),
  ],
);
