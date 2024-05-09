// ignore_for_file: use_build_context_synchronously
import 'dart:typed_data';
import 'package:diacritic/diacritic.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:developer';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ptit_flutter/configs/app_constant.dart';
import 'package:ptit_flutter/data/models/student.dart';
import 'package:ptit_flutter/ui/pages/add_student_page/components/avatar_widget.dart';
import 'package:ptit_flutter/ui/pages/student_list_page/student_list_page.dart';
import 'package:ptit_flutter/ui/widgets/primary_button.dart';
import 'package:ptit_flutter/ui/widgets/primary_dropdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

class AddStudentPage extends StatefulWidget {
  const AddStudentPage({super.key});

  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  bool isLoading = false;

  TextEditingController nameController = TextEditingController();

  String date = "dd/mm/yyyy";
  String majorsValue = 'Công nghệ thông tin';
  String coursesValue = 'D20';
  Uint8List? imageSource;

  Future<void> saveStudentToFirestore() async {
    try {
      if (date == "dd/mm/yyyy" ||
          nameController.text == "" ||
          imageSource == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Vui lòng nhập đầy đủ thông tin để tiếp tục"),
        ));
        return;
      }
      setState(() {
        isLoading = true;
      });
      String imagePath = "";
      if (imageSource != null) {
        imagePath =
            await postImageToCloud(data: imageSource!, album: "students");
      }
      log("link ảnh $imagePath");
      var msv = await createMSV();

      Student student = Student(
        name: nameController.text,
        msv: msv,
        dateOfBirth: date,
        course: coursesValue,
        majors: majorsValue,
        imagePath: imagePath,
      );
      await FirebaseFirestore.instance
          .collection('students')
          .add(student.toMap());
      setState(() {
        isLoading = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Đã lưu thông tin sinh viên thành công."),
      ));
      await createFirebaseAccount(msv);
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Lỗi khi lưu thông tin sinh viên: ${e.toString()}"),
      ));
    }
  }

  Future<String> createMSV() async {
    DatabaseReference msvRef = FirebaseDatabase.instance.ref().child('msv');
    String newMsv = "";
    try {
      // Đọc giá trị hiện tại của biến "msv" từ Realtime Database
      DataSnapshot dataSnapshot = await msvRef.get();
      int currentMsv = dataSnapshot.value as int;

      // Chuyển giá trị đọc được thành chuỗi và thêm các số 0 đằng trước để đảm bảo rằng chuỗi có độ dài 3 ký tự
      newMsv = (currentMsv + 1).toString().padLeft(3, '0');

      // Đẩy giá trị mới lên Realtime Database
      await msvRef.set(currentMsv + 1);
    } catch (e) {
      debugPrint('Lỗi khi cập nhật msv mới: $e');
    }
    String majorsString = getFirstLetters(majorsValue);
    return "$coursesValue$majorsString$newMsv";
  }

  Future<void> createFirebaseAccount(String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: convertToEmail(),
        password: password,
      );
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Tạo tài khoản sinh viên thành công."),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Có lỗi khi tạo tài khoản sinh viên"),
      ));
    }
  }

  String convertToEmail() {
    List<String> nameParts =
        removeDiacritics(nameController.text.trim()).split(" ");
    String email = "";
    email += nameParts.last.toLowerCase();
    for (int i = 0; i < nameParts.length; i++) {
      if (nameParts[i].isNotEmpty && i != nameParts.length-1) {
        email += nameParts[i][0].toLowerCase();
      }
    }

    return "$email@stu.ptit.com.vn";
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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                                      width: 1,
                                      color: Colors.red), //<-- SEE HERE
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
                            final response = await picker.pickImage(
                                source: ImageSource.gallery);
                            if (response == null) {
                              return;
                            }

                            Uint8List? imageBytes =
                                await response.readAsBytes();

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
