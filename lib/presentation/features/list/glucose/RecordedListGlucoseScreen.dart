import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioGlucoseModel.dart';
import 'package:ody_flutter_app/presentation/components/appbar/IconTitleIconAppBar.dart';
import 'package:ody_flutter_app/presentation/components/appbar/model/AppBarIcon.dart';
import 'package:ody_flutter_app/presentation/components/bottom_sheet/BottomSheetGlucoseTable.dart';
import 'package:ody_flutter_app/presentation/components/bottom_sheet/CommonBottomSheet.dart';
import 'package:ody_flutter_app/presentation/components/empty/EmptyView.dart';
import 'package:ody_flutter_app/presentation/components/loading/CircleLoading.dart';
import 'package:ody_flutter_app/presentation/components/toast/Toast.dart';
import 'package:ody_flutter_app/presentation/features/list/glucose/widget/RecordGlucoseBottomContent.dart';
import 'package:ody_flutter_app/presentation/features/list/glucose/widget/RecordGlucoseItem.dart';
import 'package:ody_flutter_app/presentation/features/main/home/notifier/CalendarSelectDateNotifier.dart';
import 'package:ody_flutter_app/presentation/features/main/provider/ForDaysBioInfoProvider.dart';
import 'package:ody_flutter_app/presentation/models/UiState.dart';
import 'package:ody_flutter_app/presentation/navigation/PageMoveUtil.dart';
import 'package:ody_flutter_app/presentation/navigation/Route.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/utils/CollectionUtil.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/date/DateChecker.dart';

class RecordedListGlucoseScreen extends HookConsumerWidget {
  const RecordedListGlucoseScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiState = ref.watch(forDaysBioInfoProvider);
    final uiStateRead = ref.read(forDaysBioInfoProvider.notifier);
    final glucoseList = useState<List<ResponseBioGlucoseModel>>([]);
    DateTime date = ref.watch(calendarSelectDateProvider);
    final isToday = useState(false);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        uiState.when(
          success: (event) async {
            glucoseList.value = [...?event.value?.glucoses.reversed.toList()];
          },
          failure: (event) {
            ToastUtil.errorToast(context, event.errorMessage);
          },
        );
      });
    }, [uiState]);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        isToday.value = DateChecker.isDateToday(date);
      });
    }, [date]);

    return Scaffold(
      appBar: IconTitleIconAppBar(
        leadingIcon: AppBarIcon(
          path: 'assets/imgs/icon_back.svg',
          onPressed: () => Navigator.of(context).pop(),
          tint: getColorScheme(context).colorText,
        ),
        actionIcon: AppBarIcon(
          path: 'assets/imgs/icon_information.svg',
          onPressed: () {
            CommonBottomSheet.showBottomSheet(context, child: const BottomSheetGlucoseTable());
          },
          tint: getColorScheme(context).colorText,
        ),
        title: getAppLocalizations(context).list_record_glucose_title,
      ),
      backgroundColor: getColorScheme(context).colorUI03,
      body: Stack(
        children: [
          if (uiState is Success)
            !CollectionUtil.isNullorEmpty(glucoseList.value)
                ? ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
                    shrinkWrap: true,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 24); // Adjust the height as needed
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return RecordGlucoseItem(model: glucoseList.value[index]);
                    },
                    itemCount: glucoseList.value.length,
                  )
                : Center(
                    child: EmptyView(
                      screen: RoutingScreen.RecordedListGlucose,
                      onPressed: () async {
                        if (isToday.value) {
                          ResponseBioGlucoseModel data = await Navigator.push(
                            context,
                            nextSlideScreen(RoutingScreen.RecordGlucose.route),
                          );
                          try {
                            if (data.glucose != 0) {
                              uiStateRead.addGlucoseBioInfo(data);
                            }
                          } catch (e) {
                            debugPrint("glucose update fail: ${e.toString()}");
                          }
                        } else {
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ),
          if (uiState is Success)
            !CollectionUtil.isNullorEmpty(glucoseList.value) ? const RecordGlucoseBottomContent() : const SizedBox(),
          if (uiState is Failure)
            Center(
              child: EmptyView(
                screen: RoutingScreen.ServerError,
                onPressed: () {},
              ),
            ),
          if (uiState is Loading) const CircleLoading()
        ],
      ),
    );
  }
}
