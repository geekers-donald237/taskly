import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:taskly/presentation/components/buttons/large_button.dart';

import '../../../core/services/utils/custom_sizer.dart';

import 'package:flutter/material.dart';

import '../../../localization/app_localization.dart';

class LoginOrRegisterPage extends StatelessWidget {
  const LoginOrRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: getWidth(5),
                  ),
                  const Icon(Icons.arrow_back_ios)
                ],
              ),
              SizedBox(
                height: getHeight(5),
              ),
              Text(
                AppLocalizations.of(context)!.translate('welcome_to_uptodo'),
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
                AppLocalizations.of(context)!.translate('login_or_create_account'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontSize: 16.dp,
                ),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.all(6.dp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    LargeButton(
                      onPressed: () {},
                      titleText: AppLocalizations.of(context)!.translate('login'),
                      backgroundColor: Theme.of(context).primaryColor,
                      textColor: Theme.of(context).colorScheme.onSecondary,
                    ),
                    SizedBox(height: getHeight(2.5)),
                    LargeButton(
                      onPressed: () {},
                      titleText: AppLocalizations.of(context)!.translate('create_account'),
                      backgroundColor: Colors.transparent,
                      textColor: Theme.of(context).colorScheme.onSecondary,
                      borderColor: Theme.of(context).primaryColor,
                    ),
                    SizedBox(height: getHeight(5)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
