import 'package:flutter/material.dart';
import 'package:odac_flutter_app/presentation/navigation/Route.dart';

PageRouteBuilder nextSlideScreen(String route) {
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 250),
    pageBuilder: (context, animation, secondaryAnimation) => RoutingScreen.getScreen(route),
    reverseTransitionDuration: Duration(milliseconds: 250),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0)).animate(animation),
        child: child,
      );
    },
  );
}
