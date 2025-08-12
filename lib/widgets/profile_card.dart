import 'package:flutter/material.dart';
import 'package:matchme/constant.dart';
import 'package:matchme/controller/interest_controller.dart';
import 'package:matchme/controller/match_controller.dart';
import 'package:matchme/helper/capitalize.dart';
import 'package:matchme/helper/get_age_from_dob.dart';
import 'package:matchme/screen/user_profile.dart';
import 'package:provider/provider.dart';

class ProfileCard extends StatefulWidget {
  final Map<String, dynamic> userData;
  final int index;
  final String page;
  const ProfileCard({
    super.key,
    required this.userData,
    required this.index,
    required this.page,
  });

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.65,
      margin: EdgeInsets.only(
        bottom: size.width * 0.05,
        left: size.width * 0.05,
        right: size.width * 0.05,
        top: size.width * 0.03,
      ),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40.0),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 203, 198, 198),
            blurRadius: 10.0,
            spreadRadius: 5.0,
          ),
        ],
        border: Border.all(
          color: const Color.fromARGB(179, 175, 171, 171),
          width: 1.0,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                    "${Constant.imageUrl}${widget.userData['image']['one']}",
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: size.height * 0.7 / 2,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  (loadingProgress.expectedTotalBytes ?? 1)
                              : null, // null makes it indeterminate
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "${widget.userData['full_name']}, ${getAgeFromYMD(widget.userData['dob'])}",
                    style: TextStyle(
                      fontFamily: Constant.haddingFont,
                      color: const Color(0xFF0C5461),
                      fontSize: 23.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(
                            Icons.location_on_rounded,
                            color: Constant.highlightColor,
                            size: 20.0,
                          ),
                        ),
                        TextSpan(
                          text:
                              "\t${capitalize(widget.userData['country'])}, ${capitalize(widget.userData['city'])}",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: Constant.subHadding,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "${widget.userData['about_yourself'].length > 50 ? (widget.userData['about_yourself']).substring(0, 50) : widget.userData['about_yourself']}${"..."}",
                    style: TextStyle(
                      fontFamily: Constant.subHadding,
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                  ),
                )
              ],
            ),
          ),
          MaterialButton(
            onPressed: () {
              if (widget.page == "match") {
                Provider.of<MatchController>(context, listen: false)
                    .setProfileDetails(widget.index);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserProfile(page: widget.page),
                  ),
                ).then((v) {
                  if (v == true) {
                    Provider.of<MatchController>(context, listen: false)
                        .getMatches();
                  }
                });
              } else if (widget.page == "interestsend") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserProfile(
                      page: widget.page,
                    ),
                  ),
                ).then((v) {
                  if (v == true) {
                    Provider.of<MatchController>(context, listen: false)
                        .getMatches();
                  }
                });
                Provider.of<InterestController>(context, listen: false)
                    .setProfileDetails(widget.index, context, "send");
              } else if (widget.page == "interestreceive") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserProfile(
                      page: widget.page,
                    ),
                  ),
                ).then((v) {
                  if (v == true) {
                    Provider.of<MatchController>(context, listen: false)
                        .getMatches();
                  }
                });
                Provider.of<InterestController>(context, listen: false)
                    .setProfileDetails(widget.index, context, 'receive');
              } else if (widget.page == "connection") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserProfile(
                      page: widget.page,
                    ),
                  ),
                ).then((v) {
                  if (v == true) {
                    Provider.of<MatchController>(context, listen: false)
                        .getMatches();
                  }
                });
                Provider.of<InterestController>(context, listen: false)
                    .setProfileDetails(widget.index, context, 'connection');
              }
            },
            color: const Color.fromARGB(255, 224, 223, 223),
            minWidth: size.width / 2,
            height: 50.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Text(
              'View Profile',
              style: TextStyle(
                fontFamily: Constant.haddingFont,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 19.0,
              ),
            ),
          ),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
