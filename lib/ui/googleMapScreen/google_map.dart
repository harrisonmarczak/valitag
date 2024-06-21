import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:valitag/utils/gox.dart';

class GoogleMap extends StatefulWidget {
  const GoogleMap({super.key});

  @override
  State<GoogleMap> createState() => _GoogleMapState();
}

class _GoogleMapState extends State<GoogleMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map"),
        leading: IconButton(
            onPressed: () {
              GoX.goPop();
            },
            icon: Icon(Icons.arrow_back)),
        centerTitle: true,
      ),
      body: Center(
        child: GestureDetector(
          onTap: () =>  MapsLauncher.launchQuery('1600 Amphitheatre Pkwy, Mountain View, CA 94043, USA'),
          child: Text("Open Map"),
        ),
      ),
    );
  }
}
