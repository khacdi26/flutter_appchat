import 'package:flutter/material.dart';

class UserTitle extends StatelessWidget {
  final String text;
  final void Function()? ontap;
  const UserTitle({
    super.key,
    required this.text,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 25,
        ),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            //icon
            const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.person),
            ),
            //user name
            Text(text),
          ],
        ),
      ),
    );
  }
}
