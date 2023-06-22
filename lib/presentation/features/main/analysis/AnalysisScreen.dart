import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ody_flutter_app/presentation/navigation/PageMoveUtil.dart';
import 'package:ody_flutter_app/presentation/navigation/Route.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

class AnalysisScreen extends HookWidget {
  const AnalysisScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColorScheme(context).colorUI02,
      body: Stack(
        children: [
          Center(
            child: ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      nextSlideScreen(RoutingScreen.AnalysisBloodPressure.route),
                    );
                  },
                  child: const Text('혈압 분석'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      nextSlideScreen(RoutingScreen.AnalysisGlucose.route),
                    );
                  },
                  child: const Text('혈당 분석'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
