// import 'package:bank_sha/bloc/user/selected_user_cubit.dart';
import 'package:bank_sha/bloc/selected_transfer/selected_transfer_bloc.dart';
import 'package:bank_sha/models/transfer/transfer_form_model.dart';
import 'package:bank_sha/utils/buttons/q_filled_button.dart';
import 'package:bank_sha/utils/form/q_form_field.dart';
import 'package:bank_sha/utils/state_util.dart';
import 'package:bank_sha/views/transfer/transfer_amount_view.dart';
import 'package:bank_sha/views/transfer/widgets/recent_user.dart';
import 'package:bank_sha/views/transfer/widgets/result_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/user/user_bloc.dart';
import '../../models/user/user_model.dart';
import '../../utils/theme.dart';

class TransferView extends StatelessWidget {
  const TransferView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    UserBloc userBloc = context.read<UserBloc>()
      ..add(
        UserGetRecentEvent(),
      );

    return BlocProvider(
      create: (context) => SelectedTransferBloc(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () async {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text("Transfer"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: StatefulBuilder(builder: (context, s) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Search",
                  style: blackTextStyle.copyWith(
                    fontWeight: semiBold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                QFormField(
                  isShowTitle: false,
                  controller: usernameController,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      userBloc.add(
                        UserGetByUsermameEvent(value),
                      );
                    } else {
                      userBloc.add(UserGetRecentEvent());
                    }
                    s(() {});
                  },
                ),
                const SizedBox(
                  height: 30.0,
                ),
                usernameController.text.isEmpty
                    ? const RecentUser()
                    : const ResultUser(),
                const SizedBox(
                  height: 50.0,
                )
              ],
            );
          }),
        ),
        floatingActionButton:
            BlocSelector<SelectedTransferBloc, UserModel?, UserModel?>(
          selector: (state) {
            return state;
          },
          builder: (context, state) {
            return state != null
                ? Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: QFilledButton(
                      title: "Continue",
                      onPressed: () {
                        Get.to(
                            page: TransferAmountView(
                                data: TransferFormModel(
                          sendTo: state.username,
                        )));
                      },
                    ),
                  )
                : const SizedBox();
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
