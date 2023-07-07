import 'dart:ui';

class GraphPointModel {
  final List<GraphPointDataModel> pointData;

  GraphPointModel({
    required this.pointData,
  });
}

class GraphPointDataModel {
  final String label;
  final double yValue;
  final Color pointColor;

  GraphPointDataModel({
    required this.label,
    required this.yValue,
    required this.pointColor,
  });
}
