import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String type;
  final String content;
  final int userId;
  final int notificationId;
  final Timestamp createdAt;

  const NotificationModel({
    required this.type,
    required this.content,
    required this.userId,
    required this.notificationId,
    required this.createdAt,
  });

  static NotificationModel fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        type: json["type"],
        content: json["content"],
        userId: json["user_id"],
        notificationId: json['notification_id'],
        createdAt: json['created_at'],
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'content': content,
        'user_id': userId,
        'notification_id': notificationId,
        'created_at': createdAt,
      };
}
