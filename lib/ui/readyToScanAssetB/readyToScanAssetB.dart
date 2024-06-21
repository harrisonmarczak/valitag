import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:valitag/constants/fontFamily.dart';
import 'package:valitag/constants/imageText/app_images.dart';
import 'package:valitag/constants/text/app_text.dart';
import 'package:valitag/ui/readyToScanAssetNotification/readyToScanAssetNotification.dart';
import 'package:valitag/utils/gox.dart';

import '../startScanAsset/start_scan_asset.dart';

class ReadyToScanAssetB extends StatefulWidget {
  const ReadyToScanAssetB({super.key});

  @override
  State<ReadyToScanAssetB> createState() => _ReadyToScanState();
}

class _ReadyToScanState extends State<ReadyToScanAssetB> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: width,
          child: Stack(
            // fit: StackFit.loose,
            children: [

              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    AppText.routeA ,
                    style: TextStyle(
                      fontFamily: FontFamily.neueLight,
                      color: Color(0xff007FC5),
                      fontSize: 14,
                    ),
                  ),
                ),
              ),

              Container(
                height: height,
                width: width,
                child: Image.asset(AppImages.readyToScanBack),
              ),

              Positioned(
                top: 10, left: 100,
                child: Container(
                  alignment: Alignment.center,
                  height: height/2,
                  width: width/2,
                  child: Opacity(
                      opacity: 0.5,
                      child: Image.asset(AppImages.readyToScanWifi)),
                ),
              ),

              Positioned(
                top: 200, left: 140,
                child: Container(
                  height: height*0.4,
                  width: width*0.4,
                  child: Image.asset(AppImages.readyToScanNfc),
                ),
              ),

              Positioned(
                bottom: 10, left: width*0.08,
                child: Column(
                  children: [

                    Container(
                      child: Text(
                        AppText.readyToScan,
                        style: TextStyle(
                          fontFamily: FontFamily.neueMedium,
                          color: Color(0xff000000),
                          fontSize: 24,
                        ),
                      ),
                    ),

                    SizedBox(height: 20,),

                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      width: MediaQuery.of(context).size.width *0.8,
                      decoration: BoxDecoration(
                          color: Color(0xffEEF1F4),
                          borderRadius: BorderRadius.circular(10)
                      ),

                      child: Row(
                        children: [
                          Container(
                              height:25, width: 25,
                              child: Image.asset(AppImages.greenTickIcon)
                          ),

                          SizedBox(width: 10,),

                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  AppText.inspectionForStreet,
                                  style: TextStyle(
                                    fontFamily: FontFamily.neueLight,
                                    color: Color(0xff000000),
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                    SizedBox(height: 30,),

                    SizedBox(
                      width: MediaQuery.of(context).size.width/1.2,
                      height: MediaQuery.of(context).size.width/7.5,
                      child: ElevatedButton(
                        onPressed: () {
                          GoX.goPush(const ReadyToScanAssetNotification());
                        },

                        style: ElevatedButton.styleFrom(

                          backgroundColor: Color(0xff007FC5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                height: 18, width: 18,
                                child: Image.asset(AppImages.readyToScanButon)
                            ),

                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              AppText.viewRouteList,
                              style: TextStyle(
                                fontFamily: FontFamily.neueMedium,
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )



            ],
          ),
        ),
      ),
    );
  }
}
