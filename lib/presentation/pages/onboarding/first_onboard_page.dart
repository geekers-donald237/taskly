import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import 'package:taskly/core/services/utils/custom_sizer.dart';
import 'package:taskly/presentation/pages/onboarding/second_onboard_page.dart';
import 'package:taskly/presentation/pages/onboarding/third_onboard_page.dart';

import '../../../core/generics/gen/assets.gen.dart';
import '../../../localization/app_localization.dart';
import '../../components/buttons/custom_button.dart';
import '../../components/indicator/onboard_indicator.dart';
import '../../components/text_buttons/skip_text_button.dart';

import 'package:flutter/material.dart';

class FirstOnboardPage extends StatelessWidget {
  const FirstOnboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(6.dp),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SkipTextButton(
                  text: AppLocalizations.of(context)!.translate('skip'),
                  onPressed: () {
                    Navigator.of(context).push(SwipeablePageRoute(
                      canOnlySwipeFromEdge: true,
                      builder: (BuildContext context) => const ThirdOnboardPage(),
                    ));
                  },
                ),
                Column(
                  children: [
                    Assets.images.onboard1
                        .image(width: getWidth(60), height: getHeight(35)),
                    SizedBox(
                      height: getHeight(5),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const OnBoardIndicator(
                          isActive: true,
                        ),
                        SizedBox(
                          width: getWidth(3),
                        ),
                        const OnBoardIndicator(
                          isActive: false,
                        ),
                        SizedBox(
                          width: getWidth(3),
                        ),
                        const OnBoardIndicator(
                          isActive: false,
                        )
                      ],
                    ),
                    SizedBox(
                      height: getHeight(5),
                    ),
                    Text(
                      AppLocalizations.of(context)!.translate('manage_tasks'),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.surface,
                        fontSize: 30.dp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: getHeight(4),
                    ),
                    Text(
                      AppLocalizations.of(context)!.translate('manage_tasks_description'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontSize: 16.dp,
                      ),
                    ),
                    SizedBox(height: getHeight(20)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      onPressed: () {
                        Navigator.of(context).push(SwipeablePageRoute(
                          canOnlySwipeFromEdge: true,
                          builder: (BuildContext context) =>
                              const SecondOnboardPage(),
                        ));
                      },
                      titleText: AppLocalizations.of(context)!.translate('next'),
                    ),
                    SizedBox(
                      width: getWidth(0.5),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
