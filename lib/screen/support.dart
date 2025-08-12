import 'package:flutter/material.dart';
import 'package:matchme/constant.dart';
import 'package:matchme/controller/support.controller.dart';
import 'package:matchme/screen/support_chat.dart';
import 'package:provider/provider.dart';

class Support extends StatefulWidget {
  const Support({super.key});

  @override
  State<Support> createState() => _SupportState();
}

class _SupportState extends State<Support> {
  String selectedQueryType = "";
  List<dynamic>? previousTickets;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<SupportController>(context, listen: false)
          .getAllTicketMsg();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    previousTickets =
        Provider.of<SupportController>(context, listen: true).allTicketMsg;

    // :::::::::::::::::::::::::: Loading ::::::::::::::::::::::::
    if (Provider.of<SupportController>(context, listen: true).allTicketMsg ==
        null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Support",
            style: TextStyle(fontFamily: Constant.haddingFont),
          ),
          centerTitle: true,
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await Provider.of<SupportController>(context, listen: false)
            .getAllTicketMsg();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Support",
            style: TextStyle(fontFamily: Constant.haddingFont),
          ),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            Container(
              width: double.infinity,
              height: size.height * 0.3 / 2,
              // alignment: Alignment.center,
              child: Wrap(
                spacing: 10.0,
                children: Provider.of<SupportController>(context, listen: true)
                    .chips
                    .map((text) {
                  return FilterChip(
                    label: Text(text),
                    selectedColor: Constant.highlightColor,
                    selected: text == selectedQueryType ? true : false,
                    onSelected: (value) {
                      setState(() {
                        if (text == selectedQueryType) {
                          selectedQueryType = "";
                        } else {
                          selectedQueryType = text;
                        }
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  );
                }).toList(),
              ),
            ),
            TextField(
              controller: Provider.of<SupportController>(context, listen: false)
                  .supportMsg,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Message...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: MaterialButton(
                onPressed: () {
                  Provider.of<SupportController>(context, listen: false)
                      .sendMessage(context, selectedQueryType);
                },
                color: const Color(0xFF245C66),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text(
                  "Send",
                  style: TextStyle(
                    fontFamily: Constant.subHadding,
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            // ::::::::::::::::::::::::::::::: PREVIOUS TICKETS :::::::::::::::::::::::::
            Provider.of<SupportController>(context, listen: true)
                    .allTicketMsg!
                    .isNotEmpty
                ? Text(
                    "Previous Tickets",
                    style: TextStyle(
                      fontFamily: Constant.subHadding,
                      fontSize: 20.0,
                    ),
                  )
                : Text(
                    "No Tickets available",
                    style: TextStyle(
                      fontFamily: Constant.subHadding,
                      fontSize: 20.0,
                    ),
                  ),

            ListView.builder(
              itemCount: previousTickets!.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SupportChat(
                          apTitle: previousTickets![index]['Qtype'],
                          msgId: previousTickets![index]['_id'],
                        ),
                      ),
                    ).then((v) async {
                      await Provider.of<SupportController>(
                        context,
                        listen: false,
                      ).getAllTicketMsg();
                    });
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        border: Border(
                      bottom: BorderSide(
                        color: Color.fromARGB(255, 224, 224, 224),
                      ),
                    )),
                    child: ListTile(
                      title: Text(
                        previousTickets![index]['Qtype'],
                        style: TextStyle(
                          fontSize: 13.0,
                          fontFamily: Constant.subHadding,
                        ),
                      ),
                      subtitle: Text(
                        "${previousTickets![index]['lastMessage']['message_by'] == "user" ? "You" : "Admin"}:\t${previousTickets![index]['lastMessage']['message']}",
                        style: TextStyle(
                          fontSize: 10.0,
                          fontFamily: Constant.subHadding,
                        ),
                      ),
                      leading: const CircleAvatar(
                        backgroundColor: Color(0xFF245C66),
                        radius: 20.0,
                        child: Icon(
                          Icons.chat_rounded,
                          color: Colors.white,
                          size: 18.0,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
