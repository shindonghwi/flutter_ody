import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioBloodPressureModel.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioGlucoseModel.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioStepModel.dart';
import 'package:ody_flutter_app/presentation/components/empty/EmptyView.dart';
import 'package:ody_flutter_app/presentation/components/loading/CircleLoading.dart';
import 'package:ody_flutter_app/presentation/features/main/analysis/widget/AnalysisTabItemTitle.dart';
import 'package:ody_flutter_app/presentation/features/main/home/model/CalendarSize.dart';
import 'package:ody_flutter_app/presentation/features/main/home/notifier/CalendarPageNotifier.dart';
import 'package:ody_flutter_app/presentation/features/main/provider/ForDaysBioInfoProvider.dart';
import 'package:ody_flutter_app/presentation/features/main/provider/MainTabIndexProvider.dart';
import 'package:ody_flutter_app/presentation/models/UiState.dart';
import 'package:ody_flutter_app/presentation/navigation/PageMoveUtil.dart';
import 'package:ody_flutter_app/presentation/navigation/Route.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/CollectionUtil.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/date/DateTransfer.dart';
import 'package:ody_flutter_app/presentation/utils/snackbar/SnackBarUtil.dart';

class AnalysisScreen extends HookConsumerWidget {
  const AnalysisScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPageDatetime = ref.watch<DateTime>(calendarPageProvider);
    final uiState = ref.watch(forDaysBioInfoProvider);

    final stepList = useState<List<ResponseBioStepModel>?>([]);
    final glucoseList = useState<List<ResponseBioGlucoseModel>?>([]);
    final bpList = useState<List<ResponseBioBloodPressureModel>?>([]);
    final isAllEmpty = useState(true);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        uiState.when(
          success: (event) async {
            stepList.value = event.value?.steps ?? [];
            glucoseList.value = event.value?.glucoses ?? [];
            bpList.value = event.value?.bloodPressures ?? [];

            isAllEmpty.value = CollectionUtil.isNullorEmpty(stepList.value) &&
                CollectionUtil.isNullorEmpty(glucoseList.value) &&
                CollectionUtil.isNullorEmpty(bpList.value);
          },
          failure: (event) {
            SnackBarUtil.show(context, event.errorMessage);
          },
        );
      });
    }, [uiState]);

    return Scaffold(
      backgroundColor: getColorScheme(context).colorUI03,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              color: getColorScheme(context).colorUI03,
              margin: EdgeInsets.only(top: CalendarSize.underMargin(context), left: 20, right: 20),
              child: !isAllEmpty.value
                  ? SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateTransfer.dateTimeToYearMonthDayYoil(currentPageDatetime),
                            style: getTextTheme(context).t2b.copyWith(
                                  color: getColorScheme(context).colorText,
                                ),
                          ),
                          const SizedBox(
                            height: 22,
                          ),
                          if (!CollectionUtil.isNullorEmpty(stepList.value))
                            _StepList(
                              stepList: stepList.value?.reversed.toList(),
                            ),
                          if (!CollectionUtil.isNullorEmpty(bpList.value))
                            _BpList(
                              bpList: bpList.value?.reversed.toList(),
                            ),
                          if (!CollectionUtil.isNullorEmpty(glucoseList.value))
                            _GlucoseList(
                              glucoseList: glucoseList.value?.reversed.toList(),
                            ),
                        ],
                      ),
                    )
                  : Center(
                      child: EmptyView(
                        screen: RoutingScreen.MainAnalysis,
                        onPressed: () => ref.read(mainTabIndexProvider.notifier).state = 0,
                      ),
                    ),
            ),
            if (uiState is Loading) const CircleLoading()
          ],
        ),
      ),
    );
  }
}

class _BpList extends StatelessWidget {
  const _BpList({
    super.key,
    required this.bpList,
  });

  final List<ResponseBioBloodPressureModel>? bpList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnalysisTabItemTitle(
          title: getAppLocalizations(context).home_today_record_blood_pressure,
          movePage: () {
            Navigator.push(
              context,
              nextSlideScreen(RoutingScreen.AnalysisBloodPressure.route),
            );
          },
        ),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 8); // Adjust the height as needed
          },
          itemBuilder: (BuildContext context, int index) {
            final item = bpList![index];
            return Container(
              width: double.infinity,
              height: 76,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: getColorScheme(context).white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "${item.systolicBloodPressure} - ${item.diastolicBloodPressure}",
                                style: getTextTheme(context).b2b.copyWith(
                                      color: getColorScheme(context).colorText,
                                    ),
                              ),
                              const WidgetSpan(
                                child: SizedBox(width: 6),
                              ),
                              TextSpan(
                                text: getAppLocalizations(context).home_today_record_blood_pressure_unit1,
                                style: getTextTheme(context).c2b.copyWith(
                                      color: getColorScheme(context).neutral70,
                                    ),
                              ),
                            ],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "${item.heartRate}",
                                style: getTextTheme(context).b2b.copyWith(
                                      color: getColorScheme(context).colorText,
                                    ),
                              ),
                              const WidgetSpan(
                                child: SizedBox(width: 6),
                              ),
                              TextSpan(
                                text: getAppLocalizations(context).home_today_record_blood_pressure_unit2,
                                style: getTextTheme(context).c2b.copyWith(
                                      color: getColorScheme(context).neutral70,
                                    ),
                              ),
                            ],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          item.status.name,
                          style: getTextTheme(context).c1b.copyWith(
                                color: getColorScheme(context).colorError,
                              ),
                        ),
                        Text(
                          DateTransfer.dateTimeToAmPmTimeOnlyNumber(
                            DateTime.now().copyWith(
                              hour: int.parse(item.createdAt.split(":")[0]),
                              minute: int.parse(item.createdAt.split(":")[1]),
                            ),
                          ),
                          style: getTextTheme(context).c2b.copyWith(
                                color: getColorScheme(context).neutral70,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          itemCount: bpList!.length,
        ),
        const SizedBox(
          height: 32,
        )
      ],
    );
  }
}

class _GlucoseList extends StatelessWidget {
  const _GlucoseList({
    super.key,
    required this.glucoseList,
  });

  final List<ResponseBioGlucoseModel>? glucoseList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnalysisTabItemTitle(
          title: getAppLocalizations(context).home_today_record_glucose,
          movePage: () {
            Navigator.push(
              context,
              nextSlideScreen(RoutingScreen.AnalysisGlucose.route),
            );
          },
        ),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 8); // Adjust the height as needed
          },
          itemBuilder: (BuildContext context, int index) {
            final item = glucoseList![index];
            return Container(
              width: double.infinity,
              height: 76,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: getColorScheme(context).white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: item.type.name,
                                style: getTextTheme(context).c2b.copyWith(
                                      color: getColorScheme(context).colorText,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "${item.glucose}",
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
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          item.status.name,
                          style: getTextTheme(context).c1b.copyWith(
                                color: getColorScheme(context).colorError,
                              ),
                        ),
                        Text(
                          DateTransfer.dateTimeToAmPmTimeOnlyNumber(
                            DateTime.now().copyWith(
                              hour: int.parse(item.createdAt.split(":")[0]),
                              minute: int.parse(item.createdAt.split(":")[1]),
                            ),
                          ),
                          style: getTextTheme(context).c2b.copyWith(
                                color: getColorScheme(context).neutral70,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          itemCount: glucoseList!.length,
        ),
        const SizedBox(
          height: 32,
        )
      ],
    );
  }
}

class _StepList extends StatelessWidget {
  const _StepList({
    super.key,
    required this.stepList,
  });

  final List<ResponseBioStepModel>? stepList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnalysisTabItemTitle(
          title: getAppLocalizations(context).home_today_record_walk,
        ),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 8); // Adjust the height as needed
          },
          itemBuilder: (BuildContext context, int index) {
            final item = stepList![index];
            return Container(
              width: double.infinity,
              height: 58,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: getColorScheme(context).white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "${item.count}",
                          style: getTextTheme(context).b2b.copyWith(
                                color: getColorScheme(context).colorText,
                              ),
                        ),
                        const WidgetSpan(
                          child: SizedBox(width: 6),
                        ),
                        TextSpan(
                          text: getAppLocalizations(context).home_today_record_walk_unit,
                          style: getTextTheme(context).c2b.copyWith(
                                color: getColorScheme(context).neutral70,
                              ),
                        ),
                      ],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    DateTransfer.dateTimeToAmPmTimeOnlyNumber(
                      DateTime.now().copyWith(
                        hour: int.parse(item.createdAt.split(":").first),
                        minute: int.parse(item.createdAt.split(":").last),
                      ),
                    ),
                    style: getTextTheme(context).c2b.copyWith(
                          color: getColorScheme(context).neutral70,
                        ),
                  ),
                ],
              ),
            );
          },
          itemCount: stepList!.length,
        ),
        const SizedBox(
          height: 32,
        )
      ],
    );
  }
}
