import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/user/user_bloc.dart';
import '../../../utils/theme.dart';
import 'recent_user_card.dart';

class RecentUser extends StatelessWidget {
  const RecentUser({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      if (state is UserFailedState) {
        return const SizedBox();
      }
      if (state is UserLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is UserSuccessState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Users',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Column(
              children: state.users
                  .map((user) => RecentUserCard(user: user))
                  .toList(),
            )
          ],
        );
      }
      return const SizedBox();
    });
  }
}
