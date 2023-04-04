import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/features/login/provider/AgreementProvider.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class AgreementItem extends HookConsumerWidget {
  final int index;
  final String text;
  final bool isRequired;
  final VoidCallback? onPressedSeeMore;

  const AgreementItem({
    Key? key,
    required this.index,
    required this.text,
    required this.isRequired,
    this.onPressedSeeMore = null,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final policyItemsState = ref.watch<List<bool>>(agreementPolicyItemProvider);
    final policyItemsRead = ref.read(agreementPolicyItemProvider.notifier);

    return Row(
      children: [
        Expanded(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => policyItemsRead.change(index),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/imgs/icon_check.svg",
                    width: 28,
                    height: 28,
                    colorFilter: ColorFilter.mode(
                      policyItemsState[index]
                          ? getColorScheme(context).colorPrimaryDefault
                          : getColorScheme(context).colorPrimaryDisable,
                      BlendMode.srcIn,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "[${isRequired ? "${getAppLocalizations(context).common_required}" : "${getAppLocalizations(context).common_select}"}]",
                          style: getTextTheme(context).b2.copyWith(
                                color: isRequired
                                    ? getColorScheme(context).colorPrimaryDefault
                                    : getColorScheme(context).neutral80,
                              ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          text,
                          style: getTextTheme(context).b2.copyWith(
                                color: getColorScheme(context).neutral80,
                              ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => onPressedSeeMore?.call(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                "assets/imgs/icon_next.svg",
                width: 28,
                height: 28,
                colorFilter: ColorFilter.mode(
                  getColorScheme(context).colorPrimaryDisable,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
