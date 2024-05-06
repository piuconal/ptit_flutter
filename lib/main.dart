import 'package:flutter/material.dart';
import 'package:ptit_flutter/ui/pages/admin_management_page/admin_management_page.dart';
import 'package:ptit_flutter/ui/pages/login_page/login_page.dart';
import 'package:ptit_flutter/ui/pages/splash_page/splash_page.dart';
import 'package:ptit_flutter/ui/pages/student_info_page/student_info_page.dart';

void main() {
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
      home: const SplashPage(),
    );
  }
}
