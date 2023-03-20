import 'package:bank_sha/cubit/onboarding/onboarding_cubit.dart';
import 'package:bank_sha/utils/buttons/q_filled_button.dart';
import 'package:bank_sha/utils/buttons/q_text_button.dart';
import 'package:bank_sha/utils/state_util.dart';
import 'package:bank_sha/views/auth/sign_in/signin_view.dart';
import 'package:bank_sha/views/auth/sign_up/signup_view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/theme.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> images = context.read<OnboardingCubit>().images;
    List<String> titles = context.read<OnboardingCubit>().titles;
    List<String> subtitles = context.read<OnboardingCubit>().subtitles;

    CarouselController carouselController = CarouselController();

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<OnboardingCubit, int>(
            builder: (context, state) {
              return CarouselSlider(
                carouselController: carouselController,
                items: List.generate(
                  images.length,
                  (index) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        images[state],
                        height: 331.0,
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 24,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                          vertical: 24,
                        ),
                        child: Column(
                          children: [
                            Text(
                              titles[state],
                              style: blackTextStyle.copyWith(
                                fontSize: 20,
                                fontWeight: semiBold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 26,
                            ),
                            Text(
                              subtitles[state],
                              style: greyTextStyle.copyWith(
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: state == 2 ? 38 : 50,
                            ),
                            state == 2
                                ? Column(
                                    children: [
                                      QFilledButton(
                                        title: "Get Started",
                                        onPressed: () {
                                          Get.to(page: const SignUpView());
                                          carouselController.animateToPage(0);
                                        },
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      QTextButton(
                                        title: "Sign In",
                                        onPressed: () {
                                          Get.to(page: const SignInView());
                                          carouselController.animateToPage(0);
                                        },
                                      )
                                    ],
                                  )
                                : Row(
                                    children: [
                                      Container(
                                        width: 12,
                                        height: 12,
                                        margin: const EdgeInsets.only(
                                          right: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: state == 0
                                              ? blueColor
                                              : blackColor,
                                        ),
                                      ),
                                      Container(
                                        width: 12,
                                        height: 12,
                                        margin: const EdgeInsets.only(
                                          right: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: state == 1
                                              ? blueColor
                                              : blackColor,
                                        ),
                                      ),
                                      Container(
                                        width: 12,
                                        height: 12,
                                        margin: const EdgeInsets.only(
                                          right: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: state == 2
                                              ? blueColor
                                              : blackColor,
                                        ),
                                      ),
                                      const Spacer(),
                                      QFilledButton(
                                        width: 150.0,
                                        title: "Continue",
                                        onPressed: () {
                                          carouselController.nextPage();
                                        },
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                options: CarouselOptions(
                  height: Get.height,
                  viewportFraction: 1,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    context.read<OnboardingCubit>().changeCurrentIndex(index);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
