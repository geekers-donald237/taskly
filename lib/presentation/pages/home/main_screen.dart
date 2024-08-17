import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:taskly/presentation/pages/auth/login_page.dart';
import 'package:taskly/presentation/pages/tasks/tasks_screen.dart';
import 'package:taskly/presentation/blocs/connectivity_bloc/connectivity_bloc.dart';
import 'package:taskly/core/services/notification/toast_service.dart';
import '../../../data/sources/local/local_storage_impl.dart';
import '../../../localization/app_localization.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final String? userToken = LocalStorageImpl().getToken();
      if (userToken == null) {
        _navigateToLogin();
      } else {
        _navigateToTasks();
      }
    });
  }

  void _navigateToLogin() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
          (route) => false,
    );
  }

  void _navigateToTasks() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const TasksScreen()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityBloc, ConnectivityState>(
      listener: (context, state) {
        if (state is ConnectivitySuccessState) {
          ToastService().showSnackbar(
            context,
            AppLocalizations.of(context)!.translate('connected_to_internet'),
          );
        } else if (state is ConnectivityFailureState) {
          ToastService().showSnackbar(
            context,
            AppLocalizations.of(context)!.translate('lost_connection_to_internet'),
            isError: true,
          );
        }
      },
      child: Scaffold(
        body: Center(
          child: Text(
            'Taskly',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.dp,
              fontWeight: FontWeight.w500,
              overflow: TextOverflow.clip,
            ),
          ),
        ),
      ),
    );
  }
}
