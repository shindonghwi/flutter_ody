import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/data/models/me/ResponseMeMedicineModel.dart';
import 'package:odac_flutter_app/presentation/components/loading/CircleLoading.dart';
import 'package:odac_flutter_app/presentation/features/list/medication/provider/MedicineCheckListProvider.dart';
import 'package:odac_flutter_app/presentation/features/list/medication/provider/MedicineListProvider.dart';
import 'package:odac_flutter_app/presentation/features/list/medication/provider/MedicineScreenModeProvider.dart';
import 'package:odac_flutter_app/presentation/features/list/medication/widget/MedicineAppBar.dart';
import 'package:odac_flutter_app/presentation/features/list/medication/widget/MedicineBottomContent.dart';
import 'package:odac_flutter_app/presentation/features/list/medication/widget/MedicineMainContent.dart';
import 'package:odac_flutter_app/presentation/models/UiState.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/utils/CollectionUtil.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';
import 'package:odac_flutter_app/presentation/utils/snackbar/SnackBarUtil.dart';

class MedicationListScreen extends HookConsumerWidget {
  const MedicationListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiState = ref.watch(medicineListProvider);
    final uiStateRead = ref.read(medicineListProvider.notifier);
    final checkListRead = ref.read(medicineCheckListProvider.notifier);
    final isEditModeRead = ref.read(medicineScreenModeProvider.notifier);
    final currentMedicineState = useState<List<ResponseMeMedicineModel>?>(null);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        uiState.when(
          success: (event) async {
            currentMedicineState.value = event.value;
            isEditModeRead.changeMode(false);
            if (uiStateRead.actionType == MedicineActionType.ADD_ITEM){
              SnackBarUtil.show(context, getAppLocalizations(context).message_success_register);
            } else if (uiStateRead.actionType == MedicineActionType.REMOVE_ITEM){
              checkListRead.clear();
              SnackBarUtil.show(context, getAppLocalizations(context).message_success_remove);
            }
          },
          failure: (event) => SnackBarUtil.show(context, event.errorMessage),
        );
      });
    }, [uiState]);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        uiStateRead.requestMedicineList();
      });
    }, []);

    return Scaffold(
      appBar: const MedicineAppBar(),
      backgroundColor: getColorScheme(context).colorUI01,
      body: Stack(
        children: [
          currentMedicineState.value == null
              ? uiState is Success<List<ResponseMeMedicineModel>>
              ? MedicineMainContent(items: uiState.value)
              : const SizedBox()
              : MedicineMainContent(items: currentMedicineState.value!),
          if (uiState is Success<List<ResponseMeMedicineModel>>)
            !CollectionUtil.isNullorEmpty(uiState.value)
                ? const MedicineBottomContent()
                : const SizedBox(),
          if (uiState is Loading) const CircleLoading(),
        ],
      ),
    );
  }
}
