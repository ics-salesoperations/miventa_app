import 'package:flutter/material.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:skeleton_text/skeleton_text.dart';

class LoadingSkeleton extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius borderRadius;
  final Widget child;

  const LoadingSkeleton._({
    Key? key,
    this.width = double.infinity,
    this.height = double.infinity,
    this.borderRadius = const BorderRadius.all(Radius.circular(0)),
    this.child = const SizedBox(),
  }) : super(key: key);

  const LoadingSkeleton.square({
    required double width,
    required double height,
    Widget child = const SizedBox(),
  }) : this._(width: width, height: height, child: child);

  const LoadingSkeleton.rounded({
    required double width,
    required double height,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(15)),
    Widget child = const SizedBox(),
  }) : this._(
          width: width,
          height: height,
          borderRadius: borderRadius,
          child: child,
        );

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: kSecondaryColor.withOpacity(0.05),
          borderRadius: borderRadius,
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
