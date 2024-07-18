import 'package:flutter/material.dart';

class ImageList extends StatelessWidget {
  final List<String> images;

  const ImageList({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 25),
      child: Column(
        children: images
            .map((url) =>
                Image.network(url, height: images.length > 1 ? 150 : 300))
            .toList(),
      ),
    );
  }
}
