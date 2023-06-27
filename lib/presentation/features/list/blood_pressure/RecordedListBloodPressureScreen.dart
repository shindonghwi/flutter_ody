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
import 'package:ody_flutter_app/presentation/features/list/blood_pressure/provider/RecordListBloodPressureProvider.dart';
import 'package:ody_flutter_app/presentation/features/list/blood_pressure/widget/RecordBloodPressureBottomContent.dart';
import 'package:ody_flutter_app/presentation/features/list/blood_pressure/widget/RecordBloodPressureItem.dart';
import 'package:ody_flutter_app/presentation/models/UiState.dart';
import 'package:ody_flutter_app/presentation/navigation/PageMoveUtil.dart';
import 'package:ody_flutter_app/presentation/navigation/Route.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/utils/CollectionUtil.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/snackbar/SnackBarUtil.dart';

class RecordedListBloodPressureScreen extends HookConsumerWidget {
  final DateTime? date;

  const RecordedListBloodPressureScreen({
    Key? key,
    this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiState = ref.watch(recordListBloodPressureProvider);
    final uiStateRead = ref.read(recordListBloodPressureProvider.notifier);

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
          uiStateRead.requestBioBloodPressureList(date!.year, date!.month, date!.day);
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
            CommonBottomSheet.showBottomSheet(context, child: const BottomSheetBPTable());
          },
          tint: getColorScheme(context).colorText,
        ),
        title: getAppLocalizations(context).list_record_blood_pressure_title,
      ),
      backgroundColor: getColorScheme(context).colorUI03,
      body: Stack(
        children: [
          if (uiState is Success<List<ResponseBioBloodPressureModel>>)
            !CollectionUtil.isNullorEmpty(uiState.value)
                ? ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
                    shrinkWrap: true,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 24); // Adjust the height as needed
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return RecordBloodPressureItem(model: uiState.value[index]);
                    },
                    itemCount: uiState.value.length,
                  )
                : Center(
                    child: EmptyView(
                      screen: RoutingScreen.RecordedListBloodPressure,
                      onPressed: () {
                        Navigator.push(
                          context,
                          nextSlideScreen(RoutingScreen.RecordBloodPressure.route),
                        );
                      },
                    ),
                  ),
          if (uiState is Success<List<ResponseBioBloodPressureModel>>)
            !CollectionUtil.isNullorEmpty(uiState.value)
                ? RecordBloodPressureBottomContent(date: date!)
                : const SizedBox(),
          if (uiState is Loading) const CircleLoading()
        ],
      ),
    );
  }
}
