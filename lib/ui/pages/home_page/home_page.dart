import 'package:flutter/material.dart';
import 'package:ptit_flutter/ui/pages/admin_management_page/admin_management_page.dart';
import 'package:ptit_flutter/ui/pages/student_info_page/student_info_page.dart';
import 'package:ptit_flutter/ui/widgets/primary_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Chào mừng đến Quản lý sinh viên",
              style: TextStyle(color: Colors.red, fontSize: 18),
            ),
            const SizedBox(height: 40),
            PrimaryButton(
              title: "Thêm sinh viên",
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const StudentInfoPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 32),
            PrimaryButton(
              title: "Xem thông tin",
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AdminManagementPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
