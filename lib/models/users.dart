import 'box.dart';
import 'delivery_details.dart';
import 'user_details.dart';

class Users {
  final String id;
  final List<Box> boxes;
  final UserDetails userDetails;
  final DeliveryDetails deliveryDetails;

  const Users({
    required this.id,
    required this.boxes,
    required this.userDetails,
    required this.deliveryDetails,
  });

  factory Users.fromJson({required Map<String, dynamic> json}) {
    List<dynamic> parsedBoxes = json['boxes'] as List<dynamic>;
    List<Box> boxes = parsedBoxes
        .map(
          (e) => Box.fromJson(json: e),
        )
        .toList();

    Map<String, dynamic> parsedDetails =
        json['deliveryDetails'] as Map<String, dynamic>;

    Map<String, dynamic> userDetails =
        json['userDetails'] as Map<String, dynamic>;

    return Users(
      id: json['id'] as String,
      boxes: boxes,
      userDetails: UserDetails.fromJson(json: userDetails),
      deliveryDetails: DeliveryDetails.fromJson(json: parsedDetails),
    );
  }

  Map<String, dynamic> toJson(
    String? uid, {
    required String encryptedPassword,
  }) {
    return {
      'id': uid,
      'boxes': boxes,
      'userDetails': userDetails.toJson(
        encryptedPassword: encryptedPassword,
      ),
      'deliveryDetails': deliveryDetails.toJSon(),
    };
  }
}
