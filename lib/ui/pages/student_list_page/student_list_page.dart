import 'package:flutter/material.dart';
import 'package:ptit_flutter/data/models/student.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ptit_flutter/ui/pages/edit_student_page/edit_student_page.dart';

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

class StudentListPage extends StatefulWidget {
  const StudentListPage(
      {super.key, required this.keyString, required this.isCourses});
  final String keyString;
  final bool isCourses;

  @override
  State<StudentListPage> createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  bool isLoading = false;

  String date = "01/01/1990";
  String majorsValue = 'Công nghệ thông tin';
  String coursesValue = 'D20';
  String? imagePath;
  List<Student> students = [];
  List<Student> searchResult = [];
  TextEditingController searchController = TextEditingController();

  Future<void> getStudent(
      {required String key, required bool isCourses}) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('students')
          .where(isCourses ? 'course' : 'majors', isEqualTo: key)
          .get();

      students = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        Student student = Student.fromMap(data);
        student.uid = doc.id; // Gán uid của sinh viên từ Firebase
        return student;
      }).toList();
      searchResult = students;

      print('Đã lấy ra danh sách sinh viên thành công: ${students[0].uid}');
    } catch (e) {
      print('Lỗi khi lấy ra danh sách sinh viên: $e');
    }
    setState(() {});
  }

  

  void searchStudent(String searchText) {
    List<Student> search = [];

    for (var student in students) {
      if (widget.isCourses) {
        if (student.name.toLowerCase().contains(searchText.toLowerCase()) ||
            student.msv.toLowerCase().contains(searchText.toLowerCase()) ||
            student.majors.toLowerCase().contains(searchText.toLowerCase())) {
          search.add(student);
        }
      } else {
        if (student.name.toLowerCase().contains(searchText.toLowerCase()) ||
            student.msv.toLowerCase().contains(searchText.toLowerCase()) ||
            student.course.toLowerCase().contains(searchText.toLowerCase())) {
          search.add(student);
        }
      }
    }
    searchResult.clear();
    setState(() {
      searchResult = search;
    });
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
      body: 
       SingleChildScrollView(
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
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText:
                              'Tìm kiếm theo tên/mã/${widget.isCourses ? "ngành" : "khóa"}',
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20.0),
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
                        searchStudent(searchController.text);
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
                      itemCount: searchResult.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () async {
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => EditStudentPage(
                                    student: searchResult[index]),
                              ),
                            );
                            getStudent(key: widget.keyString, isCourses: widget.isCourses);
                          },
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    searchResult[index].name,
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
                                    searchResult[index].msv,
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
                                            searchResult[index].majors)
                                        : searchResult[index].course,
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
