import '../models/onboarding.dart';
import 'app_contants.dart';

List<Onboarding> onboardingData = const [
  Onboarding(
    index: 0,
    illustration: AppConstants.onboarding1,
    title: <String>['Discover ', 'Sole Pods'],
    subtitle:
        'Welcome to the Future of Sneaker Storage. Time to put your favorite pair on display',
  ),
  Onboarding(
    index: 1,
    illustration: AppConstants.onboarding2,
    title: <String>['Smart ', 'Control'],
    subtitle:
        'Effortlessly sync your Sole Pod with the app. Control lighting, access, and more—all from your phone.',
  ),
  Onboarding(
    index: 2,
    illustration: AppConstants.onboarding3,
    title: <String>['Secure & ', 'Smart Living'],
    subtitle:
        'Match your mood, your kicks, and your space with customizable LED lighting. Set the perfect vibe with a tap.',
  ),
];


//