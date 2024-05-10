import 'package:flutter/material.dart';
import 'package:ptit_flutter/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ptit_flutter/service/noti_service.dart';
import 'package:ptit_flutter/ui/pages/student_home_page/student_home_page.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> main() async {
  //Khới tạo kết nối firebase
  // try {
  WidgetsFlutterBinding.ensureInitialized();

  NotificationService().initNotification();
  tz.initializeTimeZones();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // } catch (e) {
  //   debugPrint(e.toString());
  // }
  //Chạy app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Khởi tạo UI chung cho app
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //theme cho app
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      //đặt màn hình đầu tiên là màn splash
      home: const StudentHomePage(msv: "D24VT016"),
    );
  }
}
