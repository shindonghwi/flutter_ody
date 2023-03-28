import 'package:flutter/material.dart';

/**
 * @feature: TextStyle 을 정의한 파일
 *
 * @author: 2023/02/07 5:49 PM donghwishin
 *
 * @description{
 *    color, underline 등 기능은 사용할때 custom 하여 사용한다.
 * }
 */
const defaultTextStyle = TextStyle(
  fontFamily: 'Pretendard',
  fontWeight: FontWeight.w100,
  overflow: TextOverflow.ellipsis,
  letterSpacing: 0
);

final headline1 = defaultTextStyle.copyWith(
  fontSize: 32,
  fontWeight: FontWeight.w600,
  height: 1.25
);

final headline2 = defaultTextStyle.copyWith(
  fontSize: 28,
  fontWeight: FontWeight.w600,
  height: 1.28
);

final headline3 = defaultTextStyle.copyWith(
  fontSize: 24,
  fontWeight: FontWeight.w600,
  height: 1.33
);

final title1 = defaultTextStyle.copyWith(
  fontSize: 22,
  fontWeight: FontWeight.w500,
  height: 1.27
);

final title2 = defaultTextStyle.copyWith(
  fontSize: 18,
  fontWeight: FontWeight.w500,
  height: 1.33
);

final title3 = defaultTextStyle.copyWith(
  fontSize: 16,
  fontWeight: FontWeight.w500,
  height: 1.5
);

final label1 = defaultTextStyle.copyWith(
  fontSize: 18,
  fontWeight: FontWeight.w500,
  height: 1.33
);

final label2 = defaultTextStyle.copyWith(
  fontSize: 16,
  fontWeight: FontWeight.w500,
  height: 1.5
);

final label3 = defaultTextStyle.copyWith(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  height: 1.42
);

final body1 = defaultTextStyle.copyWith(
  fontSize: 18,
  fontWeight: FontWeight.w400,
  height: 1.33
);

final body2 = defaultTextStyle.copyWith(
  fontSize: 16,
  fontWeight: FontWeight.w400,
  height: 1.5
);

final body3 = defaultTextStyle.copyWith(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  height: 1.42
);

final caption1 = defaultTextStyle.copyWith(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  height: 1.42
);

final caption2 = defaultTextStyle.copyWith(
  fontSize: 12,
  fontWeight: FontWeight.w400,
  height: 1.33
);

final caption3 = defaultTextStyle.copyWith(
  fontSize: 10,
  fontWeight: FontWeight.w400,
  height: 1.6
);
