import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:miventa_app/app_styles.dart';

class buildUserInfoDisplay extends StatelessWidget {
  final String getValue;
  final String title;
  final String icono;
  final double screenWidth;

  const buildUserInfoDisplay(
      {Key? key,
      required this.getValue,
      required this.title,
      required this.icono,
      required this.screenWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              child: Container(
                padding: const EdgeInsets.all(10),
                width: screenWidth * 0.8,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: kScaffoldBackground,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xffcccaaa),
                      blurRadius: 5,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(icono,
                            height: 50, semanticsLabel: 'Label'),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(title,
                              style: const TextStyle(
                                fontFamily: 'CronosLPro',
                                color: kSecondaryColor,
                              )),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                            child: Text(getValue,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 5,
                                style: const TextStyle(
                                  fontFamily: 'CronosSPro',
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                )))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
