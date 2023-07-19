import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioForDaysModel.dart';
import 'package:ody_flutter_app/presentation/components/loading/CircleLoading.dart';
import 'package:ody_flutter_app/presentation/components/toast/Toast.dart';
import 'package:ody_flutter_app/presentation/features/main/home/widget/card/CardRecordItems.dart';
import 'package:ody_flutter_app/presentation/features/main/home/widget/card/CardTodayRecord.dart';
import 'package:ody_flutter_app/presentation/features/main/provider/ForDaysBioInfoProvider.dart';
import 'package:ody_flutter_app/presentation/models/UiState.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiState = ref.watch(forDaysBioInfoProvider);
    final currentState = useState<ResponseBioForDaysModel?>(null);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        uiState.when(
          success: (event) {
            currentState.value = event.value;
          },
          failure: (event) {
            ToastUtil.errorToast( event.errorMessage);
          },
        );
      });
      return null;
    }, [uiState]);

    return Scaffold(
      backgroundColor: getColorScheme(context).colorUI03,
      body: SafeArea(
        child: Stack(
          children: [
            mainContent(
              uiState is Success<ResponseBioForDaysModel?>
                  ? uiState.value
                  : ResponseBioForDaysModel(steps: [], bloodPressures: [], glucoses: []),
            ),
            if (uiState is Loading) const Center(child: CircleLoading())
          ],
        ),
      ),
    );
  }

  Widget mainContent(ResponseBioForDaysModel? model) {
    return Container(
      margin: const EdgeInsets.only(left: 24, right: 24),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            CardTodayRecord(model: model!),
            CardRecordItems(model: model),
          ],
        ),
      ),
    );
  }
}
