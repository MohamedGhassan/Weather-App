import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  const Responsive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final appBar = AppBar(title: Text("Hello"),);
    final bodyHeight = screenHeight - appBar.preferredSize.height - MediaQuery.of(context).padding.top;
    print(screenWidth);
    print(screenWidth);

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            color: Colors.blue,
            height: bodyHeight * 0.33,
          ),
          Container(
            color: Colors.red,
            height: bodyHeight * 0.33,
          ),
          Container(
            color: Colors.black54,
            height: bodyHeight * 0.34,
          ),
        ],
      ),
    );
  }
}
