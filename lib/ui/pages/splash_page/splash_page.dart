import 'package:flutter/material.dart';
import 'package:ptit_flutter/configs/app_assets.dart';
import 'package:ptit_flutter/ui/pages/login_page/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

@override
  void initState() {
    //Đợi 3s sau đó chuyển sang màn login
    Future.delayed(
      const Duration(seconds: 3),
      () {
        //hàm chuyển màn
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      },
    );
    super.initState();
  }
  //UI chính
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Image.asset(
        AppAssets.imSplash,
        fit: BoxFit.fill,
        height: double.infinity,
        width: double.infinity,
      ),
    );
  }
}
