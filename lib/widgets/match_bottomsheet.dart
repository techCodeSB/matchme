import 'package:flutter/material.dart';
import 'package:matchme/constant.dart';
import 'package:matchme/controller/interest_controller.dart';
import 'package:matchme/controller/match_controller.dart';
import 'package:matchme/widgets/my_snackbar.dart';
import 'package:provider/provider.dart';

class MatchBottomsheet extends StatefulWidget {
  final String id;
  final bool isDetail;
  const MatchBottomsheet({
    super.key,
    required this.id,
    this.isDetail = false,
  });

  @override
  State<MatchBottomsheet> createState() => _MatchBottomsheetState();
}

class _MatchBottomsheetState extends State<MatchBottomsheet> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.10,
      decoration: const BoxDecoration(
        // color: Constant.highlightColor,
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 197, 193, 193),
            blurRadius: 8.0,
            spreadRadius: 5.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Close || dislike Button;
          InkWell(
            onTap: () async {
              Provider.of<InterestController>(context, listen: false)
                  .sendInterest(widget.id, 2, context);

              Provider.of<MatchController>(context, listen: false).getMatches();
              if (context.mounted) {
                Navigator.pop(context, true);
              }

              mySnackBar(context, "Interest removed successfully");
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                    color: Constant.highlightColor,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: const Icon(
                    Icons.thumb_down_off_alt_outlined,
                    color: Colors.white,
                    size: 25.0,
                  ),
                ),
                const SizedBox(height: 5.0),
                const Text(
                  "Not Interested",
                  style: TextStyle(fontSize: 13.0),
                ),
              ],
            ),
          ),
          const SizedBox(width: 50.0),
          // Favorite button;
          InkWell(
            onTap: () async {
              Provider.of<InterestController>(context, listen: false)
                  .sendInterest(widget.id, 1, context);

              if (context.mounted) {
                Navigator.pop(context, true);
              }

              Provider.of<MatchController>(context, listen: false)
                  .removeMatch(widget.id);
              mySnackBar(context, "Interest send successfully");
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0C5461),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child:
                      const Icon(Icons.favorite_rounded, color: Colors.white),
                ),
                const SizedBox(height: 5.0),
                const Text(
                  "Interested",
                  style: TextStyle(fontSize: 13.0),
                ),
              ],
            ),
          ),
          const SizedBox(width: 50.0),
          // Bookmark
          InkWell(
            onTap: () async {
              Provider.of<InterestController>(context, listen: false)
                  .sendInterest(widget.id, 0, context);

              Provider.of<MatchController>(context, listen: false).getMatches();
              if (context.mounted) {
                if (widget.isDetail == true) {
                  Navigator.pop(context, true);
                  Navigator.pop(context, true);
                } else {
                  Navigator.pop(context, true);
                }
              }

              mySnackBar(context, "Bookmarked successfully");
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                    color: Constant.highlightColor,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: const Icon(
                    Icons.bookmark_outline_rounded,
                    color: Colors.white,
                    size: 25.0,
                  ),
                ),
                const SizedBox(height: 5.0),
                const Text(
                  "Save for Later",
                  style: TextStyle(fontSize: 13.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
