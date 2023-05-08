import 'package:flutter/material.dart';

class ImageDetailsScreen extends StatelessWidget {
  final String imageUrl;

  ImageDetailsScreen({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
