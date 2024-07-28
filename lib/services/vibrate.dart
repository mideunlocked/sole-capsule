import 'package:vibration/vibration.dart';

class Vibrate {
  static Future<void> vibrate({
    required int duration,
  }) async {
    bool? hasVibration = await Vibration.hasVibrator();

    if (hasVibration == true) {
      Vibration.vibrate(
        // duration: duration,
        pattern: [500, 1000, 500, 2000],
        intensities: [1, 255, 50, 100],
      );
    }
  }
}
