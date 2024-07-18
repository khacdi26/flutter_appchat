import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/chat/chat_service.dart';

class CustomBottomsheet extends StatefulWidget {
  final String receiverID;
  const CustomBottomsheet({super.key, required this.receiverID});

  @override
  State<CustomBottomsheet> createState() => _CustomBottomsheetState();
}

class _CustomBottomsheetState extends State<CustomBottomsheet> {
  // ignore: prefer_final_fields
  List<File> _list = [];
  final picker = ImagePicker();
  final ChatService _chatService = ChatService();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.blue,
                ),
              ),
              const Text(
                "Choose images",
                style: TextStyle(color: Colors.blue),
              ),
              IconButton(
                onPressed: () {
                  sendFile().whenComplete(() => Navigator.pop(context));
                },
                icon: const Icon(
                  Icons.send,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GridView.builder(
                    shrinkWrap: true, // this is important
                    physics:
                        const NeverScrollableScrollPhysics(), // to disable GridView's own scrolling
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    itemCount: _list.length + 1,
                    itemBuilder: (context, index) {
                      return index == 0
                          ? Center(
                              child: IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  chooseImages();
                                },
                              ),
                            )
                          : Container(
                              margin: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: FileImage(_list[index - 1]),
                                fit: BoxFit.cover,
                              )),
                            );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  chooseImages() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(
      () {
        _list.add(File(pickedFile!.path));
      },
    );
  }

  Future sendFile() async {
    List<String> fileURLs = await _chatService.uploadFiles(_list);
    await _chatService.sendMessage(widget.receiverID, files: fileURLs);
  }
}
