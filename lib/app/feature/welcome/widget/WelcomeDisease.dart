import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/app/feature/components/button/FillButton.dart';
import 'package:odac_flutter_app/app/feature/components/common/ShowUp.dart';
import 'package:odac_flutter_app/app/feature/welcome/model/PageAction.dart';
import 'package:odac_flutter_app/l10n/Common.dart';

/**
 * @feature: 질환 선택 화면
 * @author: 2023/02/14 1:42 PM donghwishin
 */
class WelcomeDisease extends StatelessWidget {
  final Function changePage;

  WelcomeDisease({Key? key, required this.changePage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => changePage(context, PageAction.PREVIOUS),
        child: Container(
          color: Theme.of(context).colorScheme.background,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(top: 120, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TitleText(context),
              SizedBox(height: 80),
              DiseaseSelector(context),
              SizedBox(height: 120),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      color: Theme.of(context).colorScheme.onPrimary,
                      size: 16,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "asdasd",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: BottomButton(context),
    );
  }

  /** 상단 텍스트 ( 질문영역 )*/
  Widget TitleText(BuildContext context) {
    return ShowUp(
      child: Text(
        getApplocalizations(context)?.welcome_text_disease ?? "",
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
              fontWeight: FontWeight.w700,
            ),
      ),
      delay: showUpDuration,
    );
  }

  /** 기본 값, 질환 목록 뷰 */
  Widget DiseaseSelector(BuildContext context) {
    List<String> diseaseList =
        getApplocalizations(context)?.welcome_disease_items.split(",") as List<String>;

    return ShowUp(
      child: Wrap(
        runSpacing: 12,
        spacing: 4, // space between items
        children: diseaseList
            .map(
              (diseaseName) => DiseaseItem(diseaseName: diseaseName),
            )
            .toList(),
      ),
      delay: showUpDuration,
    );
  }

  /** 바텀 버튼 ( 다음 ) */
  Widget BottomButton(BuildContext context) {
    return FillButton(
      onTap: () {
        changePage(context, PageAction.NEXT);
      },
      child: Text(
        getApplocalizations(context)?.welcome_button_next ?? "",
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
      ),
    );
  }
}

class DiseaseItem extends StatefulWidget {
  final String diseaseName;

  DiseaseItem({Key? key, required this.diseaseName}) : super(key: key);

  @override
  State<DiseaseItem> createState() => _DiseaseItemState();
}

class _DiseaseItemState extends State<DiseaseItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        // color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(1),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            debugPrint("onTap: ${widget.diseaseName}");
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  color: Theme.of(context).colorScheme.primary,
                  size: 16,
                ),
                SizedBox(width: 4),
                Text(
                  widget.diseaseName,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class DiseaseItem extends StatefulWidget {
//   final String diseaseName;
//
//   DiseaseItem({Key? key, required this.diseaseName}) : super(key: key);
//
//   @override
//   State<DiseaseItem> createState() => _DiseaseItemState();
// }
//
// class _DiseaseItemState extends State<DiseaseItem> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 4),
//       decoration: BoxDecoration(
//         // color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
//         border: Border.all(
//           color: Theme.of(context).colorScheme.primary.withOpacity(1),
//           width: 1,
//         ),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: () {
//             debugPrint("onTap: ${widget.diseaseName}");
//           },
//           child: Container(
//             margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(
//                   Icons.add,
//                   color: Theme.of(context).colorScheme.primary,
//                   size: 16,
//                 ),
//                 SizedBox(width: 4),
//                 Text(
//                   widget.diseaseName,
//                   style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                         color: Theme.of(context).colorScheme.primary,
//                       ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
