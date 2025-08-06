import 'package:flutter/material.dart';
import 'package:matchme/controller/mainpage_controller.dart';
import 'package:matchme/controller/match_controller.dart';
import 'package:matchme/widgets/profile_card.dart';
import 'package:provider/provider.dart';
import '../constant.dart';

class Match extends StatefulWidget {
  const Match({super.key});

  @override
  State<Match> createState() => _MatchState();
}

class _MatchState extends State<Match>{

  final PageController _profileSlideController = PageController();
  List<dynamic>? matchData;


  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<MatchController>(context, listen: false).getMatches();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    matchData = Provider.of<MatchController>(context, listen: true)
        .allMatches?['matches'] ?? [];

    if (Provider.of<MatchController>(context, listen: true)
        .allMatches == null || matchData == null) {
      return Scaffold(
        appBar: AppBar(
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
            icon: const Icon(Icons.arrow_back_rounded),
          ),
          title: Text(
            "Mathes",
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
    else if (Provider.of<MatchController>(context, listen: true)
        .allMatches!.isEmpty || matchData!.isEmpty) {
      return Scaffold(
        appBar: AppBar(
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
            icon: const Icon(Icons.arrow_back_rounded),
          ),
          title: Text(
            "Mathes",
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
                "No new matches available",
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

    return PopScope(
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
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
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
              icon: const Icon(Icons.arrow_back_rounded),
            ),
            title: Text(
              "Mathes",
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
                  itemCount: matchData!.length,
                  itemBuilder: (context, index) {
                    return ProfileCard(
                      userData: matchData![index]['match_user_id'],
                      index: index,
                      page: "match",
                    );
                  },
                ),
              ),

              // ::::::::::::::::::::::::::::::: BUTTONS :::::::::::::::::::::::::
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
      ),
    );
  }
}
