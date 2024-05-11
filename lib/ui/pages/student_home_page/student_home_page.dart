import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ptit_flutter/data/models/student.dart';
import 'package:ptit_flutter/global/global_data.dart';
import 'package:ptit_flutter/ui/pages/login_page/login_page.dart';
import 'package:ptit_flutter/ui/pages/student_home_page/components/avatar_widget.dart';
import 'package:ptit_flutter/ui/pages/student_home_page/components/info_page.dart';
import 'package:ptit_flutter/ui/pages/student_home_page/components/news_page.dart';
import 'package:ptit_flutter/ui/pages/student_home_page/components/schedule_page.dart';

Student? student;

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({super.key, required this.msv});
  final String msv;

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  PageController controller = PageController(initialPage: 0);
  Future<void> getStudent() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('students')
          .where('msv', isEqualTo: widget.msv)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        Map<String, dynamic> data =
            querySnapshot.docs.first.data() as Map<String, dynamic>;
        student = Student.fromMap(data);
        GlobalData.instance.uid=student?.uid??"";
        log("sv ${student!.name}");
      } else {}
    } catch (e) {
      // Xử lý lỗi nếu có
      print('Lỗi khi lấy sinh viên: $e');
      // return null;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getStudent();
  }

  List<Widget> pages = [
    const NewPages(),
    const SchedulePage(),
    const InfoPage()
  ];
  int curPage = 0;

  @override
  Widget build(BuildContext context) {
    return student == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              leading: Container(
                padding: const EdgeInsets.all(8),
                child: const AvatarWidget(
                  imageUrl:
                      'https://avatars.githubusercontent.com/u/57191540?s=200&v=4',
                  // fit: BoxFit.cover,
                ),
              ),
              titleSpacing: 0,
              title: InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
                child: Container(
                  height: 40,
                  width: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.red),
                  child: const Text(
                    "⚪ ĐĂNG XUẤT",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              actions: const [
                Icon(
                  Icons.notifications_active,
                  size: 30,
                ),
                SizedBox(width: 20),
              ],
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                  child: Text(
                    student != null
                        ? "🧑🏼‍💻  Xin chào, ${student!.name}"
                        : "Xin chào",
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontStyle: FontStyle.italic),
                  ),
                ),
                SizedBox(
                  height: 590,
                  child: PageView(
                    controller: controller,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (value) {
                      setState(() {
                        curPage = value;
                      });
                    },
                    children: pages,
                  ),
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
                onTap: (value) {
                  // setState(() {
                    controller.jumpToPage(value);
                  // });
                },
                currentIndex: curPage,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home_filled), label: "Thông báo"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.alarm), label: "Hẹn"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.info), label: "Thông tin")
                ]),
          );
  }
}
