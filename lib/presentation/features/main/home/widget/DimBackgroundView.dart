import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/presentation/features/main/home/notifier/DimNotifier.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

class DimBackgroundView extends HookConsumerWidget {
  final VoidCallback onBackgroundTap;

  const DimBackgroundView({
    Key? key,
    required VoidCallback this.onBackgroundTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const minAlpha = 0.0;
    const maxAlpha = 0.3;
    const duration = 200;

    final isDimOn = ref.watch<bool>(dimProvider);

    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: duration),
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
