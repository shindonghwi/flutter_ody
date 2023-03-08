import 'dart:async';

import 'package:flutter/material.dart';

/**
 * @feature: type 에 따라 애니메이션 효과를 주는 위젯
 *
 * @author: 2023/02/14 12:58 PM donghwishin
 *
 * @description{
 *    showDuration: 위젯이 올라오는 시간 ( 기본값 )
 *    initDelay: 위젯이 올라오기 전에 대기하는 시간
 *    type: 위젯이 올라오는 방향
 * }
 */

enum ShowAnimationType { UP, DOWN, LEFT, RIGHT }

const showDuration = 250;

class ShowAnimation extends StatefulWidget {
  final Widget child;
  final ShowAnimationType type;
  final int initDelay;

  ShowAnimation({required this.child, required this.type, required this.initDelay});

  @override
  _ShowAnimationState createState() => _ShowAnimationState();
}

class _ShowAnimationState extends State<ShowAnimation> with TickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<Offset> _animOffset;

  @override
  void initState() {
    super.initState();

    var animOffsetValue;
    final animDuration = 300;
    final offsetZero = 0.0;
    final offsetDistance = 0.35;

    _animController = AnimationController(vsync: this, duration: Duration(milliseconds: animDuration));
    final curve = CurvedAnimation(
      curve: Curves.decelerate,
      parent: _animController,
    );

    switch (widget.type) {
      case ShowAnimationType.DOWN:
        animOffsetValue = Offset(offsetZero, -offsetDistance);
        break;
      case ShowAnimationType.UP:
        animOffsetValue = Offset(offsetZero, offsetDistance);
        break;
      case ShowAnimationType.LEFT:
        animOffsetValue = Offset(-offsetDistance, offsetZero);
        break;
      case ShowAnimationType.RIGHT:
        animOffsetValue = Offset(offsetDistance, offsetZero);
        break;
    }
    _animOffset = Tween<Offset>(begin: animOffsetValue, end: Offset.zero).animate(curve);

    if (widget.initDelay == null) {
      _animController.forward();
    } else {
      Timer(Duration(milliseconds: widget.initDelay), () {
        _animController.forward();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _animController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
      opacity: _animController,
    );
  }
}
