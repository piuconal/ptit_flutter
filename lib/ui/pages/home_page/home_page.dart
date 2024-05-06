import 'package:flutter/material.dart';
import 'package:ptit_flutter/ui/pages/add_student_page/add_student_page.dart';
import 'package:ptit_flutter/ui/pages/admin_management_page/admin_management_page.dart';
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
              style: TextStyle(
                  color: Colors.red, fontSize: 20, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 40),
            PrimaryButton(
              title: "Thêm sinh viên",
              weight: 250,
              height: 50,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AddStudentPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 32),
            PrimaryButton(
              title: "Xem thông tin",
              weight: 250,
              height: 50,
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
