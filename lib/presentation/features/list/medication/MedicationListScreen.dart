import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/data/models/me/ResponseMeMedicineModel.dart';
import 'package:odac_flutter_app/presentation/components/appbar/IconTitleIconAppBar.dart';
import 'package:odac_flutter_app/presentation/components/appbar/model/AppBarIcon.dart';
import 'package:odac_flutter_app/presentation/components/empty/EmptyView.dart';
import 'package:odac_flutter_app/presentation/components/loading/CircleLoading.dart';
import 'package:odac_flutter_app/presentation/features/list/medication/provider/MedicineListProvider.dart';
import 'package:odac_flutter_app/presentation/features/list/medication/widget/MedicineItem.dart';
import 'package:odac_flutter_app/presentation/models/UiState.dart';
import 'package:odac_flutter_app/presentation/navigation/PageMoveUtil.dart';
import 'package:odac_flutter_app/presentation/navigation/Route.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/utils/CollectionUtil.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';
import 'package:odac_flutter_app/presentation/utils/snackbar/SnackBarUtil.dart';

class MedicationListScreen extends HookConsumerWidget {
  const MedicationListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiState = ref.watch(medicineListProvider);
    final alarmItemsRead = ref.read(medicineListProvider.notifier);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        uiState.when(
          failure: (event) {
            SnackBarUtil.show(context, event.errorMessage);
          },
        );
      });
    }, [uiState]);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        alarmItemsRead.requestMedicineList();
      });
    }, []);

    debugPrint("MedicationListScreen uiState : $uiState");

    return Scaffold(
      appBar: IconTitleIconAppBar(
        leadingIcon: AppBarIcon(
          path: 'assets/imgs/icon_back.svg',
          onPressed: () => Navigator.of(context).pop(),
          tint: getColorScheme(context).colorText,
        ),
        title: getAppLocalizations(context).my_item_subtitle_pill,
      ),
      backgroundColor: getColorScheme(context).colorUI01,
      body: Stack(
        children: [
          if (uiState is Success<List<ResponseMeMedicineModel>>)
            CollectionUtil.isNullorEmpty(uiState.value)
                ? Center(
                    child: EmptyView(
                      screen: RoutingScreen.MedicationList,
                      onPressed: () {
                        Navigator.push(
                          context,
                          nextSlideScreen(RoutingScreen.AddMedication.route),
                        );
                      },
                    ),
                  )
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      child: ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: 16); // Adjust the height as needed
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return MedicineItem(data: uiState.value[index]);
                        },
                        itemCount: 3,
                      ),
                    ),
                  ),
          if (uiState is Loading) const CircleLoading(),
          if (uiState is Success<List<ResponseMeMedicineModel>>)
            !CollectionUtil.isNullorEmpty(uiState.value) ? const _FloatingButton() : const SizedBox()
        ],
      ),
    );
  }
}

class _FloatingButton extends StatelessWidget {
  const _FloatingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        width: 50,
        height: 50,
        margin: const EdgeInsets.only(bottom: 48, right: 24),
        decoration: BoxDecoration(
          color: getColorScheme(context).primary100,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: getColorScheme(context).primary100.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 6), // changes position of shadow
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: () {
              Navigator.push(
                context,
                nextSlideScreen(RoutingScreen.AddMedication.route),
              );
            },
            child: SvgPicture.asset(
              'assets/imgs/icon_plus_btn.svg',
              colorFilter: ColorFilter.mode(
                getColorScheme(context).white,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
