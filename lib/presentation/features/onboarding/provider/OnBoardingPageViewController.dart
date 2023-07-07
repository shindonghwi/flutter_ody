import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final onBoardingPageViewControllerProvider = StateProvider.autoDispose<PageController>(
  (ref) => PageController(
    keepPage: true,
    initialPage: 0,
  ),
);
