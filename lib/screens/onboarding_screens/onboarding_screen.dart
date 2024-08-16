import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

import '../../helpers/onboarding_data.dart';
import '../../provider/theme_mode_provider.dart';
import '../../widgets/general_widgets/padded_screen_widget.dart';
import '../../widgets/onboarding_widgets/onboarding_button.dart';
import '../../widgets/onboarding_widgets/onboarding_indicator.dart';
import '../../widgets/onboarding_widgets/onboarding_widget.dart';

class OnboardingScreen extends StatefulWidget {
  static const routeName = '/OnboardingScreen';

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;

  final carouselController = CarouselSliderController();

  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, resetThemeMode);
    initVideoPlayer();
  }

  void initVideoPlayer() async {
    String videoUrl = 'assets/videos/sole.mp4';

    _controller = VideoPlayerController.asset(videoUrl);

    await _controller.initialize().then((_) {
      setState(() {});
      _controller.play();
      _controller.setLooping(true);
      _controller.setVolume(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Visibility(
            visible: currentIndex == 0,
            child: SizedBox(
              height: 100.h,
              width: 100.w,
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
          Visibility(
            visible: currentIndex == 0,
            child: Container(
              height: 100.h,
              width: 100.w,
              color: Colors.black54,
            ),
          ),
          SafeArea(
            child: PaddedScreenWidget(
              padTop: false,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/WelcomeScreen'),
                        child: Text(
                          'SKIP',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color:
                                      currentIndex == 0 ? Colors.white : null),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  CarouselSlider(
                    carouselController: carouselController,
                    items: onboardingData
                        .map(
                          (e) => OnboardingWidget(
                            onboarding: e,
                            isColorOpposite: currentIndex == 0,
                          ),
                        )
                        .toList(),
                    options: CarouselOptions(
                      initialPage: 0,
                      viewportFraction: 1,
                      enlargeCenterPage: false,
                      reverse: false,
                      height: 70.h,
                      enableInfiniteScroll: false,
                      onPageChanged: (index, _) =>
                          setState(() => currentIndex = index),
                    ),
                  ),
                  // const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OnboardingIndicator(
                        index: 0,
                        currentIndex: currentIndex,
                      ),
                      OnboardingIndicator(
                        index: 1,
                        currentIndex: currentIndex,
                      ),
                      OnboardingIndicator(
                        index: 2,
                        currentIndex: currentIndex,
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Visibility(
                        visible: currentIndex > 0,
                        child: IconButton(
                          onPressed: () {
                            carouselController.previousPage(
                              duration: const Duration(milliseconds: 800),
                              curve: Curves.fastOutSlowIn,
                            );
                          },
                          icon: SvgPicture.asset(
                              'assets/icons/arrow_backward.svg'),
                        ),
                      ),
                      OnboardingButton(
                        width: currentIndex == 0 ? 90.w : 75.w,
                        colorsOpposite: currentIndex == 0 ? true : false,
                        onTap: () {
                          if (currentIndex != 2) {
                            carouselController.nextPage(
                              duration: const Duration(milliseconds: 800),
                              curve: Curves.fastOutSlowIn,
                            );
                          } else {
                            Navigator.pushNamed(context, '/WelcomeScreen');
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void resetThemeMode() {
    var thmPvr = Provider.of<ThemeModeProvider>(context, listen: false);

    thmPvr.resetThemeMode();
  }
}
