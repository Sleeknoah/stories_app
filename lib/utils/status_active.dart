import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:stories_app/viewmodel/providers/providers.dart';

import '../model/response/friends.dart';

class ActiveStatus extends ConsumerStatefulWidget {
  final bool isGrey;
  final List<Friends> list;
  const ActiveStatus({
    required this.isGrey,
    required this.list,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ActiveStatusState();
}

class _ActiveStatusState extends ConsumerState<ActiveStatus> {
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    print(ref.read(statusLengthProvider));
    _timer = Timer(
        const Duration(
          milliseconds: 5000,
        ), () {
      if (ref.read(statusIndexProvider) < ref.read(statusLengthProvider) - 1) {
        ref.read(statusIndexProvider.notifier).state += 1;
      } else {
        if (ref.read(statusPageProvider) <
            ref.read(statusPageLengthProvider) - 1) {
          ref.read(statusIndexProvider.notifier).state = 0;
          final nextPage = ref
              .read(statusPageProvider.notifier)
              .update((state) => state + 1);

          ///Set new status length
          ref.read(statusLengthProvider.notifier).state =
              widget.list[nextPage].status.length;
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      lineHeight: 2,
      animation: true,
      animationDuration: 5000,
      percent: 1,
      progressColor: Colors.white,
      backgroundColor: widget.isGrey == true ? Colors.grey : Colors.black26,
      barRadius: const Radius.circular(20),
      padding: EdgeInsets.zero,
    );
  }
}
