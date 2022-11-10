import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stories_app/model/repository/status_repository.dart';
import 'package:stories_app/model/service/status_service.dart';
import 'package:stories_app/viewmodel/state_classes/shared_pref_notifier.dart';

import '../../model/response/data.dart';
import '../state_classes/status_state_notifier.dart';
import '../states/retrieval_state.dart';

///Set loading to true initially
final loadingProvider = StateProvider.autoDispose<bool>((ref) => true);

///Set retrieval state_classes to initial
///states are initial, loading, loaded, error
final retrieveStateProvider =
    StateProvider.autoDispose<RetrieveState>((ref) => RetrieveState.loading);

///Dependency injection of status repository done here with riverpod
final statusRepositoryProvider = Provider.autoDispose<StatusRepository>((ref) {
  return StatusRepository(statusService: StatusService());
});

///Status state notifier provider
final statusProvider = StateNotifierProvider<StatusStateNotifier, Data?>(
  (ref) => StatusStateNotifier(null),
);

final futureProvider = FutureProvider.autoDispose((ref) {
  final repo = ref.watch(statusRepositoryProvider);
  return repo.getStatus();
});

final statusIndexProvider = StateProvider.autoDispose<int>((ref) {
  return 0;
});
final statusLengthProvider = StateProvider.autoDispose<int>((ref) {
  return 0;
});

final statusPageProvider = StateProvider.autoDispose<int>((ref) {
  return 0;
});
final statusPageLengthProvider = StateProvider.autoDispose<int>((ref) {
  return 0;
});
final sharedPrefs = FutureProvider<SharedPreferences>(
    (ref) async => await SharedPreferences.getInstance());

final isDarkThemeProvider =
    StateNotifierProvider<SharedPrefNotifier, bool>((ref) {
  final sharedPref = ref.watch(sharedPrefs).maybeWhen(
        data: (value) => value,
        orElse: () => null,
      );
  return SharedPrefNotifier(preferences: sharedPref);
});
