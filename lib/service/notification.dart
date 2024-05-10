// import 'dart:convert';
// import 'dart:developer';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:ptit_flutter/global/global_data.dart';

// class FireBaseApi {
//   static String fCMToken = "token";
//   final _androidChannel = const AndroidNotificationChannel(
//     'high_importance_channel',
//     'high_importance_Notifications',
//     description: 'This channel is used for important notifications',
//     importance: Importance.defaultImportance,
//   );

//   final _firebaseMessaging = FirebaseMessaging.instance;
//   final _localNotifications = FlutterLocalNotificationsPlugin();

//   Future<void> initNotifications() async {
//     await _firebaseMessaging.requestPermission();
//     fCMToken = await _firebaseMessaging.getToken() ?? "token";
//     GlobalData.instance.fCMToken = fCMToken;
//     log("token = $fCMToken ");
//     initPushNotifications();
//     try {
//       initLocalNotifications();
//     } catch (e) {
//       log("$e");
//     }
//   }

//   Future<void> handleBackgroundMessage(RemoteMessage? message) async {
//     if (message == null) return;
//     // navigatorKey.currentState?.push(
//     //   MaterialPageRoute(builder: (_) => const NotiPage()),
//     // );
//   }

//   void handleMessage(RemoteMessage? message) async {
//     // ignore: unnecessary_null_comparison
    
//     if (message == null) return;
//     log("${message.data}check handel message");

//     // navigatorKey.currentState?.push(
//     //   MaterialPageRoute(builder: (_) => const NotiPage()),
//     // );
//   }

//   Future initLocalNotifications() async {
//     // const iOS = IOSInitializationSettings();
//     const android =
//         AndroidInitializationSettings('@drawable/launch_background');
//     const settings = InitializationSettings(android: android, iOS: null);
//     await FlutterLocalNotificationsPlugin().initialize(
//       settings,
//       onSelectNotification: (payload) {
//         final message = RemoteMessage.fromMap(jsonDecode(payload!));
//         handleMessage(message);
//       },
//     );
//     final platform = _localNotifications.resolvePlatformSpecificImplementation<
//         AndroidFlutterLocalNotificationsPlugin>();
//     await platform?.createNotificationChannel(_androidChannel);
//   }

//   Future initPushNotifications() async {
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );

//     FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
//     FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
//     FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
//     FirebaseMessaging.onMessage.listen((message) async {
//       log(message.notification!.title!);
//       final notification = message.notification;
//       if (notification == null) return;
//       _localNotifications.show(
//         notification.hashCode,
//         notification.title,
//         notification.body,
//         NotificationDetails(
//           android: AndroidNotificationDetails(
//             _androidChannel.id,
//             _androidChannel.name,
//             channelDescription: _androidChannel.description,
//             icon: '@drawable/launch_background',
//           ),
//         ),
//         payload: jsonEncode(message.toMap()),
//       );
//     });
//   }
// }
