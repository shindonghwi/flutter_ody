import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:odac_flutter_app/app/feature/components/button/FillButton.dart';
import 'package:odac_flutter_app/app/feature/components/common/ShowAnimation.dart';
import 'package:odac_flutter_app/app/feature/welcome/model/PageAction.dart';
import 'package:odac_flutter_app/app/feature/welcome/widget/provider/disease/SelectorMentalDiseaseProvider.dart';
import 'package:odac_flutter_app/app/utils/Common.dart';
import 'package:provider/provider.dart';

/**
 * @feature: 정신질환 선택 화면
 * @author: 2023/02/14 1:42 PM donghwishin
 */
class WelcomeMentalDisease extends StatelessWidget {
  final Function changePage;

  WelcomeMentalDisease({Key? key, required this.changePage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => SelectorMentalDiseaseProvider(context)),
      ],
      child: Scaffold(
        body: WillPopScope(
          onWillPop: () async => changePage(context, PageAction.PREVIOUS),
          child: Container(
            color: getColorScheme(context).background,
            width: getMediaQuery(context).size.width,
            height: getMediaQuery(context).size.height,
            padding: EdgeInsets.only(top: 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TitleText(context),
                SubTitleText(context),
                SizedBox(height: 78),
                _DiseaseSelector(),
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
        getApplocalizations(context).welcome_text_mental_disease_title,
        style: getTextTheme(context).titleLarge?.copyWith(
              color: getColorScheme(context).onBackground,
              fontWeight: FontWeight.w700,
            ),
      ),
      type: ShowAnimationType.UP,
      initDelay: showDuration,
    );
  }

  /** 서브 텍스트 ( 질문영역 )*/
  Widget SubTitleText(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: ShowAnimation(
        child: Text(
          getApplocalizations(context).welcome_text_mental_disease_subtitle,
          style: getTextTheme(context).bodyMedium?.copyWith(
                color: getColorScheme(context).outlineVariant,
                fontWeight: FontWeight.w500,
              ),
        ),
        type: ShowAnimationType.UP,
        initDelay: showDuration,
      ),
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
              ),
        ),
      ),
    );
  }
}

class _DiseaseSelector extends HookWidget {
  _DiseaseSelector({Key? key}) : super(key: key);

  late List<String> diseaseLists;
  late SelectorMentalDiseaseProvider _selectorMentalDiseaseProvider;

  @override
  Widget build(BuildContext context) {
    _selectorMentalDiseaseProvider =
        Provider.of<SelectorMentalDiseaseProvider>(context, listen: false);

    return Consumer<SelectorMentalDiseaseProvider>(
      builder: (context, provider, child) {
        return Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(0),
            physics: BouncingScrollPhysics(),
            itemCount: _selectorMentalDiseaseProvider.diseaseList.length,
            itemBuilder: (BuildContext ctx, int idx) {
              return _DiseaseItem(
                  diseaseName: _selectorMentalDiseaseProvider
                      .diseaseList[idx].diseaseName);
            },
          ),
        );
      },
    );
  }
}

class _DiseaseItem extends HookWidget {
  final diseaseName;

  _DiseaseItem({Key? key, this.diseaseName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectorMentalDiseaseProvider>(
      builder: (context, provider, child) {
        return Container(
          height: 50,
          margin: EdgeInsets.only(left: 70, right: 70, bottom: 30),
          decoration: BoxDecoration(
            border: Border.all(
              color: provider.isSelected(diseaseName)
                  ? getColorScheme(context).primary
                  : getColorScheme(context).outline.withOpacity(0.8),
              width: 1,
            ),
            color: provider.isSelected(diseaseName)
                ? getColorScheme(context).primary
                : getColorScheme(context).onPrimary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                provider.update(diseaseName);
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      provider.isSelected(diseaseName)
                          ? Icons.check
                          : Icons.add,
                      color: provider.isSelected(diseaseName)
                          ? getColorScheme(context).onPrimary
                          : getColorScheme(context).outline.withOpacity(0.8),
                      size: 16,
                    ),
                    SizedBox(width: 4),
                    Text(
                      diseaseName,
                      style: getTextTheme(context).bodyLarge?.copyWith(
                            color: provider.isSelected(diseaseName)
                                ? getColorScheme(context).onPrimary
                                : getColorScheme(context)
                                    .outline
                                    .withOpacity(0.8),
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
