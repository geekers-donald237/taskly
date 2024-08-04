import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../../core/generics/gen/assets.gen.dart';
import '../../../core/services/utils/custom_sizer.dart';

class LoginGoogle extends StatelessWidget {
  final String titleText;
  final VoidCallback onPressed;

  const LoginGoogle({
    super.key,
    required this.titleText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: getHeight(6),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(4.dp),
          border: Border.all(color: Theme.of(context).primaryColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.images.google.image(),
            SizedBox(
              width: getWidth(5),
            ),
            Center(
              child: Text(
                titleText,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                    fontSize: 16.dp,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
