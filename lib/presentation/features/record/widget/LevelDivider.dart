import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class LevelDivider extends HookWidget {
  final int level;
  final int length;
  final List<Color> colors;

  const LevelDivider({super.key,
    required this.level,
    required this.length,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double sectionWidth = constraints.maxWidth / length;
        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: Row(
            children: List.generate(length, (index) {
              return Container(
                width: sectionWidth,
                decoration: BoxDecoration(
                  color: level >= index + 1 ? colors[index] : getColorScheme(context).neutral30,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(index == 0 ? 100 : 0),
                    bottomLeft: Radius.circular(index == 0 ? 100 : 0),
                    topRight: Radius.circular(index == length - 1 ? 100 : 0),
                    bottomRight: Radius.circular(index == length - 1 ? 100 : 0),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
