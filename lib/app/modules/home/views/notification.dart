import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late double height;
  late double width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return ScreenUtilInit(
      builder: (context, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.arrow_back, color: Colors.black, size: 25),
          ),
          title: Text(
            "Notification",
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Gilroy_Bold',
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: height / 20),
              notificationCategory(
                "Welcome in Blackanova",
                "the best app that puts you in touch with the best hairdressers.",
                "0 minute ago",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget notificationCategory(String offerName, String title, String times) {
    return Center(
      child: Container(
        height: height / 5,
        width: width / 1.1,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(18),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height / 40),
            Row(
              children: [
                SizedBox(width: width / 20),
                Icon(Icons.notifications_active,
                    color: Colors.blue, size: 25),
                SizedBox(width: width / 50),
                Text(
                  offerName,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Gilroy_Bold',
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            SizedBox(height: height / 200),
            Row(
              children: [
                SizedBox(width: width / 7),
                Flexible(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Gilroy_Medium',
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: height / 30),
            Row(
              children: [
                SizedBox(width: width / 7),
                Text(
                  times,
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Gilroy_Medium',
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
