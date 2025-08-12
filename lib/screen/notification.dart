import 'package:flutter/material.dart';
import 'package:matchme/controller/mainpage_controller.dart';
import 'package:matchme/controller/notification_controller.dart';
import 'package:matchme/screen/connection.dart';
import 'package:matchme/screen/interest_received.dart';
import 'package:matchme/screen/support.dart';
import 'package:provider/provider.dart';
import '../constant.dart';
import "package:flutter_svg/flutter_svg.dart";
import 'package:dotted_border/dotted_border.dart';

class MyNotification extends StatefulWidget {
  const MyNotification({super.key});

  @override
  State<MyNotification> createState() => _MyNotificationState();
}

class _MyNotificationState extends State<MyNotification> {
  List<dynamic>? notifications;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<NotificationController>(context, listen: false)
          .getAllNotification();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    notifications = Provider.of<NotificationController>(context, listen: true)
        .notificationData;

    // :::::::::::::::::::::::::: Loading ::::::::::::::::::::::::
    if (Provider.of<NotificationController>(context, listen: true)
            .notificationData ==
        null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Notification",
            style: TextStyle(
              fontFamily: Constant.haddingFont,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          toolbarHeight: 80.0,
          leading: IconButton(
            onPressed: () {
              Provider.of<MainpageController>(
                context,
                listen: false,
              ).updatePosition("home");
              Provider.of<MainpageController>(
                context,
                listen: false,
              ).setBottomIndex(0);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    // :::::::::::::::::::::::::: No data ::::::::::::::::::::::::
    else if (Provider.of<NotificationController>(context, listen: true)
        .notificationData!
        .isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Notification",
            style: TextStyle(
              fontFamily: Constant.haddingFont,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          toolbarHeight: 80.0,
          leading: IconButton(
            onPressed: () {
              Provider.of<MainpageController>(
                context,
                listen: false,
              ).updatePosition("home");
              Provider.of<MainpageController>(
                context,
                listen: false,
              ).setBottomIndex(0);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.notifications_none_outlined,
                size: 70.0,
                color: Color.fromARGB(255, 223, 221, 221),
              ),
              const SizedBox(height: 20.0),
              Text(
                "No Notification available",
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: Constant.subHadding,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await Provider.of<NotificationController>(context, listen: false)
            .getAllNotification();
      },
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop) {
            Provider.of<MainpageController>(
              context,
              listen: false,
            ).updatePosition("home");
            Provider.of<MainpageController>(
              context,
              listen: false,
            ).setBottomIndex(0);
          }
        },
        child: Scaffold(
          body: Stack(
            children: [
              PreferredSize(
                preferredSize: const Size.fromHeight(50.0),
                child: AppBar(
                  title: Text(
                    "Notification",
                    style: TextStyle(
                      fontFamily: Constant.haddingFont,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  centerTitle: true,
                  toolbarHeight: 80.0,
                  leading: IconButton(
                    onPressed: () {
                      Provider.of<MainpageController>(
                        context,
                        listen: false,
                      ).updatePosition("home");
                      Provider.of<MainpageController>(
                        context,
                        listen: false,
                      ).setBottomIndex(0);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                ),
              ),
              Positioned(
                right: -5.0,
                child: SvgPicture.asset("assets/images/Frame 2951.svg"),
              ),
              Positioned.fill(
                top: size.height * 0.1,
                child: ListView.builder(
                  itemCount: notifications!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        var type = notifications![index]['notify_type'];
                        if (type == "interest") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const InterestReceived(),
                              ));
                        } else if (type == "match") {
                          Provider.of<MainpageController>(context,
                                  listen: false)
                              .updatePosition("heart");
                          Provider.of<MainpageController>(context,
                                  listen: false)
                              .setBottomIndex(1);
                        } else if (type == "connection") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Connection(),
                              ));
                        } else if (type == "message") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Support(),
                              ));
                        }
                      },
                      child: DottedBorder(
                        dashPattern: const [4, 3],
                        color: Colors.grey.shade300,
                        strokeWidth: 1,
                        customPath: (size) {
                          double lineWidth = size.width * 0.7;
                          double startX = (size.width - lineWidth) / 2;
                          return Path()
                            ..moveTo(startX, size.height)
                            ..lineTo(startX + lineWidth, size.height);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: ListTile(
                            title: Text(
                              notifications![index]['message'],
                              style: TextStyle(
                                fontSize: 13.0,
                                fontFamily: Constant.subHadding,
                              ),
                            ),
                            subtitle: Text(
                              notifications![index]['timeAgo'],
                              style: TextStyle(
                                fontSize: 10.0,
                                fontFamily: Constant.subHadding,
                              ),
                            ),
                            leading: CircleAvatar(
                              backgroundColor: const Color(0xFF245C66),
                              radius: 20.0,
                              child: getNotificationIcon(
                                notifications![index]['notify_type'],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  padding: const EdgeInsets.all(18.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getNotificationIcon(String type) {
    switch (type) {
      case 'interest':
        return const Icon(color: Colors.white, Icons.join_inner);
      case 'connection':
        return Image.asset(
          "assets/icons/connection.png",
          height: 22.0,
        );
      case 'match':
        return const Icon(color: Colors.white, Icons.favorite_rounded,size: 22.0 );
      case 'message':
        return const Icon(color: Colors.white, Icons.chat_rounded,size: 22.0 );
      case 'generic':
      default:
        return const Icon(color: Colors.white, Icons.notifications,size: 22.0 );
    }
  }
}
