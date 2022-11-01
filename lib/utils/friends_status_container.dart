import 'package:flutter/material.dart';

import '../model/response/status.dart';
import 'circle_row.dart';

class FriendStatus extends StatelessWidget {
  final String? imgUrl;
  final String? avatarUrl;
  final numStatus;
  final Status status;
  const FriendStatus({
    Key? key,
    required this.imgUrl,
    required this.avatarUrl,
    this.numStatus,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(
                  imgUrl ?? '',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: imgUrl == ''
                ? textContainer(
                    status.text,
                    context,
                    status.bgColor,
                  )
                : null,
          ),
          Positioned(
            left: 10.0,
            top: 10.0,
            child: CurvedRow(
              numStatus: numStatus ?? 1,
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage(
                  avatarUrl ?? '',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget textContainer(String text, BuildContext context, String color) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColorSelector(color),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle2?.copyWith(
                  fontFamily: 'UberMoveText',
                  color: Colors.white,
                ),
          ),
        ),
      ),
    );
  }

  ///Set background color selector
  MaterialColor backgroundColorSelector(String color) {
    switch (color) {
      case 'amber':
        return Colors.amber;
      case 'blue':
        return Colors.blue;
      case 'green':
        return Colors.green;
      case 'purple':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}
