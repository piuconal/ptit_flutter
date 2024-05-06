import 'package:flutter/material.dart';
import 'package:ptit_flutter/configs/app_assets.dart';
import 'package:ptit_flutter/ui/pages/home_page/home_page.dart';
import 'package:ptit_flutter/ui/widgets/primary_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Column(
          children: [
            Image.asset(
              AppAssets.imPtitLogo,
              height: 50,
            ),
            const SizedBox(height: 50),
            const Text(
              "ĐĂNG NHẬP",
              style: TextStyle(
                  color: Colors.red, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            //trường nhập tên tài khoản
            TextFormField(
              decoration: InputDecoration(
                label: const Text("Tài Khoản"),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      width: 3, color: Colors.red), //<-- SEE HERE
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            //trường nhập mật khẩu
            TextFormField(
              decoration: InputDecoration(
                fillColor: Colors.grey,
                label: const Text("Mật khẩu"),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      width: 3, color: Colors.red), //<-- SEE HERE
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
            ),
            const SizedBox(height: 60),
            //nút đăng nhập
            PrimaryButton(
              //nhấn
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                },
                title: "Đăng Nhập"),
            const Spacer(),
            const Text(
              "Vũ Trọng Hiếu - 0971110602",
              style: TextStyle(color: Colors.red, fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
