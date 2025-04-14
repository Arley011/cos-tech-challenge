import 'package:cos_test/core/shared_widgets/keyboard_dismisser.dart';
import 'package:cos_test/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:cos_test/features/auth/data/services/local_auth_cache_service.dart';
import 'package:cos_test/features/auth/presentation/blocs/auth/auth_cubit.dart';
import 'package:cos_test/features/auth/presentation/views/app_home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const CosChallengeApp());
}

class CosChallengeApp extends StatelessWidget {
  const CosChallengeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: BlocProvider<AuthCubit>(
        create: (_) => AuthCubit(
          AuthRepositoryImpl(
            cacheService: LocalAuthCacheService(),
          ),
        ),
        child: const MaterialApp(
          home: AppHomeView(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
