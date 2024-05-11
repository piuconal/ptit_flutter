import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class NotificationsModel {
  DateTime dateTime;
  String notification;
  String uid;
  NotificationsModel({
    required this.dateTime,
    required this.notification,
    required this.uid,
  });
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dateTime': dateTime.millisecondsSinceEpoch,
      'notification': notification,
      'uid': uid,
    };
  }

  factory NotificationsModel.fromMap(Map<String, dynamic> map) {
    return NotificationsModel(
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
      notification: map['notification'] as String,
      uid: map['uid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationsModel.fromJson(String source) => NotificationsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  NotificationsModel copyWith({
    DateTime? dateTime,
    String? notification,
    String? uid,
  }) {
    return NotificationsModel(
      dateTime: dateTime ?? this.dateTime,
      notification: notification ?? this.notification,
      uid: uid ?? this.uid,
    );
  }

  @override
  String toString() => 'NotificationsModel(dateTime: $dateTime, notification: $notification, uid: $uid)';

  @override
  bool operator ==(covariant NotificationsModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.dateTime == dateTime &&
      other.notification == notification &&
      other.uid == uid;
  }

  @override
  int get hashCode => dateTime.hashCode ^ notification.hashCode ^ uid.hashCode;
}
