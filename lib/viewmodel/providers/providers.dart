import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stories_app/model/repository/status_repository.dart';
import 'package:stories_app/model/service/status_service.dart';

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
