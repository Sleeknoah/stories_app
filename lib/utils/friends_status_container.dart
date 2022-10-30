import 'package:flutter/material.dart';

import 'circle_row.dart';

class FriendStatus extends StatelessWidget {
  final String? imgUrl;
  final String? avatarUrl;
  final numStatus;
  const FriendStatus(
      {Key? key, required this.imgUrl, required this.avatarUrl, this.numStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(
                  imgUrl ?? '',
                ),
                fit: BoxFit.cover,
              ),
            ),
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
}
