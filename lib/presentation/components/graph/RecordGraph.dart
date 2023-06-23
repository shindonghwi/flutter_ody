import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ody_flutter_app/presentation/components/graph/model/AxisEmphasisModel.dart';
import 'package:ody_flutter_app/presentation/components/graph/model/GraphLineModel.dart';
import 'package:ody_flutter_app/presentation/components/graph/model/GraphPointModel.dart';
import 'package:ody_flutter_app/presentation/components/graph/model/ShadowAreaModel.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/dto/Pair.dart';
import 'package:ody_flutter_app/presentation/utils/dto/Triple.dart';

enum RecordGraphType { POINT, LINE }

class RecordGraph extends StatelessWidget {
  /// x축 리스트
  final List<AxisEmphasisModel> xAxisList;

  /// y축 리스트
  final List<AxisEmphasisModel> yAxisList;

  /// 오른쪽 상단에 있는 심볼 위젯
  final Widget? symbolWidget;

  /// y축 범위 영역 리스트
  final List<ShadowAreaModel> shadowAreaList;

  /// x축 양옆 간격 패딩
  final double xAxisInnerHorizontalPadding;

  /// 그래프 타입
  final RecordGraphType graphType;

  /// 구분선 색상
  final Color dividerColor;

  /// x축 단위 너비
  int xAxisUnitWidth = 15;

  /// 점 리스트
  GraphPointModel graphPointModel = GraphPointModel(
    pointData: [],
  );

  /// 점 - 라인 리스트
  GraphLineModel graphLineModel = GraphLineModel(
    pointData: [],
    lineColor: Colors.black,
  );

  RecordGraph({
    Key? key,
    required this.xAxisList,
    required this.yAxisList,
    required this.shadowAreaList,
    required this.symbolWidget,
    required this.graphType,
    required this.dividerColor,
    this.xAxisInnerHorizontalPadding = 0,
  }) : super(key: key);

  RecordGraph.point({
    Key? key,
    required this.xAxisList,
    required this.yAxisList,
    required this.symbolWidget,
    required this.shadowAreaList,
    required this.xAxisInnerHorizontalPadding,
    required this.dividerColor,
    required this.xAxisUnitWidth,
    required this.graphPointModel,
  })  : graphType = RecordGraphType.POINT,
        super(key: key);

  RecordGraph.line({
    Key? key,
    required this.xAxisList,
    required this.yAxisList,
    required this.symbolWidget,
    required this.shadowAreaList,
    required this.xAxisInnerHorizontalPadding,
    required this.dividerColor,
    required this.xAxisUnitWidth,
    required this.graphLineModel,
  })  : graphType = RecordGraphType.LINE,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          symbolWidget ?? const SizedBox(),
          SizedBox(
            height: symbolWidget != null ? 24 : 0,
          ),
          Expanded(
            child: Stack(
              children: [
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.loose,
                      child: _YAxisContent(yAxisList: yAxisList),
                    ),
                    const SizedBox(width: 24),
                    Flexible(
                      flex: 16,
                      fit: FlexFit.tight,
                      child: _GraphContent(
                        xAxisList: xAxisList,
                        yAxisList: yAxisList,
                        dividerColor: dividerColor,
                        shadowAreaList: shadowAreaList,
                        graphPointModel: graphPointModel,
                        graphLineModel: graphLineModel,
                        xAxisInnerHorizontalPadding: xAxisInnerHorizontalPadding,
                        xAxisUnitWidth: xAxisUnitWidth,
                        graphType: graphType,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 24),
          _XAxisContent(
            xAxisInnerHorizontalPadding: xAxisInnerHorizontalPadding,
            xAxisList: xAxisList,
          ),
        ],
      );
    });
  }
}

/// 그래프 컨텐츠
class _GraphContent extends HookWidget {
  const _GraphContent({
    super.key,
    required this.xAxisList,
    required this.yAxisList,
    required this.dividerColor,
    required this.shadowAreaList,
    required this.graphPointModel,
    required this.graphLineModel,
    required this.xAxisInnerHorizontalPadding,
    required this.xAxisUnitWidth,
    required this.graphType,
  });

  final List<AxisEmphasisModel> xAxisList;
  final List<AxisEmphasisModel> yAxisList;
  final Color dividerColor;
  final List<ShadowAreaModel> shadowAreaList;
  final GraphPointModel graphPointModel;
  final GraphLineModel graphLineModel;
  final double xAxisInnerHorizontalPadding;
  final int xAxisUnitWidth;
  final RecordGraphType graphType;

  @override
  Widget build(BuildContext context) {
    final max = int.parse(yAxisList.first.label);
    final min = int.parse(yAxisList.last.label);
    final List<Triple> areaList = [];
    for (var element in shadowAreaList) {
      final areaGap = element.max - element.min;
      final areaFactor = (areaGap) / (max - element.min);
      final startY = (min > element.min ? min - element.min : element.min - min) / (max - min);
      final color = element.color;
      areaList.add(Triple(1 - startY, areaFactor <= 0 ? 0.01 : areaFactor, color));
    }

    final List<GraphPointDataModel> coordinatePointDataList = [];
    final List<GraphPointDataModel> lineDataList = [];
    Pair<List<GraphPointDataModel>, Color> coordinateLineDataList = Pair([], graphLineModel.lineColor);

    xAxisList.map((xAxisData) {
      if (graphType == RecordGraphType.POINT) {
        for (var element in graphPointModel.pointData) {
          if (element.label == xAxisData.label) {
            final areaFactor = (element.yValue - min) / (max - min);
            coordinatePointDataList.add(GraphPointDataModel(
              label: element.label,
              yValue: areaFactor <= 0 ? 0.002 : areaFactor,
              pointColor: element.pointColor,
            ));
          }
        }
      } else {
        for (var element in graphLineModel.pointData) {
          if (element.label == xAxisData.label) {
            final areaFactor = (element.yValue - min) / (max - min);
            lineDataList.add(GraphPointDataModel(
              label: element.label,
              yValue: areaFactor <= 0 ? 0.002 : areaFactor,
              pointColor: element.pointColor,
            ));
          }
        }
        coordinateLineDataList = Pair(lineDataList, graphLineModel.lineColor);
      }
    }).toList();

    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: getMediaQuery(context).size.height * 0.0047),
          child: Stack(
            children: [
              /// 범위 표시
              ...areaList.map((e) {
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.transparent,
                  child: FractionallySizedBox(
                    widthFactor: 1,
                    heightFactor: e.first,
                    alignment: Alignment.topCenter,
                    child: FractionallySizedBox(
                      widthFactor: 1,
                      heightFactor: e.second,
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        color: e.third,
                      ),
                    ),
                  ),
                );
              }).toList(),

              /// 구분선 표시
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...yAxisList.map((e) {
                    return Container(
                      height: 0.5,
                      color: dividerColor,
                    );
                  }).toList(),
                ],
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: xAxisInnerHorizontalPadding),
          padding: EdgeInsets.symmetric(vertical: getMediaQuery(context).size.height * 0.002),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: graphType == RecordGraphType.POINT
                ? xAxisList.map((xAxisData) {
                    return SizedBox(
                      width: xAxisUnitWidth.toDouble(),
                      height: double.infinity,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          const circleSize = 6.0;
                          final containerHeight = constraints.maxHeight - circleSize;

                          return Stack(
                              children: coordinatePointDataList.map((e) {
                            return xAxisData.label == e.label
                                ? Positioned(
                                    left: 0,
                                    right: 0,
                                    top: containerHeight - (containerHeight * e.yValue),
                                    child: Container(
                                      width: circleSize,
                                      height: circleSize,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: e.pointColor,
                                      ),
                                    ),
                                  )
                                : const SizedBox();
                          }).toList());
                        },
                      ),
                    );
                  }).toList()
                : [
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          const circleSize = 6.0;
                          final containerHeight = constraints.maxHeight - circleSize;
                          return CustomPaint(
                            size: Size(MediaQuery.of(context).size.width, containerHeight),
                            painter: LinePainter(xAxisList, coordinateLineDataList),
                            child: Container(),
                          );
                        },
                      ),
                    )
                  ],
          ),
        )
      ],
    );
  }
}

/// y 축 컨텐츠
class _YAxisContent extends HookWidget {
  const _YAxisContent({
    super.key,
    required this.yAxisList,
  });

  final List<AxisEmphasisModel> yAxisList;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ...yAxisList.map((e) {
          return SizedBox(
            width: double.infinity,
            child: Text(
              e.label,
              style: getTextTheme(context).c3m.copyWith(
                    color: e.color,
                  ),
              textAlign: TextAlign.center,
            ),
          );
        }).toList(),
      ],
    );
  }
}

/// x 축 컨텐츠
class _XAxisContent extends HookWidget {
  const _XAxisContent({
    super.key,
    required this.xAxisInnerHorizontalPadding,
    required this.xAxisList,
  });

  final double xAxisInnerHorizontalPadding;
  final List<AxisEmphasisModel> xAxisList;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: SizedBox(),
        ),
        const SizedBox(
          width: 24,
        ),
        Flexible(
          flex: 16,
          fit: FlexFit.tight,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: xAxisInnerHorizontalPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...xAxisList.map((e) {
                  return Text(
                    e.label,
                    style: getTextTheme(context).c3m.copyWith(
                          color: e.color,
                        ),
                    textAlign: TextAlign.center,
                  );
                }).toList()
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class LinePainter extends CustomPainter {
  final List<AxisEmphasisModel> xAxisList;
  final Pair<List<GraphPointDataModel>, Color> pointLineDataList;

  LinePainter(
    this.xAxisList,
    this.pointLineDataList,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = pointLineDataList.second
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final dataPointSpacing = size.width / (xAxisList.length - 1);

    Path path = Path(); // Create a new path for the line

    /// 선 그리기
    for (int i = 0; i < pointLineDataList.first.length; i++) {
      int xIndex = xAxisList.map((e) => e.label).toList().indexOf(pointLineDataList.first[i].label);
      final xPos = xIndex * dataPointSpacing;
      final yPos = size.height - (size.height * pointLineDataList.first[i].yValue);

      if (i == 0) {
        path.moveTo(xPos, yPos);
      } else {
        path.lineTo(xPos, yPos);
      }
    }
    canvas.drawPath(path, linePaint);

    /// 점 그리기
    for (int i = 0; i < pointLineDataList.first.length; i++) {
      int xIndex = xAxisList.map((e) => e.label).toList().indexOf(pointLineDataList.first[i].label);
      final xPos = xIndex * dataPointSpacing;
      final yPos = size.height - (size.height * pointLineDataList.first[i].yValue);

      final circlePaint = Paint()
        ..color = pointLineDataList.first[i].pointColor
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(xPos, yPos), 4.0, circlePaint);
    }
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) => true;
}
