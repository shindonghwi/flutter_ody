import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:odac_flutter_app/presentation/components/appbar/IconTitleTextAppBar.dart';
import 'package:odac_flutter_app/presentation/components/appbar/model/AppBarIcon.dart';
import 'package:odac_flutter_app/presentation/components/textfield/OutlineDefaultTextField.dart';
import 'package:odac_flutter_app/presentation/components/textfield/model/TextFieldState.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class EditMyWeightScreen extends HookWidget {
  const EditMyWeightScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final helpText = useState('');
    final fieldState = useState(TextFieldState.Complete);

    return Scaffold(
      backgroundColor: getColorScheme(context).colorUI01,
      appBar: IconTitleTextAppBar(
        leadingIcon: AppBarIcon(
          path: 'assets/imgs/icon_back.svg',
          onPressed: () => Navigator.of(context).pop(),
        ),
        actionText: getAppLocalizations(context).common_complete,
        actionTextCallback: () {},
        title: getAppLocalizations(context).edit_my_weight_title,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.only(top: 32, left: 24, right: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getAppLocalizations(context).edit_my_info_title_weight,
                style: getTextTheme(context).c2r.copyWith(
                      color: getColorScheme(context).colorText,
                    ),
              ),
              const SizedBox(height: 16),
              OutlineDefaultTextField(
                controller: useTextEditingController(text: 'weight'),
                textInputType: TextInputType.datetime,
                textInputAction: TextInputAction.next,
                autoFocus: true,
                onChanged: (String value) {},
                limit: 10,
                maxLine: 1,
                helpText: helpText.value,
                fieldState: fieldState.value,
                onNextAction: () => FocusManager.instance.primaryFocus?.nextFocus(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
