import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:odac_flutter_app/app/feature/components/appbar/LeftIconAppBar.dart';
import 'package:odac_flutter_app/app/feature/components/button/FillButton.dart';
import 'package:odac_flutter_app/app/feature/components/common/ShowAnimation.dart';
import 'package:odac_flutter_app/app/feature/welcome/model/PageAction.dart';
import 'package:odac_flutter_app/app/feature/welcome/widget/provider/gender/SelectorGenderProvider.dart';
import 'package:odac_flutter_app/app/utils/Common.dart';
import 'package:provider/provider.dart';

/**
 * @feature: 성별 선택화면
 * @author: 2023/02/14 1:42 PM donghwishin
 */
class WelcomeGender extends StatelessWidget {
  final Function changePage;

  WelcomeGender({Key? key, required this.changePage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SelectorGenderProvider()),
      ],
      child: Scaffold(
        backgroundColor: getColorScheme(context).background,
        appBar: LeftIconAppBar(
          leftIcon: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 20,
              color: getColorScheme(context).onBackground,
            ),
            onPressed: () async => changePage(context, PageAction.PREVIOUS),
          ),
        ),
        body: WillPopScope(
          onWillPop: () async => changePage(context, PageAction.PREVIOUS),
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 48),
            color: getColorScheme(context).background,
            width: getMediaQuery(context).size.width,
            height: getMediaQuery(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TitleText(context),
                _GenderSelector(),
              ],
            ),
          ),
        ),
        bottomSheet: BottomButton(context),
      ),
    );
  }

  /** 상단 텍스트 ( 질문영역 )*/
  Widget TitleText(BuildContext context) {
    return ShowAnimation(
      child: Text(
        getApplocalizations(context).welcome_text_gender_title,
        style: getTextTheme(context).headlineSmall?.copyWith(
              color: getColorScheme(context).onBackground,
              fontWeight: FontWeight.w500,
            ),
      ),
      type: ShowAnimationType.UP,
      initDelay: showDuration,
    );
  }

  /** 바텀 버튼 ( 다음 ) */
  Widget BottomButton(BuildContext context) {
    return Container(
      color: getColorScheme(context).onPrimary,
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 40),
      child: FillButton(
        onTap: () async => changePage(context, PageAction.NEXT),
        child: Text(
          getApplocalizations(context).common_next,
          style: getTextTheme(context).titleLarge?.copyWith(
                color: getColorScheme(context).onPrimary,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }
}

class _GenderSelector extends HookWidget {
  _GenderSelector({Key? key}) : super(key: key);

  late SelectorGenderProvider _selectorGenderProvider;

  @override
  Widget build(BuildContext context) {
    _selectorGenderProvider =
        Provider.of<SelectorGenderProvider>(context, listen: false);

    return Consumer<SelectorGenderProvider>(
      builder: (context, provider, child) {
        return Container(
          margin: EdgeInsets.only(top: 80),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                flex: 1,
                child: GenderItem(
                  genderType: "남",
                  isSelected: _selectorGenderProvider.isSelected,
                  change: () => _selectorGenderProvider.change(),
                ),
              ),
              Flexible(
                flex: 1,
                child: GenderItem(
                  genderType: "여",
                  isSelected: !_selectorGenderProvider.isSelected,
                  change: () => _selectorGenderProvider.change(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class GenderItem extends HookWidget {
  final genderType;
  final isSelected;
  final Function()? change;

  GenderItem({
    Key? key,
    this.genderType,
    this.isSelected,
    this.change,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShowAnimation(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: this.isSelected
                ? getColorScheme(context).primary
                : getColorScheme(context).outlineVariant,
            width: 1,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          color: this.isSelected
              ? getColorScheme(context).primary
              : getColorScheme(context).onPrimary,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => this.change!(),
            child: SizedBox(
              width: 100,
              height: 100,
              child: Center(
                widthFactor: 1.0,
                heightFactor: 1.0,
                child: Text(
                  this.genderType,
                  style: getTextTheme(context).headlineLarge?.copyWith(
                        color: this.isSelected
                            ? getColorScheme(context).background
                            : getColorScheme(context).outlineVariant,
                      ),
                ),
              ),
            ),
          ),
        ),
      ),
      type: ShowAnimationType.UP,
      initDelay: showDuration,
    );
  }
}
