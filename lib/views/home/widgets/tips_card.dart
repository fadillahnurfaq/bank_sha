import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/tips/tip_bloc.dart';
import '../../../utils/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class TipsCard extends StatelessWidget {
  const TipsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TipBloc()..add(TipGetEvent()),
      child: BlocBuilder<TipBloc, TipState>(
        builder: (context, state) {
          if (state is TipLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is TipSucessState) {
            return Center(
              child: Wrap(
                spacing: 30.0,
                runSpacing: 18.0,
                children: state.tips
                    .map(
                      (tips) => Material(
                        color: whiteColor,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: InkWell(
                          onTap: () async {
                            if (await canLaunchUrl(
                                Uri.parse(tips.url.toString()))) {
                              launchUrl(Uri.parse(tips.url.toString()));
                            }
                          },
                          child: SizedBox(
                            height: 176.0,
                            width: 155.0,
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(20.0),
                                  ),
                                  child: Image.network(
                                    tips.thumbnail!,
                                    height: 110.0,
                                    width: 155.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  height: 12.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: Text(
                                    tips.title!,
                                    style: blackTextStyle.copyWith(
                                      fontWeight: medium,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
