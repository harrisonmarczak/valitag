import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:valitag/constants/fontFamily.dart';
import 'package:valitag/constants/imageText/app_images.dart';
import 'package:valitag/constants/text/app_text.dart';
import 'package:valitag/ui/readyToScanAsset1/readyToScanAsset1.dart';
import 'package:valitag/utils/common_widget.dart';
import 'package:valitag/utils/gox.dart';

import '../../providers/common_provider.dart';
import '../helpScreen/help_screen.dart';
import '../routeList/route_list.dart';
import '../startScanAsset/start_scan_asset.dart';

class ReadyToScan extends StatefulWidget {
  const ReadyToScan({super.key});

  @override
  State<ReadyToScan> createState() => _ReadyToScanState();
}

class _ReadyToScanState extends State<ReadyToScan> {



  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Consumer<CommonProvider>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: customAppBar( context: context ,showLeadingIcon: false, showMenuButton: true) ,

          body: SafeArea(
            child: Container(
              width: width,
              child: Stack(
                // fit: StackFit.loose,
                children: [
        //RouteA Text
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: const Text(
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
                        opacity: 0.3,
                          child: Image.asset(AppImages.readyToScanWifi)),
                    ),
                  ),

                  Positioned(
                    top: 200, left: 140,
                    child: GestureDetector(
                      onTap: () {
                        GoX.goPush(StartScanAsset());
                      },
                      child: Container(
                        height: height*0.4,
                        width: width*0.4,
                        child: Image.asset(AppImages.readyToScanNfc),
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 24, left: width*0.08,
                    child: Column(
                      children: [

                        Container(
                          child: const Text(
                            AppText.readyToScan,
                            style: TextStyle(
                              fontFamily: FontFamily.neueMedium,
                              color: Color(0xff000000),
                              fontSize: 24,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),

                        SizedBox(
                          width: MediaQuery.of(context).size.width/1.2,
                          height: 54,
                          child: ElevatedButton(
                            onPressed: () {
                              value.routeListApi(id:1234);
                              mDialog(context, RouteListDialog(title: "Route List",));
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
                                    fontFamily: FontFamily.neueLight ,
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),

                                SizedBox(height: 30,),
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
    );
  }
}
