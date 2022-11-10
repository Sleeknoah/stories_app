import 'package:auto_size_text/auto_size_text.dart';
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
    final statusPage = ref.watch(statusPageProvider);
    print('pageIndex $pageIndex');
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            color: listItem[statusPage].status[statusIndex].image.isNotEmpty
                ? Colors.black
                : BackgroundColorSelector.selector(
                    listItem[statusPage].status[statusIndex].bgColor),
            child: listItem[statusPage].status[statusIndex].image.isNotEmpty
                ? createImage(
                    context,
                    listItem[statusPage].status[statusIndex].image,
                    ref,
                    listItem[statusPage].status[statusIndex].text)
                : createText(
                    context, listItem[statusPage].status[statusIndex].text),
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (ref.read(statusIndexProvider) != 0) {
                        ref.read(statusIndexProvider.notifier).state -= 1;
                      } else {
                        if (ref.read(statusPageProvider) != 0) {
                          ref.read(statusIndexProvider.notifier).state = 0;
                          final nextPage =
                              ref.read(statusPageProvider.notifier).state -= 1;

                          ///Set new status length
                          ref.read(statusLengthProvider.notifier).state =
                              listItem[nextPage].status.length;
                        }
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
                      if (ref.read(statusIndexProvider) <
                          ref.read(statusLengthProvider) - 1) {
                        ref.read(statusIndexProvider.notifier).state += 1;
                      } else {
                        if (ref.read(statusPageProvider) <
                            ref.read(statusPageLengthProvider) - 1) {
                          ref.read(statusIndexProvider.notifier).state = 0;
                          final nextPage =
                              ref.read(statusPageProvider.notifier).state += 1;

                          ///Set new status length
                          ref.read(statusLengthProvider.notifier).state =
                              listItem[nextPage].status.length;
                        }
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
                          listItem[statusPage].status.length,
                          (index) => Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: index == statusIndex
                                  ? ActiveStatus(
                                      isGrey: listItem[statusPage]
                                              .status[statusIndex]
                                              .image
                                              .isNotEmpty
                                          ? true
                                          : false,
                                      list: listItem,
                                    )
                                  : Container(
                                      height: 2,
                                      decoration: BoxDecoration(
                                          color: index < statusIndex
                                              ? Colors.white
                                              : listItem[statusPage]
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
                                NetworkImage(listItem[statusPage].picture),
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
                                  listItem[statusPage].name,
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
                                  listItem[statusPage]
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
                          ),
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

  Widget createText(BuildContext context, String text) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 36.0,
        ),
        child: AutoSizeText(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline5?.copyWith(
                fontFamily: 'UberMoveText',
                color: Colors.white,
              ),
        ),
      ),
    );
  }

  createImage(
      BuildContext context, String imageUrl, WidgetRef ref, String text) {
    return Stack(
      children: [
        Center(
          child: Image.network(
            imageUrl,
            loadingBuilder: (context, child, loading) {
              if (loading == null) {
                return child;
              } else {
                return const CircularProgressIndicator(
                  color: Colors.white,
                );
              }
            },
            errorBuilder: (context, child, loading) {
              return const CircularProgressIndicator(
                color: Colors.white,
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 72.0,
            horizontal: 36.0,
          ),
          child: Column(
            children: [
              const Spacer(),
              Center(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontFamily: 'UberMoveText',
                        color: Colors.white,
                      ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
