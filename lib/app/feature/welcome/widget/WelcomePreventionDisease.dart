import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:odac_flutter_app/app/feature/components/appbar/LeftIconAppBar.dart';
import 'package:odac_flutter_app/app/feature/components/button/FillButton.dart';
import 'package:odac_flutter_app/app/feature/components/common/ShowAnimation.dart';
import 'package:odac_flutter_app/app/feature/welcome/model/PageAction.dart';
import 'package:odac_flutter_app/app/feature/welcome/widget/provider/disease/SelectorPreventionDiseaseProvider.dart';
import 'package:odac_flutter_app/app/utils/Common.dart';
import 'package:provider/provider.dart';

/**
 * @feature: 예방질환 선택 화면
 * @author: 2023/02/14 1:42 PM donghwishin
 */
class WelcomePreventionDisease extends StatelessWidget {
  final Function changePage;

  WelcomePreventionDisease({Key? key, required this.changePage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => SelectorPreventionDiseaseProvider(context)),
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
            color: getColorScheme(context).background,
            width: getMediaQuery(context).size.width,
            height: getMediaQuery(context).size.height,
            padding: EdgeInsets.only(top: 48),
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
        getApplocalizations(context).welcome_text_prevention_disease_title,
        style: getTextTheme(context).headlineSmall?.copyWith(
              color: getColorScheme(context).onBackground,
              fontWeight: FontWeight.w500,
            ),
      ),
      type: ShowAnimationType.UP,
      initDelay: showDuration,
    );
  }

  /** 서브 텍스트 ( 질문영역 )*/
  Widget SubTitleText(BuildContext context) {
    return ShowAnimation(
      child: Container(
        margin: EdgeInsets.only(top: 10),
        child: Text(
          getApplocalizations(context).welcome_text_prevention_disease_subtitle,
          style: getTextTheme(context).bodyMedium?.copyWith(
                color: getColorScheme(context).outlineVariant,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
      type: ShowAnimationType.UP,
      initDelay: showDuration,
    );
  }

  /** 바텀 버튼  */
  Widget BottomButton(BuildContext context) {
    return Container(
      color: getColorScheme(context).onPrimary,
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            flex: 1,
            child: FillButton(
              onTap: () async => changePage(context, PageAction.NEXT),
              backgroundColor: getColorScheme(context).outline,
              child: Text(
                "${getApplocalizations(context).common_nobody}!",
                style: getTextTheme(context).titleLarge?.copyWith(
                      color: getColorScheme(context).onPrimary,
                    ),
              ),
            ),
          ),
          SizedBox(width: 30),
          Flexible(
            flex: 1,
            child: FillButton(
              onTap: () async => changePage(context, PageAction.NEXT),
              child: Text(
                getApplocalizations(context).common_next,
                style: getTextTheme(context).titleLarge?.copyWith(
                      color: getColorScheme(context).onPrimary,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DiseaseSelector extends HookWidget {
  _DiseaseSelector({Key? key}) : super(key: key);

  late List<String> diseaseLists;
  late SelectorPreventionDiseaseProvider _selectorPreventionDiseaseProvider;

  @override
  Widget build(BuildContext context) {
    _selectorPreventionDiseaseProvider =
        Provider.of<SelectorPreventionDiseaseProvider>(context, listen: false);

    return Consumer<SelectorPreventionDiseaseProvider>(
      builder: (context, provider, child) {
        return Expanded(
          child: Container(
            child: GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 30),
              physics: BouncingScrollPhysics(),
              itemCount: _selectorPreventionDiseaseProvider.diseaseList.length,
              itemBuilder: (BuildContext ctx, int idx) {
                return _DiseaseItem(
                    diseaseName: _selectorPreventionDiseaseProvider
                        .diseaseList[idx].diseaseName);
              },
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: getMediaQuery(context).size.width * 0.4,
                crossAxisSpacing: 34,
                mainAxisSpacing: 30,
                childAspectRatio: 3,
              ),
            ),
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
    return Consumer<SelectorPreventionDiseaseProvider>(
      builder: (context, provider, child) {
        return ShowAnimation(
          child: Container(
            height: 50,
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
          ),
          type: ShowAnimationType.UP,
          initDelay: showDuration,
        );
      },
    );
  }
}
