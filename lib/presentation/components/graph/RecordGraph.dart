import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ody_flutter_app/presentation/components/graph/model/AxisEmphasisModel.dart';
import 'package:ody_flutter_app/presentation/components/graph/model/GraphLineModel.dart';
import 'package:ody_flutter_app/presentation/components/graph/model/GraphPointModel.dart';
import 'package:ody_flutter_app/presentation/components/graph/model/ShadowAreaModel.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/dto/Triple.dart';

enum RecordGraphType { POINT, LINE }

enum RecordXAxisType { DATE, YOIL, WEEK }

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

  /// x축 타입
  final RecordXAxisType xAxisType;

  /// 구분선 색상
  final Color dividerColor;

  /// y축 최소값
  final double yMin;

  /// y축 최대값
  final double yMax;

  /// 점 리스트
  GraphPointModel graphPointModel = GraphPointModel(
    pointData: [],
  );

  /// 점 - 라인 리스트
  List<GraphLineModel> graphLineModelList = [];

  RecordGraph({
    Key? key,
    required this.xAxisList,
    required this.yAxisList,
    required this.shadowAreaList,
    required this.symbolWidget,
    required this.graphType,
    required this.xAxisType,
    required this.dividerColor,
    this.xAxisInnerHorizontalPadding = 0,
    this.yMin = 60,
    this.yMax = 160,
  }) : super(key: key);

  RecordGraph.point({
    Key? key,
    required this.xAxisList,
    required this.yAxisList,
    required this.symbolWidget,
    required this.shadowAreaList,
    required this.xAxisInnerHorizontalPadding,
    required this.dividerColor,
    required this.graphPointModel,
    this.xAxisType = RecordXAxisType.DATE,
  })  : graphType = RecordGraphType.POINT,
        yMin = 60,
        yMax = 160,
        super(key: key);

  RecordGraph.line({
    Key? key,
    required this.xAxisList,
    required this.yAxisList,
    required this.symbolWidget,
    required this.shadowAreaList,
    required this.xAxisInnerHorizontalPadding,
    required this.dividerColor,
    required this.graphLineModelList,
    this.xAxisType = RecordXAxisType.DATE,
  })  : graphType = RecordGraphType.LINE,
        yMin = 60,
        yMax = 160,
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
                        graphLineModelList: graphLineModelList,
                        xAxisInnerHorizontalPadding: xAxisInnerHorizontalPadding,
                        graphType: graphType,
                        xAxisType: xAxisType,
                        yMin: yMin,
                        yMax: yMax,
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
    required this.graphLineModelList,
    required this.xAxisInnerHorizontalPadding,
    required this.graphType,
    required this.xAxisType,
    required this.yMin,
    required this.yMax,
  });

  final List<AxisEmphasisModel> xAxisList;
  final List<AxisEmphasisModel> yAxisList;
  final Color dividerColor;
  final List<ShadowAreaModel> shadowAreaList;
  final GraphPointModel graphPointModel;
  final List<GraphLineModel> graphLineModelList;
  final double xAxisInnerHorizontalPadding;
  final RecordGraphType graphType;
  final RecordXAxisType xAxisType;
  final double yMin;
  final double yMax;

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
          child: graphType == RecordGraphType.POINT
              ? LayoutBuilder(
                  builder: (context, constraints) {
                    const circleSize = 6.0;
                    final containerHeight = constraints.maxHeight - circleSize;
                    return CustomPaint(
                      size: Size(MediaQuery.of(context).size.width, containerHeight),
                      painter: PointPainter(xAxisList, graphPointModel, xAxisType, yMin, yMax),
                      child: Container(),
                    );
                  },
                )
              : Stack(
                  children: graphLineModelList.map((graphLineModel) {
                    return LayoutBuilder(
                      builder: (context, constraints) {
                        const circleSize = 6.0;
                        final containerHeight = constraints.maxHeight - circleSize;
                        return CustomPaint(
                          size: Size(MediaQuery.of(context).size.width, containerHeight),
                          painter: LinePainter(xAxisList, graphLineModel, xAxisType, yMin, yMax),
                          child: Container(),
                        );
                      },
                    );
                  }).toList(),
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
  final GraphLineModel graphLineModel;
  final RecordXAxisType xAxisType;
  final double yMin;
  final double yMax;

  LinePainter(
    this.xAxisList,
    this.graphLineModel,
    this.xAxisType,
    this.yMin,
    this.yMax,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = graphLineModel.lineColor
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    Path path = Path();

    if (xAxisType == RecordXAxisType.DATE) {
      /// 선 그리기
      for (int i = 0; i < graphLineModel.pointData.length; i++) {
        final hour = graphLineModel.pointData[i].label.split(":").first;
        final min = graphLineModel.pointData[i].label.split(":").last;
        final double totalMinute = double.parse(hour) * 60 + double.parse(min);
        final xPercentage = totalMinute / 1440.0;
        final yPercentage = graphLineModel.pointData[i].yValue - yMin <= 0
            ? 0.01
            : ((graphLineModel.pointData[i].yValue - yMin) / (yMax - yMin));
        final xPos = size.width * xPercentage;
        final yPos = size.height * (1.0 - yPercentage);

        if (i == 0) {
          path.moveTo(xPos, yPos);
        } else {
          path.lineTo(xPos, yPos);
        }
      }
      canvas.drawPath(path, linePaint);

      /// 점 그리기
      for (int i = 0; i < graphLineModel.pointData.length; i++) {
        final hour = graphLineModel.pointData[i].label.split(":").first;
        final min = graphLineModel.pointData[i].label.split(":").last;
        final double totalMinute = double.parse(hour) * 60 + double.parse(min);
        final xPercentage = totalMinute / 1440.0;
        final yPercentage = graphLineModel.pointData[i].yValue - yMin <= 0
            ? 0.01
            : ((graphLineModel.pointData[i].yValue - yMin) / (yMax - yMin));
        final xPos = size.width * xPercentage;
        final yPos = size.height * (1.0 - yPercentage);
        final circlePaint = Paint()
          ..color = graphLineModel.pointData[i].pointColor
          ..style = PaintingStyle.fill;
        canvas.drawCircle(Offset(xPos, yPos), 4.0, circlePaint);
      }
    } else {
      final dataPointSpacing = size.width / (xAxisList.length - 1);

      for (int i = 0; i < graphLineModel.pointData.length; i++) {
        int xIndex = xAxisList.map((e) => e.label).toList().indexOf(graphLineModel.pointData[i].label);
        final xPos = xIndex * dataPointSpacing;
        final yPercentage = graphLineModel.pointData[i].yValue - yMin <= 0
            ? 0.01
            : ((graphLineModel.pointData[i].yValue - yMin) / (yMax - yMin));
        final yPos = size.height * (1.0 - yPercentage);
        if (i == 0) {
          path.moveTo(xPos, yPos);
        } else {
          path.lineTo(xPos, yPos);
        }
      }
      canvas.drawPath(path, linePaint);

      for (int i = 0; i < graphLineModel.pointData.length; i++) {
        int xIndex = xAxisList.map((e) => e.label).toList().indexOf(graphLineModel.pointData[i].label);
        final xPos = xIndex * dataPointSpacing;
        final yPercentage = graphLineModel.pointData[i].yValue - yMin <= 0
            ? 0.01
            : ((graphLineModel.pointData[i].yValue - yMin) / (yMax - yMin));
        final yPos = size.height * (1.0 - yPercentage);
        final circlePaint = Paint()
          ..color = graphLineModel.pointData[i].pointColor
          ..style = PaintingStyle.fill;

        canvas.drawCircle(Offset(xPos, yPos), 4.0, circlePaint);
      }
    }
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) => true;
}

class PointPainter extends CustomPainter {
  final List<AxisEmphasisModel> xAxisList;
  final GraphPointModel graphPointModel;
  final RecordXAxisType xAxisType;
  final double yMin;
  final double yMax;

  PointPainter(
    this.xAxisList,
    this.graphPointModel,
    this.xAxisType,
    this.yMin,
    this.yMax,
  );

  @override
  void paint(Canvas canvas, Size size) {
    if (xAxisType == RecordXAxisType.DATE) {
      /// 점 그리기
      for (int i = 0; i < graphPointModel.pointData.length; i++) {
        final hour = graphPointModel.pointData[i].label.split(":").first;
        final min = graphPointModel.pointData[i].label.split(":").last;
        final double totalMinute = double.parse(hour) * 60 + double.parse(min);
        final xPercentage = totalMinute / 1440.0;
        final yPercentage = graphPointModel.pointData[i].yValue - yMin <= 0
            ? 0.01
            : ((graphPointModel.pointData[i].yValue - yMin) / (yMax - yMin));
        final xPos = size.width * xPercentage;
        final yPos = size.height * (1.0 - yPercentage);
        final circlePaint = Paint()
          ..color = graphPointModel.pointData[i].pointColor
          ..style = PaintingStyle.fill;
        canvas.drawCircle(Offset(xPos, yPos), 4.0, circlePaint);
      }
    } else {
      final dataPointSpacing = size.width / (xAxisList.length - 1);

      for (int i = 0; i < graphPointModel.pointData.length; i++) {
        int xIndex = xAxisList.map((e) => e.label).toList().indexOf(graphPointModel.pointData[i].label);
        final xPos = xIndex * dataPointSpacing;
        final yPercentage = graphPointModel.pointData[i].yValue - yMin <= 0
            ? 0.01
            : ((graphPointModel.pointData[i].yValue - yMin) / (yMax - yMin));
        final yPos = size.height * (1.0 - yPercentage);
        final circlePaint = Paint()
          ..color = graphPointModel.pointData[i].pointColor
          ..style = PaintingStyle.fill;

        canvas.drawCircle(Offset(xPos, yPos), 4.0, circlePaint);
      }
    }

  }

  @override
  bool shouldRepaint(PointPainter oldDelegate) => true;
}
