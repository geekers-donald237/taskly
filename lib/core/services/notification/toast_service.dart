import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../localization/app_localization.dart';

class ToastService {
  static final ToastService _instance = ToastService._internal();

  factory ToastService() {
    return _instance;
  }

  ToastService._internal();

  void showSnackbar(BuildContext context, String message,
      {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: isError ? Colors.red : Theme.of(context).primaryColor,
        action: SnackBarAction(
          label: AppLocalizations.of(context)!.translate('close'),
          textColor: Colors.white,
          onPressed: () {},
        ),
      ),
    );
  }
  void showStatusLoader(String title) {
    EasyLoading.show(
        indicator: const CircularProgressIndicator(),
        status: title,
        maskType: EasyLoadingMaskType.black,
        dismissOnTap: false);
  }
}
