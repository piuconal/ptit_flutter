import 'package:flutter/material.dart';

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
      body: Padding(
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
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
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
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          const Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Vũ Trọng Hiếu",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ),
                          const Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "20CNTT123",
                                style: TextStyle(
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
                                widget.isCourses ? "CNTT" : "D20",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          )
                        ],
                      );
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
