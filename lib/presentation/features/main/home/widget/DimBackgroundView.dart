import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/features/main/home/provider/DimProvider.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class DimBackgroundView extends HookConsumerWidget {
  final VoidCallback onBackgroundTap;

  const DimBackgroundView({
    Key? key,
    required VoidCallback this.onBackgroundTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final minAlpha = 0.0;
    final maxAlpha = 0.3;
    final duration = 200;

    final isDimOn = ref.watch<bool>(DimProvider);

    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: duration),
      tween: Tween<double>(begin: minAlpha, end: isDimOn ? maxAlpha : minAlpha),
      builder: (_, value, child) {
        // 접힌상태
        if (value != maxAlpha) {
          return IgnorePointer(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: getColorScheme(context).black.withOpacity(value),
            ),
          );
        }

        // 확장상태
        else {
          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => onBackgroundTap(),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: getColorScheme(context).black.withOpacity(value),
              ),
            ),
          );
        }
      },
    );
  }
}
