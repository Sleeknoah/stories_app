import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stories_app/model/response/friends.dart';
import 'package:stories_app/utils/status_active.dart';
import 'package:stories_app/viewmodel/providers/providers.dart';

import '../utils/utils_classes/backgroundColor.dart';

class StatusScreen extends ConsumerWidget {
  final int pageIndex;
  final List<Friends> listItem;
  const StatusScreen({
    Key? key,
    required this.pageIndex,
    required this.listItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusIndex = ref.watch(statusIndexProvider);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            color: listItem[pageIndex].status[statusIndex].image.isNotEmpty
                ? Colors.black
                : BackgroundColorSelector.selector(
                    listItem[pageIndex].status[statusIndex].bgColor),
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      print("left");
                      if (ref.read(statusIndexProvider) != 0) {
                        ref.read(statusIndexProvider.notifier).state -= 1;
                      } else {
                        print('Finished');
                      }
                    },
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      print("right");
                      if (ref.read(statusIndexProvider) <
                          ref.read(statusLengthProvider)) {
                        ref.read(statusIndexProvider.notifier).state += 1;
                      } else {
                        print('Finished');
                      }
                    },
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                        left: 8.0,
                        right: 8.0,
                      ),
                      child: Row(
                        children: List.generate(
                          listItem[pageIndex].status.length,
                          (index) => Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: index == statusIndex
                                  ? ActiveStatus(
                                      isGrey: listItem[pageIndex]
                                              .status[statusIndex]
                                              .image
                                              .isNotEmpty
                                          ? true
                                          : false,
                                    )
                                  : Container(
                                      height: 2,
                                      decoration: BoxDecoration(
                                          color: index < statusIndex
                                              ? Colors.white
                                              : listItem[pageIndex]
                                                      .status[statusIndex]
                                                      .image
                                                      .isNotEmpty
                                                  ? Colors.grey
                                                  : Colors.black26,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.grey,
                            backgroundImage:
                                NetworkImage(listItem[pageIndex].picture),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            height: 40,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  listItem[pageIndex].name,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      ?.copyWith(
                                        fontFamily: 'UberMove',
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                                Text(
                                  listItem[pageIndex]
                                      .status[statusIndex]
                                      .timeStamp,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      ?.copyWith(
                                        fontFamily: 'UberMove',
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
