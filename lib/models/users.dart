import 'package:hive/hive.dart';

import 'box.dart' as box;
import 'delivery_details.dart';
import 'user_details.dart';

part 'users.g.dart';

@HiveType(typeId: 1)
class Users {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final List<box.Box> boxes;

  @HiveField(2)
  final UserDetails userDetails;

  @HiveField(3)
  final DeliveryDetails deliveryDetails;

  const Users({
    required this.id,
    required this.boxes,
    required this.userDetails,
    required this.deliveryDetails,
  });

  factory Users.fromJson({required Map<String, dynamic> json}) {
    List<dynamic> parsedBoxes = json['boxes'] as List<dynamic>;
    List<box.Box> boxes = parsedBoxes
        .map(
          (e) => box.Box.fromJson(json: e),
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
    required String profileImage,
  }) {
    return {
      'id': uid,
      'boxes': boxes,
      'userDetails': userDetails.toJson(
        encryptedPassword: encryptedPassword,
        pProfileImage: profileImage,
      ),
      'deliveryDetails': deliveryDetails.toJSon(),
    };
  }
}
