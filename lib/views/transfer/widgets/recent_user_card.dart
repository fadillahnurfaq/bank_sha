
import 'package:bank_sha/models/user/user_model.dart';
import 'package:flutter/material.dart';

import '../../../utils/theme.dart';

class RecentUserCard extends StatelessWidget {
  final UserModel user;
  const RecentUserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: whiteColor,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Row(
            children: [
              Container(
                height: 45.0,
                width: 45.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: user.profilePicture!.isEmpty ||
                            user.profilePicture == null
                        ? const AssetImage('assets/img_profile.png')
                        : NetworkImage(user.profilePicture!) as ImageProvider,
                  ),
                ),
              ),
              const SizedBox(
                width: 14.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 180,
                    child: Text(
                      user.name.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: blackTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  SizedBox(
                    width: 180,
                    child: Text(
                      "@${user.username}",
                      overflow: TextOverflow.ellipsis,
                      style: greyTextStyle.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 14.0,
                    color: greenColor,
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    'Verified',
                    style: greenTextStyle.copyWith(
                      fontSize: 11,
                      fontWeight: medium,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
