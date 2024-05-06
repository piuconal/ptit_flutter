import 'package:flutter/material.dart';
import 'package:ptit_flutter/data/models/student.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ptit_flutter/ui/pages/edit_student_page/edit_student_page.dart';

class StudentListPage extends StatefulWidget {
  const StudentListPage(
      {super.key, required this.keyString, required this.isCourses});
  final String keyString;
  final bool isCourses;

  @override
  State<StudentListPage> createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  String date = "01/01/1990";
  String majorsValue = 'Công nghệ thông tin';
  String coursesValue = 'D20';
  String? imagePath;
  List<Student> students = [];

  Future<void> getStudent(
      {required String key, required bool isCourses}) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('students')
          .where(isCourses ? 'course' : 'majors', isEqualTo: key)
          .get();

      students = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Student.fromMap(data);
      }).toList();

      print('Đã lấy ra danh sách sinh viên thành công.');
    } catch (e) {
      print('Lỗi khi lấy ra danh sách sinh viên: $e');
    }
    setState(() {});
    // return students;
  }

  String getFirstLetters(String input) {
    List<String> words = input.split(" ");
    String result = "";

    for (var word in words) {
      if (word.isNotEmpty) {
        result += word[0].toUpperCase();
      }
    }

    return result;
  }

  @override
  void initState() {
    super.initState();
    getStudent(key: widget.keyString, isCourses: widget.isCourses);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'THÔNG TIN QUẢN LÝ',
          style: TextStyle(
              fontSize: 18.0,
              fontStyle: FontStyle.italic,
              color: Colors.red,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                height: 50,
                // width: ,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: Colors.red),
                child: Text(
                  widget.keyString,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.grey[300]),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: 'Tìm kiếm theo tên/mã/ngành',
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 20.0),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.red),
                    child: IconButton(
                      icon: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // Xử lý khi nút tìm kiếm được nhấn
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Row(
                    children: [
                      const Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Họ và tên",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "MSV",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            widget.isCourses ? "Ngành" : "Khóa",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: students.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>  EditStudentPage(student: students[index]),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    students[index].name,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    students[index].msv,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    widget.isCourses
                                        ? getFirstLetters(
                                            students[index].majors)
                                        : students[index].course,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
