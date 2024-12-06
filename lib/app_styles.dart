import 'package:flutter/material.dart';
import 'package:miventa_app/size_configs.dart';

const Color kPrimaryColor = Color(0xff00c7ff);
const Color kSecondaryColor = Color(0xff001950);
const Color kFourColor = Color(0xFF808184);
const Color kThirdColor = Color(0xFFffbe00);
const Color kScaffoldBackground = Color(0xffffffff);
const Color kScaffoldSecondaryBackground = Color(0xFF00377d);
const Color kCardColor=Color(0xff3264dc);

final kTitle = TextStyle(
  fontFamily: 'CronosSPro',
  fontSize: SizeConfig.blockSizeH! * 7,
  color: kSecondaryColor,
);

final kTitle2 = TextStyle(
  fontFamily: 'CronosSPro',
  fontSize: SizeConfig.blockSizeH!,
  color: kPrimaryColor,
  fontWeight: FontWeight.bold,
);

final kTitle3 = TextStyle(
  fontFamily: 'CronosLPro',
  fontSize: SizeConfig.blockSizeH!,
  color: kSecondaryColor,
);

final kBodyText1 = TextStyle(
  color: kSecondaryColor,
  fontSize: SizeConfig.blockSizeH! * 4.5,
  fontWeight: FontWeight.bold,
);

final kBodyText2 = TextStyle(
  color: kSecondaryColor,
  fontSize: SizeConfig.blockSizeH! * 4,
  fontWeight: FontWeight.bold,
);

final kBodyText3 = TextStyle(
    color: kSecondaryColor,
    fontSize: SizeConfig.blockSizeH! * 3.8,
    fontWeight: FontWeight.normal);

final kInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(12),
  borderSide: BorderSide.none,
);

final kInputHintStyle = kBodyText2.copyWith(
  fontWeight: FontWeight.normal,
  color: kSecondaryColor.withOpacity(0.5),
);
