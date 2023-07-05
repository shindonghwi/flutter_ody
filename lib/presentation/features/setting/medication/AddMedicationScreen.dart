import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/presentation/components/appbar/IconTitleIconAppBar.dart';
import 'package:ody_flutter_app/presentation/components/appbar/model/AppBarIcon.dart';
import 'package:ody_flutter_app/presentation/components/button/fill/FillButton.dart';
import 'package:ody_flutter_app/presentation/components/button/model/ButtonNotifier.dart';
import 'package:ody_flutter_app/presentation/components/button/model/ButtonSizeType.dart';
import 'package:ody_flutter_app/presentation/components/button/model/ButtonState.dart';
import 'package:ody_flutter_app/presentation/components/loading/CircleLoading.dart';
import 'package:ody_flutter_app/presentation/features/setting/medication/provider/RegisterMedicineProvider.dart';
import 'package:ody_flutter_app/presentation/features/setting/medication/widget/MedicationName.dart';
import 'package:ody_flutter_app/presentation/features/setting/medication/widget/MedicationTime.dart';
import 'package:ody_flutter_app/presentation/features/setting/medication/widget/MedicationYoil.dart';
import 'package:ody_flutter_app/presentation/models/UiState.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/permission/PermissionUtil.dart';
import 'package:ody_flutter_app/presentation/utils/snackbar/SnackBarUtil.dart';
import 'package:permission_handler/permission_handler.dart';

class AddMedicationScreen extends HookConsumerWidget {
  const AddMedicationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiState = ref.watch(registerMedicineProvider);
    final uiStateRead = ref.read(registerMedicineProvider.notifier);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        uiState.when(
          success: (_) {
            Navigator.of(context).pop(uiStateRead.responseData);
            uiStateRead.init();
          },
          failure: (event) => SnackBarUtil.show(context, event.errorMessage),
        );
      });
    }, [uiState]);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: getColorScheme(context).colorUI01,
      appBar: IconTitleIconAppBar(
        leadingIcon: AppBarIcon(
          path: 'assets/imgs/icon_back.svg',
          onPressed: () => Navigator.of(context).pop(),
          tint: getColorScheme(context).black,
        ),
        title: getAppLocalizations(context).add_medication_title,
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.fromLTRB(40, 0, 40, 24),
          child: FillButton(
            text: getAppLocalizations(context).common_complete,
            type: ButtonSizeType.Normal,
            onPressed: () async {
              final isGranted = await PermissionUtil.requestNotificationPermission();
              if (isGranted) {
                uiStateRead.register();
              } else {
                openAppSettings();
              }
            },
            buttonProvider: StateNotifierProvider<ButtonNotifier, ButtonState>(
              (_) => ButtonNotifier(
                state: ButtonState.Activated,
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            children: const [
              MedicationName(),
              SizedBox(height: 32),
              MedicationYoil(),
              SizedBox(height: 32),
              MedicationTime(),
            ],
          ),
          if (uiState is Loading) const CircleLoading(),
        ],
      ),
    );
  }
}
