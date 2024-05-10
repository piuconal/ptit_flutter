import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class NotificationsModel {
  DateTime dateTime;
  String notification;
  NotificationsModel({
    required this.dateTime,
    required this.notification,
  });
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dateTime': dateTime.millisecondsSinceEpoch,
      'notification': notification,
    };
  }

  factory NotificationsModel.fromMap(Map<String, dynamic> map) {
    return NotificationsModel(
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime']),
      notification: map['notification'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationsModel.fromJson(String source) => NotificationsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
