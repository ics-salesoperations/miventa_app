import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SOIconLabel extends StatelessWidget {
  const SOIconLabel({
    super.key,
    required this.label,
    required this.asset,
    required this.size,
  });

  final String label;
  final String asset;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          asset,
          width: size.width,
          height: size.height,
        ),
        const SizedBox(
          width: 3,
        ),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'CronosLPro',
              color: Colors.white,
              overflow: TextOverflow.fade,
            ),
            maxLines: 3,
          ),
        ),
      ],
    );
  }
}
