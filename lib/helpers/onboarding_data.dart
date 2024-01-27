import '../models/onboarding.dart';
import 'app_contants.dart';

List<Onboarding> onboardingData = const [
  Onboarding(
    index: 0,
    illustration: AppConstants.onboarding1,
    title: <String>['Discover ', 'SoleCapsule'],
    subtitle: 'Step into SoleCapsule for an elevated smart home experience.',
  ),
  Onboarding(
    index: 1,
    illustration: AppConstants.onboarding2,
    title: <String>['Personalized ', 'Comfort'],
    subtitle:
        'Tailor your space and unlock room settings, creating a home that adapts to your lifestyle.',
  ),
  Onboarding(
    index: 2,
    illustration: AppConstants.onboarding3,
    title: <String>['Secure & ', 'Smart Living'],
    subtitle:
        'Join SoleCapsule to monitor your home remotely, ensuring safety and optimizing energy.',
  ),
];
