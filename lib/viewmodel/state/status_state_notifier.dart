import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stories_app/model/repository/status_repository.dart';

import '../../model/response/data.dart';

class StatusStateNotifier extends StateNotifier<Data?> {
  StatusStateNotifier(super.state);

  void retrieveStatus(StatusRepository repository) async {
    try{
      final response  = await repository.getStatus(data)
    }
  }
}
