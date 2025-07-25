import 'package:flutter/material.dart';
import '../constant.dart';

class NotificationPopup extends StatefulWidget {
  const NotificationPopup({super.key});

  @override
  State<NotificationPopup> createState() => _NotificationPopupState();
}

class _NotificationPopupState extends State<NotificationPopup> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Visibility(
      visible: isVisible,
      child: Padding(
        padding: EdgeInsets.only(
          top: size.height * 0.05,
          left: 16.0,
          right: 16.0,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              constraints:
                  const BoxConstraints(maxWidth: 600), // Good for tablets/web
              decoration: BoxDecoration(
                color: const Color.fromARGB(62, 0, 0, 0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "🔔 Allow Notification to Get Update",
                      style: TextStyle(
                        fontFamily: Constant.haddingFont,
                        fontSize: size.width < 360 ? 12.0 : 12.0,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF033A44),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 8.0,
                      ),
                    ),
                    onPressed: () {
                      // handle allow action
                    },
                    child: Text(
                      "Allow",
                      style: TextStyle(
                        fontFamily: Constant.haddingFont,
                        fontSize: size.width < 360 ? 12.0 : 12.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: -8.0,
              top: -12.0,
              child: InkWell(
                onTap: () {
                  setState(() {
                    isVisible = false;
                  });
                },
                child: const CircleAvatar(
                  radius: 14.0,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.close, size: 16.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
