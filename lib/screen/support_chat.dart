import 'package:flutter/material.dart';
import 'package:matchme/constant.dart';
import 'package:matchme/controller/support.controller.dart';
import 'package:provider/provider.dart';

class SupportChat extends StatefulWidget {
  final String apTitle;
  final String msgId;
  const SupportChat({
    super.key,
    required this.apTitle,
    required this.msgId,
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
      Provider.of<SupportController>(context, listen: false)
          .changeReadStatus(widget.msgId);

      await Provider.of<SupportController>(context, listen: false)
          .getAllChats(widget.msgId);

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
            widget.apTitle,
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
            .getAllChats(widget.msgId);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.apTitle,
            style: TextStyle(fontFamily: Constant.haddingFont),
          ),
          centerTitle: true,
        ),
        body: ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.only(
            top: 20.0,
            left: 20.0,
            right: 20.0,
            bottom: 120.0,
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
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0,),
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
            );
          },
        ),
        bottomSheet: Container(
          width: double.infinity,
          height: size.height * 0.2,
          padding: const EdgeInsets.all(10.0),
          color: Colors.transparent,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  maxLines: 4,
                  controller:
                      Provider.of<SupportController>(context, listen: false)
                          .chat,
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
                  Provider.of<SupportController>(context, listen: false)
                      .addChat(widget.msgId, context);
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
      ),
    );
  }
}
