import 'package:bank_sha/bloc/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/user/user_model.dart';
import '../../../utils/state_util.dart';
import '../../../utils/theme.dart';
import '../../profile/profile_view.dart';

class TopProfile extends StatelessWidget {
  const TopProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthSuccessState) {
          UserModel user = state.user;

          return Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Howdy.",
                      style: greyTextStyle.copyWith(fontSize: 16.0),
                    ),
                    const SizedBox(
                      height: 2.0,
                    ),
                    Text(
                      state.user.name.toString(),
                      style: blackTextStyle.copyWith(
                        fontSize: 20.0,
                        fontWeight: semiBold,
                      ),
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(
                        page: ProfileView(
                      user: user,
                    ));
                  },
                  child: Container(
                    height: 60.0,
                    width: 60.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: state.user.profilePicture == null
                            ? const AssetImage("assets/img_profile.png")
                            : NetworkImage(
                                state.user.profilePicture!,
                              ) as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: user.verified == 1
                        ? Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              width: 16.0,
                              height: 16.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: whiteColor,
                              ),
                              child: Icon(
                                Icons.check_circle,
                                color: greenColor,
                                size: 14.0,
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ),
                )
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
