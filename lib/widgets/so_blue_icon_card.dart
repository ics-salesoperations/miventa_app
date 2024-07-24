import 'package:flutter/material.dart';
import 'package:miventa_app/app_styles.dart';

class SOBlueIconCard extends StatelessWidget {
  const SOBlueIconCard({
    super.key,
    required this.content,
    required this.title,
    required this.asset,
  });

  final Widget content;
  final String title;
  final String asset;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width * 0.4,
      decoration: const BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
          topRight: Radius.circular(70),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey, offset: Offset(1.1, 1.1), blurRadius: 5.0),
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
          colors: [
            kPrimaryColor,
            kSecondaryColor,
          ],
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -30,
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(45),
              ),
              child: Center(
                child: Image.asset(
                  asset,
                  width: 70,
                  height: 70,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'CronosSPro',
                          color: Colors.white,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    Icon(
                      Icons.update_rounded,
                      color: kThirdColor.withOpacity(0.6),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(child: content),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
