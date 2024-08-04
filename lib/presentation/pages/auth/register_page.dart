import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import 'package:taskly/presentation/pages/auth/login_page.dart';
import '../../../core/services/utils/custom_sizer.dart';
import '../../../localization/app_localization.dart';
import '../../components/buttons/large_button.dart';
import '../../components/buttons/login_google.dart';
import '../../components/text_fields/custom_text_field.dart';
import '../../components/text_fields/password_text_field.dart';


class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

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
                SizedBox(height: getHeight(2)),
                Text(
                  AppLocalizations.of(context)!.translate('register'),
                  style: TextStyle(
                    fontSize: 32.dp,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                SizedBox(height: getHeight(2)),
                CustomTextField(
                  label: AppLocalizations.of(context)!.translate('username'),
                  placeholder: AppLocalizations.of(context)!.translate('enter_your_username'),
                ),
                CustomTextField(
                  label: AppLocalizations.of(context)!.translate('email'),
                  placeholder: AppLocalizations.of(context)!.translate('enter_your_email'),
                ),
                PasswordTextField(
                  label: AppLocalizations.of(context)!.translate('password'),
                  placeholder: AppLocalizations.of(context)!.translate('enter_your_password'),
                ),
                PasswordTextField(
                  label: AppLocalizations.of(context)!.translate('confirm_password'),
                  placeholder: AppLocalizations.of(context)!.translate('confirm_your_password'),
                ),
                SizedBox(height: getHeight(5)),
                LargeButton(
                  onPressed: () {},
                  titleText: AppLocalizations.of(context)!.translate('register'),
                  backgroundColor: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).colorScheme.onSecondary,
                ),
                SizedBox(height: getHeight(5)),
                Row(
                  children: <Widget>[
                    Expanded(child: Divider(color: Colors.white70)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        AppLocalizations.of(context)!.translate('or'),
                        style: TextStyle(color: Colors.white70 , fontSize: 16.dp),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.white70)),
                  ],
                ),
                SizedBox(height: getHeight(5)),
                LoginGoogle(
                  titleText: AppLocalizations.of(context)!.translate('register_with_google'),
                  onPressed: () {},
                ),
                SizedBox(height: getHeight(8)),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(SwipeablePageRoute(
                      canOnlySwipeFromEdge: true,
                      builder: (BuildContext context) => const LoginPage(),
                    ));
                  },
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: AppLocalizations.of(context)!.translate('already_have_account'),
                            style: TextStyle(color: Colors.white70),
                          ),
                          TextSpan(
                            text: AppLocalizations.of(context)!.translate('login'),
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
