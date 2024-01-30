import 'firebase_constants.dart';

class UserId {
  static String getUid() {
    return FirebaseConstants.authInstance.currentUser?.uid ?? "";
  }
}
