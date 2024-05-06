import 'package:flutter/material.dart';
import 'package:ptit_flutter/configs/app_constant.dart';
import 'package:ptit_flutter/ui/pages/student_list_page/student_list_page.dart';
import 'package:ptit_flutter/ui/widgets/primary_button.dart';
import 'package:ptit_flutter/ui/widgets/primary_dropdown.dart';

class AdminManagementPage extends StatefulWidget {
  const AdminManagementPage({super.key});

  @override
  State<AdminManagementPage> createState() => _AdminManagementPageState();
}

class _AdminManagementPageState extends State<AdminManagementPage> {
  List<String> optionList = ["Khóa", "Ngành"];

  String filter = "Khóa";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "THÔNG TIN QUẢN LÝ",
          style: TextStyle(
            color: Colors.red,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Lọc theo",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 20),
                PrimaryDropdown(
                  inputList: optionList,
                  onChanged: (p0) {
                    setState(() {
                      filter = p0!;
                    });
                  },
                  value: filter,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            itemCount: filter == "Khóa"
                ? AppConstant.courses.length
                : AppConstant.majors.length,
            itemBuilder: (context, idx) {
              var title = filter == "Khóa"
                  ? AppConstant.courses[idx]
                  : AppConstant.majors[idx];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                child: PrimaryButton(
                    title: title,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => StudentListPage(
                            isCourses: filter == "Khóa",
                            keyString: title,
                          ),
                        ),
                      );
                    }),
              );
            },
          )
        ],
      ),
    );
  }
}
