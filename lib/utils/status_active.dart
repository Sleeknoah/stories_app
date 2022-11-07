import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:stories_app/viewmodel/providers/providers.dart';

class ActiveStatus extends ConsumerStatefulWidget {
  final bool isGrey;
  const ActiveStatus({
    required this.isGrey,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ActiveStatusState();
}

class _ActiveStatusState extends ConsumerState<ActiveStatus> {
  late Timer _timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(ref.read(statusIndexProvider));
    _timer = Timer(
        const Duration(
          milliseconds: 10000,
        ), () {
      if (ref.read(statusIndexProvider) < ref.read(statusLengthProvider)) {
        ref.read(statusIndexProvider.notifier).state += 1;
      } else {
        print('Finished');
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      lineHeight: 2,
      animation: true,
      animationDuration: 10000,
      percent: 1,
      progressColor: Colors.white,
      backgroundColor: widget.isGrey == true ? Colors.grey : Colors.black26,
      barRadius: const Radius.circular(20),
      padding: EdgeInsets.zero,
    );
  }
}
