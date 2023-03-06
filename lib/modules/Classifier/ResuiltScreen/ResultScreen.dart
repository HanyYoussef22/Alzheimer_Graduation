import 'dart:io';

import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  File? _image;
  List? _outputs;

  ResultScreen(this._image, this._outputs);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
          ),
          Image.file(_image!),
          const SizedBox(
            height: 30,
          ),
          _outputs == null
              ? Container()
              : Positioned(
                  bottom: 20,
                  right: 50,
                  child: Text(
                    "${_outputs![0]["label"]}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      background: Paint()..color = Colors.transparent,
                    ),
                  ),
                ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
