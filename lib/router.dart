import 'package:sync_write/screen/document_screen.dart';
import 'package:sync_write/screen/home_screen.dart';
import 'package:sync_write/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoute = RouteMap(
  routes: {'/': (route) => const MaterialPage(child: LoginScreen())},
);

final loggedInRoute = RouteMap(
  routes: {
    '/': (route) => const MaterialPage(child: HomeScreen()),

    '/document/:id': (route) => MaterialPage(
      child: DocumentScreen(
        id: route.pathParameters['id'] ?? '',
      ),
    ),
  },
);
