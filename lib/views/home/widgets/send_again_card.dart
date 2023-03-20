import 'package:bank_sha/models/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/user/user_bloc.dart';
import '../../../utils/theme.dart';

class SendAgainCard extends StatelessWidget {
  const SendAgainCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc()..add(UserGetRecentEvent()),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is UserSuccessState) {
            return SizedBox(
              height: 100.0,
              child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  UserModel user = state.users[index];
                  return Container(
                    height: 100.0,
                    width: 90.0,
                    padding: const EdgeInsets.all(5.0),
                    margin: const EdgeInsets.only(right: 10.0),
                    decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 45.0,
                          width: 45.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: user.profilePicture!.isEmpty
                                  ? const AssetImage("assets/img_profile.png")
                                  : NetworkImage(user.profilePicture!)
                                      as ImageProvider,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 13.0,
                        ),
                        Text(
                          "@${user.username}",
                          overflow: TextOverflow.ellipsis,
                          style: blackTextStyle.copyWith(
                            fontSize: 12.0,
                            fontWeight: medium,
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
