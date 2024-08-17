import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

import '../../../core/services/notification/toast_service.dart';
import '../../../core/services/utils/custom_sizer.dart';
import '../../../localization/app_localization.dart';
import '../../blocs/auth_bloc/auth_bloc.dart';
import '../../blocs/auth_bloc/auth_event.dart';
import '../../blocs/auth_bloc/auth_state.dart';
import '../../blocs/connectivity_bloc/connectivity_bloc.dart';
import '../../components/buttons/large_button.dart';
import '../../components/buttons/login_google.dart';
import '../../components/text_fields/custom_text_field.dart';
import '../../components/text_fields/password_text_field.dart';
import '../home/main_screen.dart';
import 'forget_pwd_page.dart';
import 'register_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

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
                  AppLocalizations.of(context)!.translate('login'),
                  style: TextStyle(
                    fontSize: 32.dp,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                SizedBox(height: getHeight(2)),
                CustomTextField(
                  label: AppLocalizations.of(context)!.translate('email'),
                  placeholder: AppLocalizations.of(context)!
                      .translate('enter_your_email'),
                  controller: emailController,
                ),
                PasswordTextField(
                  label: AppLocalizations.of(context)!.translate('password'),
                  placeholder: AppLocalizations.of(context)!
                      .translate('enter_your_password'),
                  controller: passwordController,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(SwipeablePageRoute(
                          canOnlySwipeFromEdge: true,
                          builder: (BuildContext context) =>
                              const ForgotPasswordPage(),
                        ));
                      },
                      child: Text(
                        AppLocalizations.of(context)!
                            .translate('forgot_password'),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthFailureState) {
                      String errorMessage;
                      switch (state.message) {
                        case 'invalid_email_or_password':
                          errorMessage = AppLocalizations.of(context)!
                              .translate('invalid_email_or_password');
                          break;
                        case 'email_already_in_use':
                          errorMessage = AppLocalizations.of(context)!
                              .translate('email_already_in_use');
                          break;
                        case 'weak_password':
                          errorMessage = AppLocalizations.of(context)!
                              .translate('weak_password');
                          break;
                        default:
                          errorMessage = AppLocalizations.of(context)!
                              .translate('unknown_error');
                      }
                      ToastService()
                          .showSnackbar(context, errorMessage, isError: true);
                    } else if (state is AuthSuccessState) {
                      ToastService().showSnackbar(
                        context,
                        AppLocalizations.of(context)!
                            .translate('login_success'),
                      );
                      Navigator.of(context).pushAndRemoveUntil(
                        SwipeablePageRoute(
                          canOnlySwipeFromEdge: true,
                          builder: (BuildContext context) => const MainScreen(),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    }
                  },
                  child: BlocBuilder<ConnectivityBloc, ConnectivityState>(
                    builder: (context, connectivityState) {
                      return BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          if (state is AuthLoadingState) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          return LargeButton(
                            onPressed: () {
                              if (connectivityState
                                  is ConnectivitySuccessState) {
                                BlocProvider.of<AuthBloc>(context).add(
                                  LoginEvent(emailController.text,
                                      passwordController.text),
                                );
                              } else {
                                ToastService().showSnackbar(
                                  context,
                                  AppLocalizations.of(context)!
                                      .translate('lost_connection_to_internet'),
                                  isError: true,
                                );
                              }
                            },
                            titleText: AppLocalizations.of(context)!
                                .translate('login'),
                            backgroundColor: Theme.of(context).primaryColor,
                            textColor:
                                Theme.of(context).colorScheme.onSecondary,
                          );
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: getHeight(4)),
                Row(
                  children: <Widget>[
                    Expanded(child: Divider(color: Colors.white70)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        AppLocalizations.of(context)!.translate('or'),
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.white70)),
                  ],
                ),
                SizedBox(height: getHeight(4)),
                LoginGoogle(
                  titleText: AppLocalizations.of(context)!
                      .translate('login_with_google'),
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context).add(
                      SignInWithGoogleEvent(),
                    );
                  },
                ),
                SizedBox(height: getHeight(8)),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(SwipeablePageRoute(
                        canOnlySwipeFromEdge: true,
                        builder: (BuildContext context) => const RegisterPage(),
                      ));
                    },
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: AppLocalizations.of(context)!
                                .translate('dont_have_account'),
                            style: TextStyle(color: Colors.white70),
                          ),
                          TextSpan(
                            text: AppLocalizations.of(context)!
                                .translate('register'),
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
