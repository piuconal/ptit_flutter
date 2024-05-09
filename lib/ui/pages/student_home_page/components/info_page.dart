import 'package:flutter/material.dart';
import 'package:ptit_flutter/data/models/student.dart';
import 'package:ptit_flutter/ui/pages/student_home_page/components/avatar_widget1.dart';
import 'package:ptit_flutter/ui/pages/student_home_page/student_home_page.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return student != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 35,
              ),
              SizedBox(
                width: 250,
                height: 300,
                child: AvatarWidget1(imageUrl: student!.imagePath),
              ),
              const SizedBox(
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 90),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Họ và Tên: ${student!.name}",
                          style:
                              const TextStyle(color: Colors.red, fontSize: 16),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Mã sinh viên: ${student!.msv}",
                          style:
                              const TextStyle(color: Colors.red, fontSize: 16),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Ngày sinh : ${student!.dateOfBirth}",
                          style:
                              const TextStyle(color: Colors.red, fontSize: 16),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Ngành : ${student!.majors}",
                          style:
                              const TextStyle(color: Colors.red, fontSize: 16),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Khóa : ${student!.course}",
                          style:
                              const TextStyle(color: Colors.red, fontSize: 16),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          )
        : const CircularProgressIndicator();
  }
}
