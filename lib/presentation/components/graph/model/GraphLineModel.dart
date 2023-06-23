import 'dart:ui';

import 'package:ody_flutter_app/presentation/components/graph/model/GraphPointModel.dart';

class GraphLineModel {
  final List<GraphPointDataModel> pointData;
  final Color lineColor;

  GraphLineModel({
    required this.pointData,
    required this.lineColor,
  });
}
