// import 'package:date_picker_plus/date_picker_plus.dart';
// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:ptit_flutter/data/models/notifications.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:ptit_flutter/service/noti_service.dart';

DateTime scheduleTime = DateTime.now();

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  TextEditingController textEditingController = TextEditingController();
  List<NotificationsModel> notis = [];

  @override
  void initState() {
    getListNoti();
    super.initState();
  }

  Future<void> getListNoti() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('notifications').get();

    notis = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      NotificationsModel noti = NotificationsModel.fromMap(data);
      return noti;
    }).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            try {
              textEditingController.clear();
              DateTime? dateTime =
                  await showOmniDateTimePicker(context: context);
              if (dateTime != null) {
                await showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    actions: [
                      InkWell(
                        onTap: () {
                          textEditingController.clear();
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: 50,
                          width: 80,
                          padding: const EdgeInsets.all(12),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(12)),
                          child: const Text("Hủy bỏ"),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: 50,
                          width: 100,
                          padding: const EdgeInsets.all(12),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.red[300],
                              borderRadius: BorderRadius.circular(12)),
                          child: const Text("Xác nhận"),
                        ),
                      )
                    ],
                    title: const Text('Nội dung thông báo'),
                    content: TextFormField(
                      controller: textEditingController,
                      decoration: InputDecoration(
                        label: const Text("Nội dung"),
                        contentPadding: const EdgeInsets.only(
                            left: 20.0, top: 20, bottom: 20),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 2, color: Colors.red), //<-- SEE HERE
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                    ),
                  ),
                );
                if (textEditingController.text != "") {
                  NotificationService().scheduleNotification(
                    title: 'Hẹn giờ ptit-flutter',
                    body: textEditingController.text,
                    scheduledNotificationDateTime: dateTime,
                  );

                  await FirebaseFirestore.instance
                      .collection('notifications')
                      .add(NotificationsModel(
                              dateTime: dateTime,
                              notification: textEditingController.text)
                          .toMap());

                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Đặt hẹn giờ thông báo thành công"),
                  ));
                  getListNoti();
                }
              }
            } catch (e) {
              log(e.toString());
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Đặt hẹn giờ thông báo thất bại"),
              ));
            }
          },
          child: const Icon(Icons.add)),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Hẹn lịch học",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              ListView.builder(
                  itemCount: notis.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var noti = notis[index];
                    return noti.dateTime.isBefore(DateTime.now())
                        ? const SizedBox(
                            height: 0.2,
                          )
                        : Container(
                            height: 50,
                            width: 300,
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 243, 185, 185)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 15, bottom: 15),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "💕 ${noti.dateTime.day}/${noti.dateTime.month}/${noti.dateTime.year}",
                                      style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 95, 32, 32),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      width: 25,
                                    ),
                                    Text(
                                      "🕑 ${noti.dateTime.hour}:${noti.dateTime.minute < 10 ? '0${noti.dateTime.minute}' : '${noti.dateTime.minute}'}",
                                      style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 95, 32, 32),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      width: 25,
                                    ),
                                    Text(
                                      noti.notification,
                                      style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 95, 32, 32)),
                                    ),
                                  ]),
                            ),
                          );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
