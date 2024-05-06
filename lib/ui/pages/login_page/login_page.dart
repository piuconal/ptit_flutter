import 'package:flutter/material.dart';
import 'package:ptit_flutter/configs/app_assets.dart';
import 'package:ptit_flutter/ui/pages/home_page/home_page.dart';
import 'package:ptit_flutter/ui/widgets/primary_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isShowPassword = false;

  Future<void> _signIn() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _usernameController.text,
        password: _passwordController.text,
      );
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } catch (e) {
      // Xử lý lỗi đăng nhập
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Đăng nhập không thành công, vui lòng thử lại"),
      ));
    }
  }

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
                controller: _usernameController,
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
                controller: _passwordController,
                obscureText: !isShowPassword,
                enableSuggestions: false,
                autocorrect: false,
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
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      isShowPassword ? Icons.visibility : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        isShowPassword = !isShowPassword;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 60),
              //nút đăng nhập
              PrimaryButton(
                  //nhấn
                  onTap: () {
                    _signIn();
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
