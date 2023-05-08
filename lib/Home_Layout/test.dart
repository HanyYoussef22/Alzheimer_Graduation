import 'dart:ui';

import 'package:flutter/material.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // The main screen content
        Scaffold(
          appBar: AppBar(
            title: Text('Scan Screen'),
          ),
          body: Center(
            child: ElevatedButton(
              child: Text('Start Scan'),
              onPressed: () {
                // Show the loading screen
                setState(() {
                  _isLoading = true;
                });

                // Simulate a scan process
                Future.delayed(Duration(seconds: 2), () {
                  // Hide the loading screen
                  setState(() {
                    _isLoading = false;
                  });
                });
              },
            ),
          ),
        ),

        // The loading screen with a blurred background
        if (_isLoading)
          Container(
            color: Colors.black54,
            child: Stack(
              children: [
                // The blurred background
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(color: Colors.white.withOpacity(0.1)),
                  ),
                ),

                // The loading indicator
                Center(child: CircularProgressIndicator()),
              ],
            ),
          ),
      ],
    );
  }
}
