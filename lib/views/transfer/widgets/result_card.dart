import 'package:flutter/material.dart';

import '../../../models/user/user_model.dart';
import '../../../utils/theme.dart';

class ResultCard extends StatelessWidget {
  final UserModel user;
  final bool isSelected;

  const ResultCard({
    super.key,
    required this.user,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 175.0,
      width: 155.0,
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border:
            Border.all(color: isSelected ? blueColor : whiteColor, width: 2.0),
      ),
      child: Column(
        children: [
          Container(
            height: 70.0,
            width: 70.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image:
                    user.profilePicture!.isEmpty || user.profilePicture == null
                        ? const AssetImage('assets/img_profile.png')
                        : NetworkImage(user.profilePicture!) as ImageProvider,
              ),
            ),
            child: user.verified == 1
                ? Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      height: 16.0,
                      width: 16.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: whiteColor,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.check_circle,
                          color: greenColor,
                          size: 14.0,
                        ),
                      ),
                    ),
                  )
                : null,
          ),
          const SizedBox(
            height: 13,
          ),
          Text(
            user.name.toString(),
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            "@${user.username}",
            style: greyTextStyle.copyWith(
              fontSize: 12,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
