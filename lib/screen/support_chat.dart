import 'package:flutter/material.dart';
import 'package:matchme/constant.dart';
import 'package:matchme/controller/profile_controller.dart';
import 'package:matchme/controller/support.controller.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SupportChat extends StatefulWidget {
  const SupportChat({
    super.key,
  });

  @override
  State<SupportChat> createState() => _SupportChatState();
}

class _SupportChatState extends State<SupportChat> {
  List<dynamic>? chats;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<SupportController>(context, listen: false).changeReadStatus();

      await Provider.of<SupportController>(context, listen: false)
          .getAllChats();

      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    chats = Provider.of<SupportController>(context, listen: true).allChats;

    // :::::::::::::::::::::::::: Loading ::::::::::::::::::::::::
    if (Provider.of<SupportController>(context, listen: true).allChats ==
        null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Chat",
            style: TextStyle(fontFamily: Constant.haddingFont),
          ),
          centerTitle: true,
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chat",
          style: TextStyle(fontFamily: Constant.haddingFont),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Provider.of<SupportController>(context, listen: false)
              .getAllChats();
        },
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(), // 👈 important
          controller: _scrollController,
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            bottom: 200.0,
          ),
          itemCount: chats!.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> chat = chats![index];
            Alignment align = chat['message_by'] == "admin"
                ? Alignment.centerLeft
                : Alignment.centerRight;
            BorderRadius radius = chat['message_by'] == "admin"
                ? const BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  )
                : const BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                  );

            return Align(
              alignment: align,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  chat['message_by'] == "admin"
                      ? const Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: const CircleAvatar(
                            radius: 15,
                            child: Icon(Icons.support_agent),
                          ),
                        )
                      : const SizedBox.shrink(),
                  //

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 10.0,
                    ),
                    margin: const EdgeInsets.only(top: 10.0),
                    decoration: BoxDecoration(
                      color: chat['message_by'] == "admin"
                          ? Constant.highlightColor
                          : const Color(0xFF245C66),
                      borderRadius: radius,
                    ),
                    child: Text(
                      chat['message'],
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),

                  //
                  chat['message_by'] == "user"
                      ? (Provider.of<ProfileController>(context, listen: true)
                                  .userData['image']?["one"] ==
                              null
                          ? const CircleAvatar(
                              radius: 15,
                              child: Icon(Icons.account_circle),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: CircleAvatar(
                                radius: 15,
                                backgroundImage: NetworkImage(
                                  "${Constant.imageUrl}${Provider.of<ProfileController>(context, listen: true).userData['image']["one"]}",
                                ),
                              ),
                            ))
                      : const SizedBox.shrink()
                ],
              ),
            ).animate().fadeIn(duration: 300.ms).slideY(
                  begin: chat['message_by'] == "admin" ? 0 : 0.3,
                  end: chat['message_by'] == "admin" ? 0.3 : 0,
                  duration: 300.ms,
                  curve: Curves.easeOut,
                );
          },
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        height: size.height * 0.2,
        padding: const EdgeInsets.only(right: 10.0, left: 10.0, bottom: 10.0),
        color: Colors.transparent,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                maxLines: 4,
                controller:
                    Provider.of<SupportController>(context, listen: false).chat,
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  hintText: "Message...",
                  hintStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Color(0xFF245C66),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      topLeft: Radius.circular(20.0),
                    ),
                    borderSide: BorderSide(color: Color(0xFF245C66)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      topLeft: Radius.circular(20.0),
                    ),
                    borderSide: BorderSide(color: Color(0xFF245C66)),
                  ),
                ),
              ),
            ),
            // const SizedBox(width: 10.0),
            InkWell(
              onTap: () {
                _scrollController
                    .jumpTo(_scrollController.position.maxScrollExtent);
                Provider.of<SupportController>(context, listen: false)
                    .addChat(context);
              },
              child: Container(
                width: 55.0,
                height: 128.0,
                decoration: const BoxDecoration(
                  color: Color(0xFF245C66),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: const Icon(
                  Icons.send,
                  color: Colors.white,
                  size: 30.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
