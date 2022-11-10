import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stories_app/screens/status_screen.dart';
import 'package:stories_app/viewmodel/providers/providers.dart';

import '../model/response/data.dart';

class StatusPageView extends ConsumerStatefulWidget {
  final int pageIndex;
  final Data listItem;
  const StatusPageView({
    required this.pageIndex,
    required this.listItem,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _StatusPageViewState();
}

class _StatusPageViewState extends ConsumerState<StatusPageView> {
  @override
  Widget build(BuildContext context) {
    final page = ref.watch(statusPageProvider);
    PageController _pageController = PageController(initialPage: page);
    ref.listen<int>(statusPageProvider, (previous, next) {
      print('listen $next');
      _pageController.animateToPage(
        next,
        duration: const Duration(
          milliseconds: 100,
        ),
        curve: Curves.easeIn,
      );
    });

    return PageView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: widget.listItem.profile.friends.length,
      controller: _pageController,
      onPageChanged: (index) {
        ref.read(statusIndexProvider.notifier).state = 0;
        ref.read(statusPageProvider.notifier).state = index;
        ref.read(statusLengthProvider.notifier).state =
            widget.listItem.profile.friends[index].status.length;
      },
      itemBuilder: (context, index) {
        return StatusScreen(
          pageIndex: index,
          listItem: widget.listItem.profile.friends,
        );
      },
    );
  }
}
