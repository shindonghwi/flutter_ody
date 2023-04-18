import 'package:flutter/material.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class HomeTodayNews extends StatelessWidget {
  const HomeTodayNews({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<String> news = [
      "고혈압",
      "식습관 변경",
      "혈압약 추천",
    ];

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 23, top: 45),
            child: Text(
              getAppLocalizations(context).home_today_news,
              style: getTextTheme(context).h4b.copyWith(
                    color: getColorScheme(context).colorText,
                  ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            children: news.asMap().entries.map((item) {
              int index = item.key;
              var data = item.value;
              return Container(
                margin: EdgeInsets.only(left: index == 0 ? 25 : 7, top: 12),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                  color: getColorScheme(context).white,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: getColorScheme(context).primary100,
                    width: 1,
                  ),
                ),
                child: Text(
                  "#${data}",
                  style: getTextTheme(context).l3.copyWith(
                        color: getColorScheme(context).primary100,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }).toList(),
          ),

          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: (){},
              child: Container(
                width: double.infinity,
                height: 140,
                margin: EdgeInsets.only(top: 15, left: 20, right: 20),
                padding: EdgeInsets.fromLTRB(17, 22, 12, 9),
                decoration: BoxDecoration(
                  color: getColorScheme(context).primary100,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Stack(
                  children: [
                    Text(
                      "\"고혈압\"을 유발 할 수 있는\n피해야 할 음식 9가지",
                      style: getTextTheme(context).l1.copyWith(
                            color: getColorScheme(context).white,
                          ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Image.asset(
                        'assets/imgs/home_news_image.png',
                        width: 130,
                        height: 81,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
