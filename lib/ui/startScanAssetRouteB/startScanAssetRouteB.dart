import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:valitag/constants/fontFamily.dart';
import 'package:valitag/constants/imageText/app_images.dart';
import 'package:valitag/dialog/common_dialog.dart';
import 'package:valitag/dialog/image_dialog.dart';
import 'package:valitag/ui/readyToScanAsset1/readyToScanAsset1.dart';
import 'package:valitag/ui/readyToScanAssetNotification/readyToScanAssetNotification.dart';
import 'package:valitag/utils/SingleTapEvent.dart';
import 'package:valitag/utils/common_widget.dart';

import '../../constants/text/app_text.dart';
import '../../dialog/imageDialogB.dart';
import '../../providers/imageDialogProvider.dart';
import '../../utils/gox.dart';
import '../bottomSheet/bottom_sheet.dart';
import '../fullScreen/image_fullscreen.dart';
import '../readyToScan/ready_to_scan.dart';

class StartScanAssetRouteB extends StatefulWidget {

  const StartScanAssetRouteB({super.key});

  @override
  State<StartScanAssetRouteB> createState() => _StartScanAssetState();
}

class _StartScanAssetState extends State<StartScanAssetRouteB> {

  // Future.microtask(() {
  // context.read<CommonProvider>().deviceTypeFunc();
  // });

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // startFunc();

  }

  startFunc() {
    Future.microtask(() {
      context.read<ImageDialogProvider>().emptyFunc();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      body: Stack(

        children: [

          SafeArea(
            child: Column(
              children: [
                SizedBox(height: 10,),
                Text(
                  AppText.routeB ,
                  style: TextStyle(
                    fontFamily: FontFamily.neueMedium,
                    color: Color(0xff007FC5),
                    fontSize: 14,
                  ),
                ),

                SizedBox(height: 30,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: 25, width: 25,
                        child: Image.asset(AppImages.startScanLocationPinIcon)),
                    SizedBox(width: 10,),

                    Column(
                      children: [
                        Text(
                          AppText.startScanAddress ,
                          style: TextStyle(
                            fontFamily: FontFamily.neueMedium,
                            color: Color(0xff000000),
                            fontSize: 20,
                          ),
                        ),
                        // Container(
                        //   height: 2, width: MediaQuery.of(context).size.width *0.55,
                        //   color: Colors.blue,
                        // )
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 10,),
          //InspectedAt
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: 20, width: 20,
                        child: Image.asset(AppImages.startScanClockIcon)),
                    SizedBox(width: 10,),
                    Text(
                      AppText.startScanInspectedTime ,
                      style: TextStyle(
                        fontFamily: FontFamily.neueLight,
                        color: Color(0xff434343),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10,),

                GestureDetector(
                  onTap: () {
                    GoX.goPush(ImageFullScreen(imagePath: AppImages.aquariumImage,));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height /4 , width: MediaQuery.of(context).size.width /1.3 ,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      // color: Colors.red,
                    ),
                    child: Image.asset(AppImages.aquariumImage),
                  ),
                ),

                SizedBox(height: 10,),

                Text(
                  AppText.startScanRouteBUnschedule ,
                  style: TextStyle(
                    fontFamily: FontFamily.neueMedium,
                    color: Color(0xffFF0000),
                    fontSize: 25,
                  ),
                ),



                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80),
                      child: Text(
                          AppText.startScanRouteBThisAsset,
                         textAlign: TextAlign.center,
                         style: TextStyle(
                           fontFamily: FontFamily.neueLight,
                           fontSize: 13,
                           color: Color(0xff686868),
                         ),
                      ),
                    ),
                  ],
                ),


              ],
            ),
          ),

          CustomBottomSheet(fromScreen: "Unscheduled",),



//           Container(
//             height: MediaQuery.of(context).size.height*0.36,
//             width: MediaQuery.of(context).size.width,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   Color(0xff007FC5), // Start color
//                   Color(0xff0070C7), // End color
//                 ],
//               ),
//             ),
//             child: Column(
//               children: [
//                 SizedBox(height: 10,),
//                 Container(
//                   height: 2, width: 20,
//                   color: Colors.white,
//                 ),
//
//                 SizedBox(height: 30,),
//
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
// //AddNotesButton
//                     GestureDetector(
//                       onTap : () {
//                         mDialog(context, CommonDialog(
//                           title: "Add Notes",
//                         ));
//                       },
//                       child: Container(
//                         height: 50, width: MediaQuery.of(context).size.width/2.5,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             color: Color(0x33000000)
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Container(
//                                 height: 20, width : 20,
//                                 child: Image.asset(AppImages.startScanDocIcon)
//                             ),
//
//                             SizedBox(width: 10,),
//
//                             const Text(
//                               AppText.startScanAddNotes ,
//                               style: TextStyle(
//                                 fontFamily: FontFamily.neueLight,
//                                 color: Color(0xffFFFFFF),
//                                 fontSize: 14,
//                               ),
//                             ),
//
//                           ],
//                         ),
//                       ),
//                     ),
// //AddPhotosButton
//                     SingleTapEvent(
//                       onTap: () {
//                         // CommonImageDialog
//                         mDialog(context, CommonImageDialog(
//                           title: "Add Photos",
//                         ));
//                       },
//
//                       child: Container(
//                         height: 50, width: MediaQuery.of(context).size.width/2.5,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             color: Color(0x33000000)
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Container(
//                                 height: 20, width : 20,
//                                 child: Image.asset(AppImages.startScanCameraIcon)
//                             ),
//
//                             SizedBox(width: 10,),
//
//                             const Text(
//                               AppText.startScanAttachPhotos ,
//                               style: TextStyle(
//                                 fontFamily: FontFamily.neueLight,
//                                 color: Color(0xffFFFFFF),
//                                 fontSize: 14,
//                               ),
//                             ),
//
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 SizedBox(height: 30,),
//
//  //SubmitButton
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width/1.2,
//                   height: MediaQuery.of(context).size.width/7.5,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       GoX.goPush(const ReadyToScanAsset1());
//                       // mDialog(context, CommonDialog(
//                       //   title: "Add Notes",
//                       // ));
//                     },
//
//                     style: ElevatedButton.styleFrom(
//
//                       backgroundColor: Color(0xffFFFFFF),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30.0),
//                       ),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Container(
//                             height: 20, width : 20,
//                             child: Image.asset(AppImages.startScanUploadIcon)
//                         ),
//                         SizedBox(width: 10,),
//                         Text(
//                           AppText.startScanSubmit,
//                           style: TextStyle(
//                             fontFamily: FontFamily.neueMedium,
//                             color: Color(0xff0070C7),
//                             fontSize: 16,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: 40,),
// //CancelButton
//                 GestureDetector(
//                   onTap: () {
//                     GoX.goPop();
//                   },
//                   child: Container(
//                       height: 25, width : 25,
//                       child: Image.asset(AppImages.startScanBlockingIcon)
//                   ),
//                 ),
//               ],
//             ),
//           ),

        ],
      ),
    );
  }
}
