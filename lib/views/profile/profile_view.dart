import 'package:bank_sha/utils/buttons/q_text_button.dart';
import 'package:bank_sha/utils/dialog/loading.dart';
import 'package:bank_sha/utils/state_util.dart';
import 'package:bank_sha/utils/theme.dart';
import 'package:bank_sha/views/auth/sign_in/signin_view.dart';
import 'package:bank_sha/views/pin/pin_view.dart';
import 'package:bank_sha/views/profile/edit_pin_view.dart';
import 'package:bank_sha/views/profile/edit_profile_view.dart';
import 'package:bank_sha/views/profile/widgets/profile_menu_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../models/user/user_model.dart';
import '../../utils/snackbar/show_custom_snackbar.dart';

class ProfileView extends StatelessWidget {
  final UserModel user;
  const ProfileView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailedState) {
              Get.back();
              showCustomSnackbar(state.error);
            }

            if (state is AuthLoadingState) {
              Loading.show();
            }

            if (state is AuthInitialState) {
              Get.offAll(page: const SignInView());
            }
          },
          builder: (context, state) {
            if (state is AuthSuccessState) {
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 22.0),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 60.0,
                          width: 60.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: user.profilePicture == null
                                  ? const AssetImage("assets/img_profile.png")
                                  : NetworkImage(
                                      user.profilePicture!,
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
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          user.name!,
                          style: blackTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: medium,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ProfileMenuCard(
                          title: "Edit Profile",
                          imageUrl: 'assets/ic_edit_profile.png',
                          onTap: () async {
                            if (await Get.to(page: const PinView()) == true) {
                              Get.to(
                                  page: EditProfileView(
                                user: user,
                              ));
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        ProfileMenuCard(
                          title: "My PIN",
                          imageUrl: "assets/ic_pin.png",
                          onTap: () async {
                            if (await Get.to(page: const PinView()) == true) {
                              Get.to(page: const EditPinView());
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        ProfileMenuCard(
                          title: "Wallet Setting",
                          imageUrl: 'assets/ic_wallet.png',
                          onTap: () {},
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        ProfileMenuCard(
                          title: 'My Rewards',
                          imageUrl: 'assets/ic_reward.png',
                          onTap: () {},
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        ProfileMenuCard(
                          title: 'Help Center',
                          imageUrl: 'assets/ic_help.png',
                          onTap: () {},
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        ProfileMenuCard(
                          title: 'Log Out',
                          imageUrl: 'assets/ic_logout.png',
                          onTap: () {
                            context.read<AuthBloc>().add(AuthLogoutEvent());
                          },
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  QTextButton(
                    title: "Report a Problem",
                    onPressed: () {},
                  )
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
