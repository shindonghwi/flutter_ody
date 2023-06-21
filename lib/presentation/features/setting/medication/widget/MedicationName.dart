import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/components/textfield/OutlineDefaultTextField.dart';
import 'package:odac_flutter_app/presentation/components/textfield/model/TextFieldState.dart';
import 'package:odac_flutter_app/presentation/features/setting/medication/provider/RegisterMedicineProvider.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class MedicationName extends HookConsumerWidget {
  const MedicationName({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final helpText = useState('');
    final fieldState = useState(TextFieldState.Default);
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
          OutlineDefaultTextField(
            controller: useTextEditingController(text: ''),
            hint: getAppLocalizations(context).add_medication_name_input_hint,
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.done,
            autoFocus: true,
            onChanged: (String value) {
              medicationName.value = value;
              uiStateRead.updateMedicineName(medicationName.value);
            },
            limit: 20,
            maxLine: 1,
            helpText: helpText.value,
            fieldState: fieldState.value,
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(r'[^ㄱ-ㅎ가-힣a-zA-Z0-9_]+')),
            ],
            onDoneAction: () => FocusManager.instance.primaryFocus?.unfocus(),
          )
        ],
      ),
    );
  }
}
