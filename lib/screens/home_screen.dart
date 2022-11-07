import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stories_app/model/repository/status_repository.dart';
import 'package:stories_app/model/service/status_service.dart';
import 'package:stories_app/screens/status_screen.dart';
import 'package:stories_app/viewmodel/providers/providers.dart';

import '../model/response/data.dart';
import '../utils/friends_status_container.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // "ref" can be used in all life-cycles of a StatefulWidget.
    ///Retrieve data on start up
    ref
        .read(statusProvider.notifier)
        .retrieveStatus(StatusRepository(statusService: StatusService()));
  }

  @override
  Widget build(BuildContext context) {
    final loadingState = ref.watch(loadingProvider);
    final statusState = ref.watch(statusProvider);
    final data = statusState?.profile.friends;
    ref.listen<Data?>(statusProvider, (previous, next) {
      ///if there is data set loading to false state
      if (next != null) {
        ref.watch(loadingProvider.notifier).state = false;
        print("hello");
      }
    });

    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            ///Profile picture and theme toggle
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 24.0,
              ),
              child: profileRow(
                context,
                statusState,
              ),
            ),

            ///Sized Box
            const SizedBox(
              height: 30,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 8.0,
              ),
              child: Text(
                'Status',
                style: Theme.of(context).textTheme.headline5?.copyWith(
                      fontFamily: 'UberMoveText',
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
              ),
              child: Text(
                'View status of all your friends here.',
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      fontFamily: 'UberMove',
                      color: Colors.grey,
                    ),
              ),
            ),

            ///Sized Box
            const SizedBox(
              height: 30,
            ),

            ///Staggered GridView done here
            Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Visibility(
                      visible: loadingState,
                      child: const CircularProgressIndicator(),
                    ),
                  ),
                ),
                Visibility(
                  visible: !loadingState,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: MasonryGridView.builder(
                      gridDelegate:
                          const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      shrinkWrap: true,
                      primary: false,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      itemCount: data?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            int length = data[index].status.length - 1;
                            ref.watch(statusLengthProvider.notifier).state =
                                length;
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) {
                                return StatusScreen(
                                  pageIndex: index,
                                  listItem: data,
                                );
                              }),
                            );
                          },
                          child: FriendStatus(
                            imgUrl: data![index]
                                .status[data[index].status.length - 1]
                                .image,
                            numStatus: data[index].status.length,
                            friends: data[index],
                            status: data[index]
                                .status[data[index].status.length - 1],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget profileRow(BuildContext context, Data? statusState) {
    return Row(
      children: [
        const Spacer(),
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.grey,
          backgroundImage: NetworkImage(statusState?.profile.picture ?? ''),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 32.0,
          ),
          child: InkResponse(
            onTap: () {},
            child: const FaIcon(
              FontAwesomeIcons.moon,
            ),
          ),
        ),
      ],
    );
  }
}
