import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioGlucoseModel.dart';
import 'package:ody_flutter_app/presentation/components/divider/DottedDivider.dart';
import 'package:ody_flutter_app/presentation/components/toast/Toast.dart';
import 'package:ody_flutter_app/presentation/features/record/model/RecordRangeStatus.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/CollectionUtil.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

class RecordGlucoseItem extends HookWidget {
  final ResponseBioGlucoseModel model;

  const RecordGlucoseItem({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hour24 = int.parse(model.createdAt.split(":").first);
    final amText = hour24 < 12 ? getAppLocalizations(context).common_am : getAppLocalizations(context).common_pm;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "$amText ${model.createdAt}",
              style: getTextTheme(context).b3sb.copyWith(
                    color: getColorScheme(context).neutral70,
                  ),
            ),
            if (!CollectionUtil.isNullEmptyFromString(model.memo))
              Container(
                margin: const EdgeInsets.only(left: 2),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      ToastUtil.defaultToast(getAppLocalizations(context).message_clipboard_copy);
                      Clipboard.setData(ClipboardData(text: model.memo.toString()));
                    },
                    child: SvgPicture.asset(
                      "assets/imgs/icon_memo.svg",
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        getColorScheme(context).neutral70,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              )
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: getColorScheme(context).white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        model.status.name,
                        style: getTextTheme(context).c2b.copyWith(
                              color: getColorScheme(context).colorText,
                            ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: model.glucose.toString(),
                              style: getTextTheme(context).b2b.copyWith(
                                    color: getColorScheme(context).colorText,
                                  ),
                            ),
                            const WidgetSpan(
                              child: SizedBox(width: 6),
                            ),
                            TextSpan(
                              text: getAppLocalizations(context).home_today_record_glucose_unit,
                              style: getTextTheme(context).c2b.copyWith(
                                    color: getColorScheme(context).neutral70,
                                  ),
                            ),
                          ],
                        ),
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                  Text(
                    model.status.name.toString(),
                    style: getTextTheme(context).b2b.copyWith(
                          color: RecordRangeStatusHelper.getStatusTextColor(
                            context,
                            RecordRangeStatusHelper.getGlucoseRecordRangeStatusFromCode(model.status.code),
                          ),
                        ),
                  )
                ],
              ),
              if (!CollectionUtil.isNullEmptyFromString(model.memo))
                const DottedDivider(
                  margin: EdgeInsets.symmetric(vertical: 16),
                ),
              if (!CollectionUtil.isNullEmptyFromString(model.memo))
                Text(
                  model.memo.toString(),
                  style: getTextTheme(context).c2r.copyWith(
                        color: getColorScheme(context).neutral70,
                      ),
                )
            ],
          ),
        )
      ],
    );
  }
}
