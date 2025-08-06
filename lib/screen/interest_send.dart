import 'package:flutter/material.dart';
import 'package:matchme/controller/interest_controller.dart';
import 'package:matchme/widgets/profile_card.dart';
import 'package:provider/provider.dart';
import '../constant.dart';

class InterestSend extends StatefulWidget {
  const InterestSend({super.key});

  @override
  State<InterestSend> createState() => _InterestSendState();
}

class _InterestSendState extends State<InterestSend> {
  final PageController _profileSlideController = PageController();
  List<dynamic>? interestData;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<InterestController>(context, listen: false)
          .getInterestData(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    interestData = Provider.of<InterestController>(context, listen: true)
        .allInterest?['matches'];

    // :::::::::::::::::::::::::: Loading ::::::::::::::::::::::::
    if (Provider.of<InterestController>(context, listen: true).allInterest ==
            null) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_rounded),
          ),
          title: Text(
            "Interest Send",
            style: TextStyle(
              fontFamily: Constant.haddingFont,
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          scrolledUnderElevation: 0.0,
          // toolbarHeight: 70.0,
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    // :::::::::::::::::::::::::: No data ::::::::::::::::::::::::
    else if (Provider.of<InterestController>(context, listen: true)
            .allInterest!
            .isEmpty ||
        interestData!.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_rounded),
          ),
          title: Text(
            "interest Send",
            style: TextStyle(
              fontFamily: Constant.haddingFont,
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          scrolledUnderElevation: 0.0,
          // toolbarHeight: 70.0,
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.person_search_outlined,
                size: 70.0,
                color: Color.fromARGB(255, 223, 221, 221),
              ),
              const SizedBox(height: 20.0),
              Text(
                "No Interest available",
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

    // :::::::::::::::::::::::::: UI :::::::::::::::::::::::::
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_rounded),
          ),
          title: Text(
            "Interest Send",
            style: TextStyle(
              fontFamily: Constant.haddingFont,
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          scrolledUnderElevation: 0.0,
          // toolbarHeight: 70.0,
        ),
        body: ListView(
          children: [
            SizedBox(
              width: double.infinity,
              height: size.height * 0.68,
              child: PageView.builder(
                controller: _profileSlideController,
                itemCount: interestData!.length,
                itemBuilder: (context, index) {
                  return ProfileCard(
                    userData: interestData![index]['match_user_id'],
                    index: index,
                    page: "interestsend",
                  );
                },
              ),
            ),

            // ::::::::::::::::::::::::::::::: BUTTONS :::::::::::::::::::::::::::
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: () {
                      _profileSlideController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    color: Colors.white,
                    height: 55.0,
                    minWidth: 50.0,
                    elevation: 20.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(300.0),
                      // side: const BorderSide(
                      //   color: Color(0xFF033A44),
                      // ),
                    ),
                    child: const Icon(Icons.arrow_back_ios_rounded),
                  ),
                  const SizedBox(width: 50.0),
                  MaterialButton(
                    onPressed: () {
                      _profileSlideController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    elevation: 20.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(300.0),
                      // side: const BorderSide(
                      //   color: Color(0xFF033A44),
                      // ),
                    ),
                    color: Colors.white,
                    height: 55.0,
                    minWidth: 50.0,
                    child: const Icon(Icons.arrow_forward_ios_rounded),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
