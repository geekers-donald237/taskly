import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../../core/services/utils/custom_sizer.dart';
import '../../../localization/app_localization.dart';
import '../../components/buttons/large_button.dart';
import '../../components/text_fields/custom_text_field.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10.dp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Text(
                  AppLocalizations.of(context)!.translate('forgot_password'),
                  style: TextStyle(
                    fontSize: 32.dp,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                SizedBox(height: getHeight(10)),
                CustomTextField(
                  label: AppLocalizations.of(context)!.translate('email'),
                  placeholder: AppLocalizations.of(context)!
                      .translate('enter_your_email'),
                ),
                SizedBox(height: getHeight(10)),
                LargeButton(
                  onPressed: () {},
                  titleText: AppLocalizations.of(context)!.translate('next'),
                  backgroundColor: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).colorScheme.onSecondary,
                ),
                SizedBox(height: getHeight(4)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
