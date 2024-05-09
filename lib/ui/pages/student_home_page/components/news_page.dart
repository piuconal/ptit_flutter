import 'package:flutter/material.dart';
import 'package:ptit_flutter/configs/app_assets.dart';
import 'package:ptit_flutter/configs/app_constant.dart';
import 'package:url_launcher/url_launcher.dart';

class NewPages extends StatelessWidget {
  const NewPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 40,
          width: double.infinity,
          color: Colors.red,
          padding: const EdgeInsets.only(left: 20),
          alignment: Alignment.centerLeft,
          child: const Text(
            "Thông báo",
            style: TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            Center(
              child: InkWell(
                onTap: () async {
                  if (!await launchUrl(Uri.parse(
                      "https://qldt.ptit.edu.vn/#/home/listbaiviet/tb/page/1/baivietct/-8123407026155822219"))) {
                    throw Exception('Could not launch url');
                  }
                },
                child: Image.asset(
                  AppAssets.imNew,
                  width: 320,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              // width: 320,
              // height: 500,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: AppConstant.ptitNews.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        if (!await launchUrl(
                            Uri.parse(AppConstant.ptitNews[index].url))) {
                          throw Exception('Could not launch url');
                        }
                      },
                      child: SizedBox(
                        width: 320,
                        // height: 50,
                        child: Text(
                          ">>${AppConstant.ptitNews[index].title}",
                          style: const TextStyle(
                              color: Colors.black, fontSize: 14),
                          overflow: TextOverflow.clip,
                          maxLines: 4,
                        ),
                      ),
                    );
                  }),
            )
          ]),
        ),
      ],
    );
  }
}
