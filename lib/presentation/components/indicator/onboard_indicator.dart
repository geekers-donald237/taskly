import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:taskly/core/services/utils/custom_sizer.dart';

class OnBoardIndicator extends StatelessWidget {
  final bool isActive;

  const OnBoardIndicator({super.key, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getWidth(10),
      height: getHeight(0.5),
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Theme.of(context).colorScheme.onSurface,
        border: Border.all(
          color: isActive ? Colors.white : Theme.of(context).colorScheme.onSurface,
        ),
        borderRadius: BorderRadius.all(Radius.circular(30.dp)),
      ),
    );
  }
}
