import 'package:cos_test/core/app_storage/app_storage.dart';
import 'package:cos_test/core/cos_challenge.dart';
import 'package:cos_test/features/auth/presentation/blocs/auth/auth_cubit.dart';
import 'package:cos_test/features/vin_search/data/repositories/vin_search_repository_impl.dart';
import 'package:cos_test/features/vin_search/data/services/vin_search_api_service.dart';
import 'package:cos_test/features/vin_search/data/services/vin_search_cache_service.dart';
import 'package:cos_test/features/vin_search/presentation/blocs/vin_search_cubit.dart';
import 'package:cos_test/features/vin_search/presentation/views/auction_view.dart';
import 'package:cos_test/features/vin_search/presentation/views/similar_results_view.dart';
import 'package:cos_test/features/vin_search/presentation/widgets/vin_search_error_widget.dart';
import 'package:cos_test/features/vin_search/presentation/widgets/vin_search_form.dart';
import 'package:cos_test/features/vin_search/presentation/widgets/vin_search_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A view for searching VINs.
/// Simple view with a text field and a button.
/// Shows a loading indicator while searching.
/// In case of error, shows an error message.
class VinSearchView extends StatefulWidget {
  const VinSearchView._({
    super.key,
  });

  static const String routeName = 'vin-search';

  static Widget page({Key? key}) {
    return BlocProvider<VinSearchCubit>(
      create: (context) {
        final authState = context.read<AuthCubit>().state;
        final sessionUser =
            authState is AuthSuccess ? authState.sessionUser : null;

        return VinSearchCubit(
          VinSearchRepositoryImpl(
            apiService: VinSearchApiService(
              client: CosChallenge.httpClient,
              user: sessionUser?.email,
            ),
            cacheService: VinSearchCacheService(),
          ),
        );
      },
      child: VinSearchView._(key: key),
    );
  }

  static PageRoute<T> route<T>() {
    return MaterialPageRoute<T>(
      builder: (_) => BlocProvider<VinSearchCubit>(
        create: (context) {
          final authState = context.read<AuthCubit>().state;
          final sessionUser =
              authState is AuthSuccess ? authState.sessionUser : null;

          return VinSearchCubit(
            VinSearchRepositoryImpl(
              apiService: VinSearchApiService(
                client: CosChallenge.httpClient,
                user: sessionUser?.email,
              ),
              cacheService: VinSearchCacheService(),
            ),
          );
        },
        child: const VinSearchView._(),
      ),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  State<VinSearchView> createState() => _VinSearchViewState();
}

class _VinSearchViewState extends State<VinSearchView> {
  final vinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return VinSearchScaffold(
      onLogout: context.read<AuthCubit>().logout,
      child: BlocConsumer<VinSearchCubit, VinSearchState>(
        listener: _handleVinSearchListener,
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenHeight * 0.25,
                ),
                VinSearchForm(
                  isLoading: state is VinSearchLoadingState,
                  vinController: vinController,
                  onSearchPressed: _handleSearchPressed,
                ),
                if (state is VinSearchErrorState)
                  VinSearchErrorWidget(error: state.error),
                TextButton(
                  onPressed: () {
                    AppStorage.instance.deleteAll();
                  },
                  child: const Text('Reset'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _handleVinSearchListener(BuildContext context, VinSearchState state) {
    ScaffoldMessenger.of(context).clearSnackBars();
    if (state is VinSearchSuccessState) {
      Navigator.of(context).push(
        AuctionView.route(auctionData: state.auctionData),
      );
    } else if (state is VinSearchSimilarResultsState) {
      Navigator.of(context).push(
        SimilarResultsView.route(similarVehicles: state.similarVehicles),
      );
    }
  }

  void _handleSearchPressed() {
    context.read<VinSearchCubit>().searchVin(vinController.text);
  }

  @override
  void dispose() {
    vinController.dispose();

    super.dispose();
  }
}
