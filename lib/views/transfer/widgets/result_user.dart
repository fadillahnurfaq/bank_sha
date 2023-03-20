import 'package:bank_sha/models/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/selected_transfer/selected_transfer_bloc.dart';
import '../../../bloc/user/user_bloc.dart';
import '../../../utils/theme.dart';
import 'result_card.dart';

class ResultUser extends StatelessWidget {
  const ResultUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Result',
          style: blackTextStyle.copyWith(
            fontSize: 16,
            fontWeight: semiBold,
          ),
        ),
        const SizedBox(
          height: 14,
        ),
        BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserFailedState) {
              return const SizedBox();
            }
            if (state is UserLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UserSuccessState) {
              return Center(
                child: Wrap(
                  spacing: 17.0,
                  runSpacing: 17.0,
                  children: state.users
                      .map((user) => BlocSelector<SelectedTransferBloc,
                              UserModel?, UserModel?>(
                            selector: (state) {
                              return state;
                            },
                            builder: (context, state) {
                              return Material(
                                color: whiteColor,
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    context.read<SelectedTransferBloc>().add(
                                        ChangeSelectedTransferEvent(
                                            user: user));
                                  },
                                  child: ResultCard(
                                      user: user,
                                      isSelected: state == null
                                          ? false
                                          : user.id == state.id),
                                ),
                              );
                            },
                          ))
                      .toList(),
                ),
              );
            }
            return const SizedBox();
          },
        )
      ],
    );
  }
}
