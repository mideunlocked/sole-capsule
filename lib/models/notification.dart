import 'package:cloud_firestore/cloud_firestore.dart';

class Notifications {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final Timestamp timestamp;

  const Notifications({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.timestamp,
    required this.description,
  });

  factory Notifications.fromJson({
    required Map<String, dynamic> json,
  }) {
    return Notifications(
      id: json['id'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      timestamp: json['timestamp'] as Timestamp,
      description: json['description'] as String,
    );
  }
}
