// ignore_for_file: use_build_context_synchronously
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'dart:developer';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ptit_flutter/configs/app_constant.dart';
import 'package:ptit_flutter/data/models/student.dart';
import 'package:ptit_flutter/ui/pages/add_student_page/components/avatar_widget.dart';
import 'package:ptit_flutter/ui/widgets/primary_button.dart';
import 'package:ptit_flutter/ui/widgets/primary_dropdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddStudentPage extends StatefulWidget {
  const AddStudentPage({super.key});

  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  TextEditingController nameController = TextEditingController();

  String date = "dd/mm/yyyy";
  String majorsValue = 'Công nghệ thông tin';
  String coursesValue = 'D20';
  Uint8List? imageSource;

  Future<void> saveStudentToFirestore() async {
    try {
      String imagePath = "";
      if (imageSource != null) {
        imagePath =
            await postImageToCloud(data: imageSource!, album: "students");
      }
      log("link ảnh $imagePath");
      Student student = Student(
        name: nameController.text,
        msv: "B20DCCN310",
        dateOfBirth: date,
        course: coursesValue,
        majors: majorsValue,
        imagePath: imagePath,
      );
      await FirebaseFirestore.instance
          .collection('students')
          .add(student.toMap());

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Đã lưu thông tin sinh viên thành công."),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Lỗi khi lưu thông tin sinh viên: ${e.toString()}"),
      ));
    }
  }

  Future<String> postImageToCloud(
      {required Uint8List data, required String album}) async {
    final int imageId = DateTime.now().millisecondsSinceEpoch;
    final storageRef =
        FirebaseStorage.instance.ref().child('$album/image$imageId.png');
    try {
      await storageRef.putData(data);
      var imagePath = await storageRef.getDownloadURL();
      return imagePath;
    } catch (e) {
      log(e.toString());
      rethrow; // Throw lại lỗi để xử lý ở nơi gọi phương thức nếu cần
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'THÔNG TIN SINH VIÊN',
          style: TextStyle(
              fontSize: 18.0,
              fontStyle: FontStyle.italic,
              color: Colors.red,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const SizedBox(width: 20),
                const Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Ngày sinh",
                      style: TextStyle(
                          fontSize: 16.0,
                          fontStyle: FontStyle.italic,
                          color: Colors.red,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                const SizedBox(width: 26),
                Expanded(
                  //Expanded giúp giãn hết cỡ kích thước nó có thể nhận
                  flex: 3,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () async {
                        var datex = await showDatePickerDialog(
                            context: context,
                            minDate: DateTime(1990, 1, 1),
                            maxDate: DateTime(2023, 12, 31),
                            currentDate: DateTime(2000, 1, 1));
                        log(datex.toString());
                        setState(() {
                          String formattedDate = DateFormat('dd/MM/yyyy')
                              .format(datex ?? DateTime(2023, 1, 1));
                          date = formattedDate;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(date),
                          const SizedBox(width: 8),
                          const Icon(Icons.calendar_month_outlined)
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                const SizedBox(width: 20),
                const Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Họ và tên",
                      style: TextStyle(
                          fontSize: 16.0,
                          fontStyle: FontStyle.italic,
                          color: Colors.red,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                const SizedBox(width: 28),
                Expanded(
                  flex: 3,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      height: 32,
                      // width: 280,
                      child: TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          // label: const Text("Mã sinh viên"),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1, color: Colors.red), //<-- SEE HERE
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                const SizedBox(width: 20),
                const Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Ngành",
                      style: TextStyle(
                          fontSize: 16.0,
                          fontStyle: FontStyle.italic,
                          color: Colors.red,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                const SizedBox(width: 28),
                Expanded(
                  flex: 3,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: PrimaryDropdown(
                      value: majorsValue,
                      inputList: AppConstant.majors,
                      onChanged: ((p0) {
                        setState(() {
                          majorsValue = p0!;
                        });
                      }),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                const SizedBox(width: 20),
                const Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Khóa",
                      style: TextStyle(
                          fontSize: 16.0,
                          fontStyle: FontStyle.italic,
                          color: Colors.red,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                const SizedBox(width: 28),
                Expanded(
                  flex: 3,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: PrimaryDropdown(
                      value: coursesValue,
                      inputList: AppConstant.courses,
                      onChanged: ((p0) {
                        setState(() {
                          coursesValue = p0!;
                        });
                      }),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                const SizedBox(width: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Ảnh sinh viên",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontStyle: FontStyle.italic,
                        color: Colors.red,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                const Spacer(),
                PrimaryButton(
                    title: "Tải ảnh lên",
                    fontSize: 16,
                    onTap: () async {
                      final ImagePicker picker = ImagePicker();
                      final response =
                          await picker.pickImage(source: ImageSource.gallery);
                      if (response == null) {
                        return;
                      }

                      Uint8List? imageBytes = await response.readAsBytes();

                      setState(() {
                        // Lưu trữ dữ liệu của hình ảnh dưới dạng Uint8List
                        imageSource = imageBytes;
                      });
                    }),
                const SizedBox(width: 20),
              ],
            ),
            const SizedBox(height: 50),
            AvatarWidget(imageSource: imageSource),
            const SizedBox(height: 50),
            PrimaryButton(
                weight: 260,
                height: 55,
                fontSize: 17,
                title: "Thêm vào danh sách",
                onTap: () => saveStudentToFirestore())
          ],
        ),
      ),
    );
  }
}
