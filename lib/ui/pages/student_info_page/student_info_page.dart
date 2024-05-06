import 'dart:developer';

import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ptit_flutter/configs/app_constant.dart';
import 'package:ptit_flutter/ui/pages/student_info_page/components/avatar_widget.dart';
import 'package:ptit_flutter/ui/widgets/primary_button.dart';
import 'package:ptit_flutter/ui/widgets/primary_dropdown.dart';

class StudentInfoPage extends StatefulWidget {
  const StudentInfoPage({super.key});

  @override
  State<StudentInfoPage> createState() => _StudentInfoPageState();
}

class _StudentInfoPageState extends State<StudentInfoPage> {
  String date = "dd/mm/yyyy";
  String majorsValue = 'Công nghệ thông tin';
  String coursesValue = 'D20';
  String? imagePath;

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
                const SizedBox(width: 16),

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
                          String formattedDate = DateFormat('dd/MM/yyyy').format(datex??DateTime(2023, 1, 1));
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
            const SizedBox(height: 20),
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
            const SizedBox(height: 20),
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
            const SizedBox(height: 20),
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
            const SizedBox(height: 20),
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
                    onTap: () async {
                      final ImagePicker picker = ImagePicker();
                      final response =
                          await picker.pickImage(source: ImageSource.gallery);
                      if (response == null) {
                        return;
                      }

                      setState(() {
                        imagePath = response.path;
                      });
                    }),
                const SizedBox(width: 20),
              ],
            ),
            const SizedBox(height: 20),
            AvatarWidget(imagePath: imagePath),
            const SizedBox(height: 40),
            PrimaryButton(
                weight: 300,
                height: 60,
                fontSize: 22,
                title: "Thêm vào danh sách",
                onTap: () {})
          ],
        ),
      ),
    );
  }
}
