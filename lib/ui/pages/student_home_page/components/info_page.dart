import 'package:flutter/material.dart';
import 'package:ptit_flutter/data/models/student.dart';
import 'package:ptit_flutter/ui/pages/student_home_page/components/avatar_widget.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          child: AvatarWidget(imageUrl: ),
        )
      ],
    );
  }
}
