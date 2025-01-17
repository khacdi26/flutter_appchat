import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_chat/components/chat_bubble.dart';
import 'package:flutter_app_chat/components/custom_bottomsheet.dart';
import 'package:flutter_app_chat/components/custom_textfield.dart';
import 'package:flutter_app_chat/components/img_message.dart';
import 'package:flutter_app_chat/services/auth/auth_service.dart';
import 'package:flutter_app_chat/services/chat/chat_service.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverID;

  const ChatPage({
    super.key,
    required this.receiverEmail,
    required this.receiverID,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  //text controller
  final TextEditingController _messageController = TextEditingController();

  // chat & aut services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();
  List<DocumentSnapshot> messagesList = [];

  // textfield focus
  FocusNode myFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();

    //add listener to focus node
    myFocusNode.addListener(
      () {
        if (myFocusNode.hasFocus) {
          Future.delayed(
            const Duration(milliseconds: 550),
            () => scrollDown(),
          );
        }
      },
    );
    Future.delayed(
      const Duration(milliseconds: 500),
      () => scrollDown(),
    );
    _loadMessages();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  //scroll controller
  final ScrollController _scrollController = ScrollController();
  void scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.minScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  //send message
  void sendMessage() async {
    //check empty textfield
    if (_messageController.text.isNotEmpty) {
      setState(() {
        _isSendingMessage = true;
      });
      //send message
      await _chatService.sendMessage(
        widget.receiverID,
        message: _messageController.text,
      );
    }
    //clear textfield
    _messageController.clear();
    setState(() {
      _isSendingMessage = false;
    });
    //scrolldown
    scrollDown();
  }

  bool _isSendingMessage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(widget.receiverEmail),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
      ),
      body: Column(
        children: [
          //display all message
          Expanded(
            child: _buildMessagesList(),
          ),

          //user input
          _buildUserInput(context),
        ],
      ),
    );
  }

  Widget _buildMessagesList() {
    return ListView.builder(
      reverse: true,
      padding: const EdgeInsets.only(bottom: 25.0),
      controller: _scrollController,
      itemCount: messagesList.length,
      itemBuilder: (context, index) => _buildMessagesItem(messagesList[index]),
    );
  }

  Widget _buildMessagesItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    // nếu tin nhắn của người gửi thì chuyển hết về bên phải
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    Widget messageWidget;

    if (data["message"] != null) {
      // Hiển thị tin nhắn
      messageWidget =
          ChatBubble(message: data["message"], isCurrentUser: isCurrentUser);
    } else if (data["fileURLs"] != null &&
        (data["fileURLs"] as List).isNotEmpty) {
      // Hiển thị file URLs nếu tin nhắn là null và có URLs
      List<String> fileURLs = List<String>.from(data["fileURLs"]);
      messageWidget = ImageList(images: fileURLs);
    } else {
      // Trường hợp không có tin nhắn hoặc file URLs
      messageWidget = const Text('No message or file URLs');
    }

    return Container(
      alignment: alignment,
      child: messageWidget,
    );
  }

  Widget _buildUserInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return CustomBottomsheet(receiverID: widget.receiverID);
                },
              );
            },
            icon: const Icon(
              Icons.image,
              color: Colors.blue,
              size: 36.0,
            ),
          ),
          // text field
          Expanded(
            child: CustomTextField(
              controller: _messageController,
              hintText: "Type a message",
              obscureText: false,
              focusNode: myFocusNode,
            ),
          ),
          // send button
          Container(
            decoration: const BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(right: 15.0),
            child: IconButton(
              onPressed: _isSendingMessage ? null : sendMessage,
              icon: const Icon(
                Icons.arrow_upward,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _loadMoreMessages() {
    String senderID = _authService.getCurrentUser()!.uid;
    _chatService
        .getMessages(widget.receiverID, senderID,
            lastVisible: messagesList.last)
        .listen((snapshot) {
      setState(() {
        messagesList.addAll(snapshot.docs);
      });
    });
  }

  void _loadMessages() {
    String senderID = _authService.getCurrentUser()!.uid;
    _chatService.getMessages(widget.receiverID, senderID).listen((snapshot) {
      setState(() {
        messagesList = (snapshot.docs);
      });
    });
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMoreMessages();
    }
  }
}
