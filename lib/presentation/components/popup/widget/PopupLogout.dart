import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/domain/usecases/local/app/GetAppPolicyUpdateUseCase.dart';
import 'package:odac_flutter_app/presentation/components/button/fill/FillButton.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonNotifier.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonSizeType.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonState.dart';
import 'package:odac_flutter_app/presentation/components/popup/PopupUtil.dart';
import 'package:odac_flutter_app/presentation/components/popup/provider/TermsProvider.dart';
import 'package:odac_flutter_app/presentation/features/main/my/provider/meInfoProvider.dart';
import 'package:odac_flutter_app/presentation/navigation/Route.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class PopUpLogout extends HookConsumerWidget {
  const PopUpLogout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final meInfoRead = ref.read(meInfoProvider.notifier);

    return Container(
      width: 288,
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "로그아웃",
            style: getTextTheme(context).l1b.copyWith(
                  color: getColorScheme(context).colorText,
                ),
          ),
          const SizedBox(height: 24,),
          Text(
            "정말로 로그아웃하시겠습니까?",
            style: getTextTheme(context).t4m.copyWith(
                  color: getColorScheme(context).colorText,
                ),
          ),
          const SizedBox(height: 24,),
          Container(
            decoration: BoxDecoration(
              color: getColorScheme(context).primary100,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  meInfoRead.updateMeInfo(null);
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    RoutingScreen.Login.route,
                        (route) => false,
                  );
                },
                borderRadius: BorderRadius.circular(5),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "로그아웃",
                        style: getTextTheme(context).b3sb.copyWith(
                          color: getColorScheme(context).white,
                        ),
                      )
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8,),
          Container(
            decoration: BoxDecoration(
              color: getColorScheme(context).neutral30,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                borderRadius: BorderRadius.circular(5),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "닫기",
                      style: getTextTheme(context).b3sb.copyWith(
                        color: getColorScheme(context).colorText,
                      ),
                    )
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
