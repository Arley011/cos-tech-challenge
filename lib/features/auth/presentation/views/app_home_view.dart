import 'package:cos_test/features/auth/presentation/blocs/auth/auth_cubit.dart';
import 'package:cos_test/features/auth/presentation/views/login_view.dart';
import 'package:cos_test/features/auth/presentation/widgets/auth_failure_placeholder.dart';
import 'package:cos_test/features/vin_search/presentation/views/vin_search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// This view is the main entry point of the app.
/// It is responsible for displaying the login view or the VIN search view
/// based on the authentication state.
/// It uses the [AuthCubit] to manage the authentication state.
class AppHomeView extends StatefulWidget {
  const AppHomeView({super.key});

  @override
  State<AppHomeView> createState() => _AppHomeViewState();
}

class _AppHomeViewState extends State<AppHomeView> {
  @override
  void initState() {
    context.read<AuthCubit>().init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        switch (state) {
          case AuthInitial():
          case AuthLoading():
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case AuthUnauthenticated():
            return LoginView.page();
          case AuthSuccess():
            return VinSearchView.page();
          case AuthFailure():
            return AuthFailurePlaceholder(
              onRetry: () => _handleAuthRetry(context),
              errorMessage: state.error,
            );
        }
      },
    );
  }

  void _handleAuthRetry(BuildContext context) {
    context.read<AuthCubit>().init();
  }
}
