import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/presentation/components/textfield/InputTextField.dart';
import 'package:ody_flutter_app/presentation/features/setting/medication/provider/RegisterMedicineProvider.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

class MedicationName extends HookConsumerWidget {
  const MedicationName({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final medicationName = useState('');

    final uiStateRead = ref.read(registerMedicineProvider.notifier);

    return Container(
      padding: const EdgeInsets.fromLTRB(35, 24, 35, 0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                getAppLocalizations(context).add_medication_name,
                style: getTextTheme(context).t4m.copyWith(
                      color: getColorScheme(context).colorText,
                    ),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                getAppLocalizations(context).add_medication_name_description,
                style: getTextTheme(context).c2r.copyWith(
                      color: getColorScheme(context).neutral70,
                    ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          InputTextField(
            autoFocus: true,
            hint: getAppLocalizations(context).add_medication_name_input_hint,
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.text,
            limit: 15,
            onChanged: (String value) {
              medicationName.value = value;
              uiStateRead.updateMedicineName(medicationName.value);
            },
            regList: [
              RegExp(r'^[ㄱ-ㅎ가-힣0-9a-zA-Z\s]+$'),
            ],
          )
        ],
      ),
    );
  }
}
