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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(
                height: 120,
              ),
              Image.asset(
                AppAssets.imPtitLogo,
                height: 100,
                width: 90,
                fit: BoxFit.fill,
              ),
              const SizedBox(height: 50),
              // const Text(
              //   "ĐĂNG NHẬP",
              //   style: TextStyle(
              //       color: Colors.red,
              //       fontSize: 24,
              //       fontWeight: FontWeight.bold),
              // ),
              const SizedBox(height: 20),
              //trường nhập tên tài khoản
              TextFormField(
                decoration: InputDecoration(
                  label: const Text("Tài Khoản"),
                  contentPadding:
                      const EdgeInsets.only(left: 20.0, top: 20, bottom: 20),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 2, color: Colors.red), //<-- SEE HERE
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              //trường nhập mật khẩu
              TextFormField(
                decoration: InputDecoration(
                  fillColor: Colors.grey,
                  label: const Text("Mật khẩu"),
                  contentPadding:
                      const EdgeInsets.only(left: 20.0, top: 20, bottom: 20),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 2, color: Colors.red), //<-- SEE HERE
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
              // const Spacer(),
              const SizedBox(height: 180),

              const Text(
                "Vũ Trọng Hiếu - 0971110602",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
