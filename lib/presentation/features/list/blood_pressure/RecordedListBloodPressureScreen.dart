import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioBloodPressureModel.dart';
import 'package:ody_flutter_app/presentation/components/appbar/IconTitleIconAppBar.dart';
import 'package:ody_flutter_app/presentation/components/appbar/model/AppBarIcon.dart';
import 'package:ody_flutter_app/presentation/components/bottom_sheet/BottomSheetBPTable.dart';
import 'package:ody_flutter_app/presentation/components/bottom_sheet/CommonBottomSheet.dart';
import 'package:ody_flutter_app/presentation/components/empty/EmptyView.dart';
import 'package:ody_flutter_app/presentation/components/loading/CircleLoading.dart';
import 'package:ody_flutter_app/presentation/components/toast/Toast.dart';
import 'package:ody_flutter_app/presentation/features/list/blood_pressure/widget/RecordBloodPressureBottomContent.dart';
import 'package:ody_flutter_app/presentation/features/list/blood_pressure/widget/RecordBloodPressureItem.dart';
import 'package:ody_flutter_app/presentation/features/main/home/notifier/CalendarSelectDateNotifier.dart';
import 'package:ody_flutter_app/presentation/features/main/provider/ForDaysBioInfoProvider.dart';
import 'package:ody_flutter_app/presentation/models/UiState.dart';
import 'package:ody_flutter_app/presentation/navigation/PageMoveUtil.dart';
import 'package:ody_flutter_app/presentation/navigation/Route.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/utils/CollectionUtil.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/date/DateChecker.dart';

class RecordedListBloodPressureScreen extends HookConsumerWidget {
  const RecordedListBloodPressureScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiState = ref.watch(forDaysBioInfoProvider);
    final uiStateRead = ref.read(forDaysBioInfoProvider.notifier);
    final bpList = useState<List<ResponseBioBloodPressureModel>>([]);
    DateTime date = ref.watch(calendarSelectDateProvider);
    final isToday = useState(false);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        uiState.when(
          success: (event) async {
            bpList.value = [...?event.value?.bloodPressures.reversed.toList()];
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
            CommonBottomSheet.showBottomSheet(context, child: const BottomSheetBPTable());
          },
          tint: getColorScheme(context).colorText,
        ),
        title: getAppLocalizations(context).list_record_blood_pressure_title,
      ),
      backgroundColor: getColorScheme(context).colorUI03,
      body: Stack(
        children: [
          if (uiState is Success)
            !CollectionUtil.isNullorEmpty(bpList.value)
                ? ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
                    shrinkWrap: true,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 24); // Adjust the height as needed
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return RecordBloodPressureItem(model: bpList.value[index]);
                    },
                    itemCount: bpList.value.length,
                  )
                : Center(
                    child: EmptyView(
                      screen: RoutingScreen.RecordBloodPressure,
                      onPressed: () async {
                        if (uiState is Failure) {
                          if (isToday.value) {
                            ResponseBioBloodPressureModel data = await Navigator.push(
                              context,
                              nextSlideScreen(RoutingScreen.RecordBloodPressure.route),
                            );
                            try {
                              if (data.diastolicBloodPressure != 0) {
                                uiStateRead.addBpBioInfo(data);
                              }
                            } catch (e) {
                              debugPrint("bp update fail: ${e.toString()}");
                            }
                          } else {
                            Navigator.of(context).pop();
                          }
                        }
                      },
                    ),
                  ),
          if (uiState is Success)
            !CollectionUtil.isNullorEmpty(bpList.value) ? const RecordBloodPressureBottomContent() : const SizedBox(),
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
