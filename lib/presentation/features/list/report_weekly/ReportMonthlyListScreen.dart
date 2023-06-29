import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioReportListModel.dart';
import 'package:ody_flutter_app/presentation/components/appbar/IconTitleIconAppBar.dart';
import 'package:ody_flutter_app/presentation/components/appbar/model/AppBarIcon.dart';
import 'package:ody_flutter_app/presentation/components/empty/EmptyView.dart';
import 'package:ody_flutter_app/presentation/components/loading/CircleLoading.dart';
import 'package:ody_flutter_app/presentation/features/list/report_weekly/provider/ReportMonthlyListProvider.dart';
import 'package:ody_flutter_app/presentation/models/UiState.dart';
import 'package:ody_flutter_app/presentation/navigation/Route.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/CollectionUtil.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/snackbar/SnackBarUtil.dart';

class ReportMonthlyListScreen extends HookConsumerWidget {
  const ReportMonthlyListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiState = ref.watch(reportMonthlyListProvider);
    final uiStateRead = ref.read(reportMonthlyListProvider.notifier);

    useEffect(() {
      void handleUiStateChange() async {
        await Future(() {
          uiState.when(
            failure: (event) => SnackBarUtil.show(context, event.errorMessage),
          );
        });
      }

      handleUiStateChange();
      return null;
    }, [uiState]);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        uiStateRead.init();
        uiStateRead.requestMonthlyList();
      });
    }, []);

    return Scaffold(
      appBar: IconTitleIconAppBar(
        leadingIcon: AppBarIcon(
          path: 'assets/imgs/icon_back.svg',
          onPressed: () => Navigator.of(context).pop(),
          tint: getColorScheme(context).colorText,
        ),
        title: getAppLocalizations(context).list_report_monthly_title,
      ),
      backgroundColor: getColorScheme(context).colorUI01,
      body: Stack(
        children: [
          if (uiState is Success<List<ResponseBioReportListModel>>)
            !CollectionUtil.isNullorEmpty(uiState.value)
                ? SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: ListView.separated(
                      padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 16); // Adjust the height as needed
                      },
                      itemBuilder: (BuildContext context, int index) {
                        final item = uiState.value[index];
                        return Container(
                          height: 56,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: getColorScheme(context).primary100,
                              width: 1.5,
                            ),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(15),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 24),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Image.asset(
                                          'assets/imgs/icon_monthly_report.png',
                                          width: 24,
                                          height: 24,
                                        ),
                                        const SizedBox(width: 8),
                                        FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            getAppLocalizations(context).list_report_monthly_title,
                                            style: getTextTheme(context).b2b.copyWith(
                                                  color: getColorScheme(context).colorText,
                                                ),
                                          ),
                                        )
                                      ],
                                    ),
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "${item.year}년 ${item.month}월 (${item.minDate.split("-")[1]}.${item.minDate.split("-")[2]} - ${item.maxDate.split("-")[1]}.${item.maxDate.split("-")[2]})",
                                        style: getTextTheme(context).l3m.copyWith(
                                              color: getColorScheme(context).colorText,
                                            ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: uiState.value.length,
                    ),
                  )
                : Center(
                    child: EmptyView(
                      screen: RoutingScreen.ReportMonthlyList,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
          if (uiState is Loading) const CircleLoading(),
        ],
      ),
    );
  }
}
