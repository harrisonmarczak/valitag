import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:valitag/utils/gox.dart';

class ImageFullScreen extends StatelessWidget {
  String imagePath;
   ImageFullScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            GoX.goPop();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white,),
        ),

    ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: imagePath.contains('https') ? Image.network(imagePath) : Image.asset(imagePath),
        ),
      ),
    );
  }
}
