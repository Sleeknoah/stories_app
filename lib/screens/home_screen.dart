import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 24.0,
              ),
              child: profileRow(context),
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
          ],
        ),
      ),
    );
  }

  Widget profileRow(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        const CircleAvatar(
          radius: 25,
          backgroundColor: Colors.grey,
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
