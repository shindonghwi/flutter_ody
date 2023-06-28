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
import 'package:ody_flutter_app/presentation/features/list/glucose/provider/RecordListGlucoseProvider.dart';
import 'package:ody_flutter_app/presentation/features/list/glucose/widget/RecordGlucoseBottomContent.dart';
import 'package:ody_flutter_app/presentation/features/list/glucose/widget/RecordGlucoseItem.dart';
import 'package:ody_flutter_app/presentation/features/main/home/notifier/CalendarPageNotifier.dart';
import 'package:ody_flutter_app/presentation/models/UiState.dart';
import 'package:ody_flutter_app/presentation/navigation/PageMoveUtil.dart';
import 'package:ody_flutter_app/presentation/navigation/Route.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/utils/CollectionUtil.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/date/DateChecker.dart';
import 'package:ody_flutter_app/presentation/utils/snackbar/SnackBarUtil.dart';

class RecordedListGlucoseScreen extends HookConsumerWidget {
  final DateTime? date;

  const RecordedListGlucoseScreen({
    Key? key,
    this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiState = ref.watch(recordListGlucoseProvider);
    final uiStateRead = ref.read(recordListGlucoseProvider.notifier);
    DateTime currentDateTime = ref.read(calendarPageProvider.notifier).getCurrentDateTime();
    bool isToday = false;

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        isToday = DateChecker.isDateToday(currentDateTime);
      });
    }, [currentDateTime]);

    useEffect(() {
      void handleUiStateChange() async {
        await Future(() {
          uiState.when(
            success: (event) => {},
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

        if (date == null) {
          Navigator.of(context).pop();
        } else {
          uiStateRead.requestBioGlucoseList(date!.year, date!.month, date!.day);
        }
      });
    }, []);

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
          if (uiState is Success<List<ResponseBioGlucoseModel>>)
            !CollectionUtil.isNullorEmpty(uiState.value)
                ? ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
                    shrinkWrap: true,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 24); // Adjust the height as needed
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return RecordGlucoseItem(model: uiState.value[index]);
                    },
                    itemCount: uiState.value.length,
                  )
                : Center(
                    child: EmptyView(
                      screen: RoutingScreen.RecordedListGlucose,
                      onPressed: () {
                        isToday
                            ? Navigator.push(
                                context,
                                nextSlideScreen(RoutingScreen.RecordGlucose.route),
                              )
                            : Navigator.of(context).pop();
                      },
                    ),
                  ),
          if (uiState is Success<List<ResponseBioGlucoseModel>>)
            !CollectionUtil.isNullorEmpty(uiState.value) ? RecordGlucoseBottomContent(date: date!) : const SizedBox(),
          if (uiState is Loading) const CircleLoading()
        ],
      ),
    );
  }
}
