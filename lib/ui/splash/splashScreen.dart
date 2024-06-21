import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:valitag/main.dart';
import 'package:valitag/ui/readyToScan/ready_to_scan.dart';
import 'package:valitag/utils/gox.dart';
import 'package:valitag/utils/shared_preferences.dart';

import '../../constants/imageText/app_images.dart';
import '../loginScreen/login_screen.dart';

class SplashScreen extends StatefulWidget {

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigateToNextScreen();
  }

  Future<void> navigateToNextScreen() async {
   var at = sp?.getString(SpUtil.ACCESS_TOKEN) ?? "";
    await Future.delayed(Duration(seconds: 3));
    if(at.toString().isNotEmpty)
      {
        GoX.goPushRemoveUntil(const ReadyToScan());
      }
    else
      {
        GoX.goPushRemoveUntil(const LoginScreen());
      }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height ,
        width: MediaQuery.of(context).size.width ,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff007FC5) , // Start color
              Color(0xff0070C7) , // End color
            ],
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height /4 ,
              child: Column(
                children: [
                  Image.asset(AppImages.splashWifi , width: 200, height: 116),

                  Align(
                      alignment: Alignment.center,
                      child: Image.asset(AppImages.splashLogo, width: 243, height: 100)),

                ],
              ),
            ),


            Positioned(
              bottom: 50,
                child: Image.asset(AppImages.splashLines ,
                    width: MediaQuery.of(context).size.width, height: 320)
            ),
          ],
        ),
      ),
    );
  }
}
