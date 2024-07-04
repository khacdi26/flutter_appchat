import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 25),
      decoration: BoxDecoration(
          color: isCurrentUser
              ? Colors.blue
              : Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12)),
      child: Text(
        message,
        style: TextStyle(
          color: isCurrentUser
              ? Theme.of(context).colorScheme.tertiary
              : Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
    );
  }
}
