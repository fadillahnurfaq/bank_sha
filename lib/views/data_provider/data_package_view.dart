import 'package:bank_sha/bloc/auth/auth_bloc.dart';
import 'package:bank_sha/bloc/data_plan/data_plan_bloc.dart';
import 'package:bank_sha/cubit/operator_card/selected_package_cubit.dart';
import 'package:bank_sha/models/data_plan/data_plan_form_model.dart';
import 'package:bank_sha/models/operator_card/operator_card_model.dart';
import 'package:bank_sha/utils/buttons/q_filled_button.dart';
import 'package:bank_sha/utils/form/q_form_field.dart';
import 'package:bank_sha/utils/snackbar/show_custom_snackbar.dart';
import 'package:bank_sha/utils/state_util.dart';
import 'package:bank_sha/utils/validator/validator.dart';
import 'package:bank_sha/views/data_provider/data_success_view.dart';
import 'package:bank_sha/views/data_provider/widgets/card_package.dart';
import 'package:bank_sha/views/pin/pin_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/theme.dart';

class DataPackageView extends StatelessWidget {
  final OperatorCardModel operatorCard;
  const DataPackageView({super.key, required this.operatorCard});

  @override
  Widget build(BuildContext context) {
    final phoneController = TextEditingController(text: '');
    final GlobalKey<FormState> formState = GlobalKey<FormState>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SelectedPackageCubit(),
        ),
        BlocProvider(
          create: (context) => DataPlanBloc(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Paket Data"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: formState,
            child: BlocConsumer<DataPlanBloc, DataPlanState>(
              listener: (context, state) {
                if (state is DataPlanFailedState) {
                  showCustomSnackbar(state.error);
                }
                if (state is DataPlanSuccessState) {
                  Get.offAll(page: const DataSuccessView());
                }
              },
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Phone Number",
                      style: blackTextStyle.copyWith(
                        fontWeight: semiBold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    QFormField(
                      controller: phoneController,
                      isShowTitle: false,
                      title: "+628",
                      validator: Validator.phone,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Select Package",
                      style: blackTextStyle.copyWith(
                        fontWeight: semiBold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Center(
                      child: Wrap(
                        spacing: 17.0,
                        runSpacing: 17.0,
                        children: operatorCard.dataPlans!
                            .map(
                              (dataPlan) => BlocSelector<SelectedPackageCubit,
                                  DataPlanModel?, DataPlanModel?>(
                                selector: (state) {
                                  return state;
                                },
                                builder: (context, state) {
                                  return CardPackage(
                                      dataPlan: dataPlan,
                                      isSelected: state == null
                                          ? false
                                          : dataPlan == state);
                                },
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const SizedBox(
                      height: 70.0,
                    )
                  ],
                );
              },
            ),
          ),
        ),
        floatingActionButton:
            BlocSelector<SelectedPackageCubit, DataPlanModel?, DataPlanModel?>(
          selector: (state) {
            return state;
          },
          builder: (context, state) {
            return state != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: QFilledButton(
                      title: "Continue",
                      onPressed: () async {
                        if (!formState.currentState!.validate()) {
                          FocusScope.of(context).unfocus();
                          return;
                        } else {
                          FocusScope.of(context).unfocus();
                          if (await Get.to(page: const PinView()) == true) {
                            // ignore: use_build_context_synchronously
                            final authState = context.read<AuthBloc>().state;
                            String pin = '';
                            if (authState is AuthSuccessState) {
                              pin = authState.user.pin!;
                            }
                            // ignore: use_build_context_synchronously
                            context.read<DataPlanBloc>().add(
                                  DataPlanPostEvent(
                                    DataPlanFormModel(
                                      dataPlanid: state.id,
                                      phoneNumber: phoneController.text,
                                      pin: pin,
                                    ),
                                  ),
                                );
                          }
                        }
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
