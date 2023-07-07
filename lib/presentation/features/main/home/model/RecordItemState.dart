import 'package:flutter/material.dart';
import 'package:ody_flutter_app/presentation/utils/dto/Pair.dart';

class RecordItemState {
  final Widget title;
  final Widget content;
  final String imagePath;

  RecordItemState({
    required this.title,
    required this.content,
    required this.imagePath,
  });
}
